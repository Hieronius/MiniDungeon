/*
 Info: The mini boss has a super attack in his sleeves - he spend a few energy points (1...all points) to cast a special attack. Mini game appears where you should use your finger to collect shadow balls. There should be 10 of them so each ball gives you 10% resist to boss attack. Collect all of them and you avoid attack entirely, so the boss can be much stronger than average enemy.
 
 - Amount of predefined balls -10
 - User can drag a special rect view as it's shield
 - Balls are moving from left to right
 - Platform being moved from top to bottom
 - Platform should be placed at the right side of the view
 - Each collision of the ball with platform should anime view with green
 - May be add a label of current success/failure as you did in combat view when ball collides with the platform or view itself
 - when ball hits the view you should animete it with red and may be shake the view
 - game should start automatically, it's mean that when enemy decided to use this skill it will immediately run "startGame" method
 - You can use MotionController to create a platform with a drag gesture and define it's max and min Y Coordinate range to be moved only between of
 
 
 --------Internals of mini game:
 1. Create MotionObjectController or use preexisting one from chest mini game
 2. Create method to generate schemes for objects behaviour
 3. Create method to apply such a scheme for objects
 4. Each object should run (apply it's scheme) with a little delay, probably should use DispatchQueue
 5. Instead of "DetectObjectPosition" create a method "DetectBallAndPlatformCollision"
 6. Such a method should run when ball collides with the platform or view itself
 7. Because this mini game should be ran inside the BattleView it's effect should be immediate which mean deal damage to the hero for each ball that collides with the view it'self.
 8. Damage done should be cumulutive, include method "checkWinLoseCondition" after last ball collides, even if there will be -100/100 hero hp
 9. Make balls purple and platform as yellow
 */

import SwiftUI

extension MainView {
	
	/// Test method to call shadowBallMiniGame independently
	@ViewBuilder
	func buildShadowBallMiniGameView() -> some View {
		
		VStack {
			ShadowBallMiniGameView()
		}
		.frame(width: 400, height: 400)
	}
}

struct ShadowBallMiniGameView: View {
	
	@State private var lastUpdate = Date()
	@State var testTimer = Date()
	
	/// Property to detect was game started or not to prevent clicking bottom buttons before game start
	@State var gameWasStarted = false
	@State var ballsAreHidden = false
	
	@State var gameResult = "             "
	@State var isSuccess = false
	
	@State var successCatches = 0
	@State var failedCatches = 0
	@State var boardColor: Color = .white
	
	@State var dragPlatformTemporaryTranslationPositionOnScreen: CGSize = .zero
	@State var platformBeingDragged = false
	
	@State var isHapticOn = false
	
	 // MARK: Change 3
	 
	/// Motion Object to describe the shadow ball
	 @State var motions: [MotionController] = [
	 
		MotionController(id: 1, coordinateX: -400.0, width: 30, height: 30),
	 MotionController(id: 2, coordinateX: -400.0, width: 30, height: 30),
	 MotionController(id: 3, coordinateX: -400.0, width: 30, height: 30),
	 MotionController(id: 4, coordinateX: -400.0, width: 30, height: 30),
	 MotionController(id: 5, coordinateX: -400.0, width: 30, height: 30),
	 MotionController(id: 6, coordinateX: -400.0, width: 30, height: 30),
	 MotionController(id: 7, coordinateX: -400.0, width: 30, height: 30),
	 MotionController(id: 8, coordinateX: -400.0, width: 30, height: 30),
	 MotionController(id: 9, coordinateX: -400.0, width: 30, height: 30),
	 MotionController(id: 10, coordinateX: -400.0, width: 30, height: 30)
	 
	 ]
	
	@State var platformMotion = MotionController(id: 11,
												 coordinateY: 0,
												 coordinateX: 100,
												 width: 25,
												 height: 50)
	
	// MARK: - Public Properties
	
	/// This callback we send to parent view to react on game result
	var onImpact: ((Bool) -> Void)? // Callback for game result
	
	/// The flag to signal that game was ended (10 balls where sent)
	var didGameEnd: ((Bool) -> Void)?
	
	// MARK: - Body
	
	var body: some View {
		
		// MARK: - Header
		
		VStack {
			
			Text(gameResult)
				.foregroundStyle(isSuccess ? .green : .red)
			
			// MARK: - Body
			
			TimelineView(.animation) { context in
				
				ZStack {
					
					Rectangle()
						.frame(width: UIScreen.main.bounds.width, height: 250)
						.foregroundStyle(.black)
						.border(boardColor, width: 5)
					
					if gameWasStarted {
						
						 // MARK: Motion Objects 1 - 10
						 
						 ForEach(motions.indices, id: \.self) { index in
						 
						 let motion = motions[index]
						 
						 Image(systemName: motion.isMoving ? "circle.fill" : "circle")
							 .resizable() // 1. IMPORTANT: This lets the icon scale
							 .aspectRatio(contentMode: .fit)
							 .frame(width: motion.width, height: motion.height)
							 .foregroundStyle(.purple)
							 .background(.black)
							 .labelStyle(.iconOnly)
							 .clipShape(Circle())
							 .offset(x: motion.coordinateX,
									 y: motion.coordinateY) // add offSet Y to lower or make it higher from the middle
						 //					.opacity(motion.coordinateX >= 190 ? 0.0 : 1.0)
							 .scaleEffect(motion.didCollide ? 1.2 : 1.0)
 							.animation(.spring(response: 0.2, dampingFraction: 0.5), value: motion.didCollide && !motion.isMoving)
							 }
						
						// MARK: Moving Platform
						
						Rectangle()
							.frame(width: platformBeingDragged ? platformMotion.width * 1.1 : platformMotion.width,
								   height: platformBeingDragged ? platformMotion.height * 1.1: platformMotion.height)
							.foregroundStyle(platformBeingDragged ? .orange : .yellow)
							.offset(x: platformMotion.coordinateX,
									y: platformMotion.coordinateY + dragPlatformTemporaryTranslationPositionOnScreen.height)
						
							.animation(.spring(response: 0.3, dampingFraction: 0.6), value: platformBeingDragged)
						
							.simultaneousGesture(
								DragGesture(minimumDistance: 10)
									.onChanged { value in
										
										platformBeingDragged = true
										
										// 1. Calculate where the platform WANTS to go
										let predictedY = platformMotion.coordinateY + value.translation.height
										let platformBottom = predictedY + platformMotion.height
										
										// 2. Only update translation if it's within bounds
										if platformBottom < 145 && predictedY > -95 { // Added 0 for top bound check
											dragPlatformTemporaryTranslationPositionOnScreen = value.translation
											
										} else if platformBottom >= 250 {
											// Stop at the bottom edge
											dragPlatformTemporaryTranslationPositionOnScreen.height = 145 - platformMotion.height - platformMotion.coordinateY
										}
									}
									.onEnded { value in
										
										// 3. Finalize position using the clamped translation
										platformMotion.coordinateY += dragPlatformTemporaryTranslationPositionOnScreen.height
										dragPlatformTemporaryTranslationPositionOnScreen = .zero
										platformBeingDragged = false
									}
							)
					}
					
				}
				.onChange(of: context.date) { _, newDate in
						let delta = newDate.timeIntervalSince(lastUpdate)
						lastUpdate = newDate
						updateGame(delta: delta)
					}
			}
			
		}
		.sensoryFeedback(isSuccess ? .success : .error, trigger: isHapticOn)
		.onAppear { startGame() }
	}
}

// MARK: Game Settings

extension ShadowBallMiniGameView {
	
	func testBoardCleaningMethod() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			boardColor = .white
			gameResult = "             "
		}
	}
	
	// MARK: - startGame
	
	func startGame() {
		
		guard !gameWasStarted else { return }
		
		successCatches = 0
		failedCatches = 0
		
		// critical flag to avoid solving chest puzzle before starting a game
		gameWasStarted = true
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			let scheme1 = generateMovementScheme()
			applyMovementScheme(scheme1, for: &motions[0])
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			
			let scheme2 = generateMovementScheme()
			applyMovementScheme(scheme2, for: &motions[1])
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			
			let scheme3 = generateMovementScheme()
			applyMovementScheme(scheme3, for: &motions[2])
			
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
			
			let scheme4 = generateMovementScheme()
			applyMovementScheme(scheme4, for: &motions[3])
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			
			let scheme5 = generateMovementScheme()
			applyMovementScheme(scheme5, for: &motions[4])
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
			
			let scheme6 = generateMovementScheme()
			applyMovementScheme(scheme6, for: &motions[5])
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
			
			let scheme7 = generateMovementScheme()
			applyMovementScheme(scheme7, for: &motions[6])
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
			
			let scheme8 = generateMovementScheme()
			applyMovementScheme(scheme8, for: &motions[7])
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
			
			let scheme9 = generateMovementScheme()
			applyMovementScheme(scheme9, for: &motions[8])
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
			
			let scheme10 = generateMovementScheme()
			applyMovementScheme(scheme10, for: &motions[9])
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
				self.stopGame()
			}
	
		
	}
	
	// MARK: - stopGame
	
	func stopGame() {
		
		guard gameWasStarted else { return }
		
		didGameEnd?(true)
		
		gameWasStarted = false
		ballsAreHidden = false
		
		for index in motions.indices {
			
			motions[index].isMoving = false
			motions[index].coordinateX = -400.0
			motions[index].didCollide = false
		}
		
		platformMotion.coordinateX = 100
		
	}
	
	// MARK: - updateGame()
	
	/// Method use runMotionObject() for all motion objects in the field
	func updateGame(delta: TimeInterval) {
		
		for index in motions.indices {
			
			if motions[index].isMoving {
				runMotionObject(&motions[index], delta: delta)
			}
		}
	}
	
	// MARK: - generateMovementScheme
	
	/// For each shadow ball we should generate it's movement scheme
	func generateMovementScheme() -> MovementScheme {
		
		MovementScheme(isMoving: true,
					   velocity: Double.random(in: 3.0...6.0),
					   coordinateX: -200,
					   coordinateY: CGFloat.random(in: -100...100),
					   minRangeX: 10.0,
					   maxRangeX: 400.0)
	}
	
	// MARK: - applyMovementScheme
	
	/// Apply a scheme for each specific ball to move
	/// TODO: Add different Y starting points
	func applyMovementScheme(_ scheme: MovementScheme, for motion: inout MotionController) {
		
		motion.isMoving = scheme.isMoving
		motion.velocity = scheme.velocity
		motion.coordinateX = scheme.coordinateX
		motion.coordinateY = scheme.coordinateY
		motion.minRangeX = scheme.minRangeX
		motion.maxRangeX = scheme.maxRangeX
		
	}
	
	// MARK: - runMotionObject
	
	/// An actual pattern for each motion to move. In such a game our balls should move from Left to Right via X Axis only
	func runMotionObject(_ motion: inout MotionController, delta: TimeInterval) {
		
		// object exceed it's max range -> change direction
		
		// REMEMBER THAT EACH VIEW HAS xCoordinate = object.xCenter, yCoordinate = object.yCenter Point Coordinate
		// To get object sides/angles use object.leftTopAngleCoordinates
		// Adjust such coordinates in both objects of collision or you simply end with trying to meet the points of two thin arrow in a field
			
		if motion.isMoving {
			print("ball X coordinate - \(motion.coordinateX)")
			print("ball Y coordinate - \(motion.coordinateY)")
			print("platform X coordinate - \(platformMotion.coordinateX)")
			print("platform Y coordinate - \(platformMotion.coordinateY + dragPlatformTemporaryTranslationPositionOnScreen.height)")
			
			// Case responsible for collision between the ball and rect
			// 10 points addition just for smooth hit box
			
//			let currentPlatformYCoordinate = platform.coordinateY + dragPlatformTemporaryTranslationPositionOnScreen.height
			
//			if motion.coordinateX >= platformMotion.coordinateX - 10 &&
//				motion.coordinateY + 50 >= currentPlatformYCoordinate &&
//				motion.coordinateY <= (currentPlatformYCoordinate + platformMotion.height){
		
//			if testCollisionDetection(motion, platformMotion) {
			if didCollisionDetected(motion, platformMotion) {
				
				resolveCollision(result: true, for: &motion)
				
				// Case for the ball after reaching certain area
				
			} else if motion.coordinateX >= 190 {
				
				resolveCollision(result: false, for: &motion)
				
				// Case to run object until it reach certain area
				
			} else if motion.coordinateX < 190 {
				motion.direction = .right
				motion.coordinateX +=  motion.velocity * CGFloat(delta) * CGFloat(60)
				
			}
		}
		
	}
	
	// MARK: - resolveObjectsCollision
	
	/// This method should define a result of collision the ball with user's platform (shield) or the farrest edge of the view it self
	func resolveCollision(result: Bool, for motion: inout MotionController) {
		motion.didCollide = true
		
		if result {
			
			motion.isMoving = false
			successCatches += 1
			isSuccess = true
			gameResult = "Damage Resist!"
			boardColor = .green
			
		} else {
			
			motion.isMoving = false
			failedCatches += 1
			isSuccess = false
			gameResult = "Taking Damage!"
			boardColor = .red
			
		}
		isHapticOn = true
		onImpact?(result)
		testBoardCleaningMethod()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			self.isHapticOn = false
		}
	}
	
	// MARK: - didCollisionDetected
	
	func didCollisionDetected(
		_ ball: MotionController,
		_ platform: MotionController
	) -> Bool {
		
		// if you use an object with drag and drop functionality you should find it's temporaryTranslationPosition
		// .height for top to bottom movement
		// .width for left-right movement
		
		let actualPlatformYCoordinate = platform.coordinateY + dragPlatformTemporaryTranslationPositionOnScreen.height
		
		// 1. Set closestPoint.coordinates to circle position by default
		// If it's coordinates will differ from rect coordinates you will change it
		// Oterwise it's mean that circle has the same X/Y coordinates as rect
		
		var closestCoordinateX = ball.coordinateX
		var closestCoordinateY = ball.coordinateY
		
		// 2. Find Min and Max points of the rect
		// Think about object.position being it's X/Y center
		// if you just put the object into V/H/ZStack it will get 0,0 X/Y center
		// If you use offSet properties, object position will be == to offSet values
		
		let platformMinX = platform.coordinateX - platform.width / 2
		let platformMaxX = platform.coordinateX + platform.width / 2
		
		let platformMinY = actualPlatformYCoordinate - platform.height / 2
		let platformMaxY = actualPlatformYCoordinate + platform.height / 2
		
		// if ball on the left from rect -> set rect min x coordinate as coordinate to compare against
		// if ball on the right from the rect -> set rect max x coordinate as coordinate to compare against
		
		if ball.coordinateX < platformMinX { // ball on the left from platform
			closestCoordinateX = platformMinX
		} else if ball.coordinateX > platformMaxX { // ball on the right
			closestCoordinateX = platformMaxX
		}
		
		// if ball on top from the rect -> set it's y min coordinate as coordinate to compare against
		// if ball on the bottom from the rect -> set it's max y coordinate as coordinate to compare against
		
		if ball.coordinateY < platformMinY { // ball on the top
			closestCoordinateY = platformMinY
		} else if ball.coordinateY > platformMaxY { // ball on the bottom
			closestCoordinateY = platformMaxY
		}
		
		// now calculate distance in coordinates between circle and this point of the rect to compare against
		
		let distanceCoordinateX = ball.coordinateX - closestCoordinateX
		let distanceCoordinateY = ball.coordinateY - closestCoordinateY
		
		// now to get an actual distance between two objects use Pythagorian theorem
		// c^2 = a^2 + b^2
		
		let distance = sqrt(distanceCoordinateX * distanceCoordinateX + distanceCoordinateY * distanceCoordinateY)
		
		// check a newly found distance again circle radius
		// if it's smaller -> we found a collision
		// otherwise -> no collision detected
		
		let ballRadius = ball.height / 2
		
		return distance <= ballRadius
	}
}
