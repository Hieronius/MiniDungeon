import SwiftUI

// TODO: Implement attempts to change the difficulty. 1...5. If failure -> send false to parent view and generate an enemy
// It's mean like easy-medium-hard pace of the bar to catch

// MARK: buildChestLockPickingMiniGameView

extension MainView {
	
	/// This method is optional and need only for testing purposes - to run the view independently from the MainMenu
	@ViewBuilder
	func buildChestLockPickingMiniGameView(audioManager: AudioManager) -> some View {
		
		VStack {
			ChestLockPickingMiniGameView(audioManager: audioManager)
		}
		.frame(width: 400, height: 325)
	}
}

// MARK: - ChestLockPickingMiniGameView

struct ChestLockPickingMiniGameView: View {
	
	// MARK: - State properties
	
	/// Property to detect was game started or not to prevent clicking bottom buttons before game start
	@State var gameWasStarted = false
	
	@State var gameResult = "             "
	@State var isSuccess = false
	
	@State var boardColor: Color = .white
	@State var startAreaColor: Color = Color(red: 0/255.0, green: 100/255.0, blue: 0/255.0)
	@State var isHapticOn = false
	
	// Motion Objects
	
	@State var motion1 = MotionController(id: 1, coordinateY: 15)
	@State var motion2 = MotionController(id: 2, coordinateY: 15)
	@State var motion3 = MotionController(id: 3, coordinateY: 15)
	@State var motion4 = MotionController(id: 4, coordinateY: 15)
	@State var motion5 = MotionController(id: 5, coordinateY: 15)
	
	/// An array to store the result of motion objects being catched in "safe" area
	/// 5 initial states for 5 objects to catch
	@State var motionsToCatch: [Bool] = [false, false, false, false, false]
	
	/// Property to track if game started correctly and player have objects to catch, otherwise run it until there will be 3 and more motions
	@State var motionObjectsInMove = 0
	
	/// Property to define the level of chest lock-picking difficulty on the fly
	@State var attempts = Int.random(in: 1...3)
	
	// MARK: - Public Properties
	
	/// We use this property to reach viewModel.audioManager.playSound()
	/// Otherwise it's unreachable
	var audioManager: AudioManager
	
	var timer1 = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
	var timer2 = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
	var timer3 = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
	var timer4 = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
	var timer5 = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
	
	/// Property to detect the moment user did open the chest to prevent multiple loot generation
	@State var didOpenChest = false
	
	/// This callback we send to parent view to react on game result
	var onGameEnd: ((Bool) -> Void)?
	
	// MARK: - Body
	
	var body: some View {
		
		ZStack {
			
			// MARK: - Header
			
			VStack {
				
				Text(gameResult)
					.foregroundStyle(isSuccess ? .green : .red)
				
				if motionsToCatch.contains(false) {
					
					if attempts > 0 {
						HStack {
							Text("Attempts: \(attempts)")
							Button("Start the game") {
								startGame()
							}
						}
					} else {
						HStack {
							Text("Failed to unlock")
							Button("Fight an enemy") {
								onGameEnd?(false)
							}
							.foregroundStyle(.red)
						}
					}
				} else {
					Button("Open the Chest") {
						openChest()
					}
					.foregroundStyle(.orange)
				}
				
				// MARK: Body
				
				ZStack {
					
					Rectangle()
						.frame(width: 300, height: 250)
						.foregroundStyle(.black)
						.border(boardColor, width: 5)
					Rectangle()
						.frame(width: 300, height: 40)
						.border(boardColor, width: 3)
						.foregroundStyle(startAreaColor)
						.offset(y: -105)
				}
				
				// MARK: - Catch Buttons
				
				HStack(spacing: 25) {
					
					Button("circle.fill", systemImage: "circle.fill") {
						checkMotionObjectPositon(&motion1)
					}
					.frame(width: 35, height: 35)
					.foregroundStyle(.white)
					.background(Color.gray.opacity(0.5))
					.clipShape(.circle)
					.labelStyle(.iconOnly)
					.opacity(attempts > 0 ? 1.0 : 0.0)
					
					Button("circle.fill", systemImage: "circle.fill") {
						checkMotionObjectPositon(&motion2)
					}
					.frame(width: 35, height: 35)
					.foregroundStyle(.white)
					.background(Color.gray.opacity(0.5))
					.clipShape(.circle)
					.labelStyle(.iconOnly)
					.opacity(attempts > 0 ? 1.0 : 0.0)
					
					Button("circle.fill", systemImage: "circle.fill") {
						checkMotionObjectPositon(&motion3)
					}
					.frame(width: 35, height: 35)
					.foregroundStyle(.white)
					.background(Color.gray.opacity(0.5))
					.clipShape(.circle)
					.labelStyle(.iconOnly)
					.opacity(attempts > 0 ? 1.0 : 0.0)
					
					Button("circle.fill", systemImage: "circle.fill") {
						checkMotionObjectPositon(&motion4)
					}
					.frame(width: 35, height: 35)
					.foregroundStyle(.white)
					.background(Color.gray.opacity(0.5))
					.clipShape(.circle)
					.labelStyle(.iconOnly)
					.opacity(attempts > 0 ? 1.0 : 0.0)
					
					Button("circle.fill", systemImage: "circle.fill") {
						checkMotionObjectPositon(&motion5)
					}
					.frame(width: 35, height: 35)
					.foregroundStyle(.white)
					.background(Color.gray.opacity(0.5))
					.clipShape(.circle)
					.labelStyle(.iconOnly)
					.opacity(attempts > 0 ? 1.0 : 0.0)
				}
				
			}
			VStack {
				
				// MARK: - Motions
				
				HStack {
					
					Button(motion1.isMoving ? "capsule" : "capsule.fill",
						   systemImage: motion1.isMoving ? "capsule" : "capsule.fill") {
					
					}
					.frame(width: 50, height: 25)
					.foregroundStyle(.white)
					.background(.gray)
					.labelStyle(.iconOnly)
					.clipShape(.capsule)
					.offset(y: motion1.coordinateY)
					.onReceive(timer1) { _ in
						if motion1.isMoving {
							runMotionObject(&motion1)
						}
					}
					
					Button(motion2.isMoving ? "capsule" : "capsule.fill",
						   systemImage: motion2.isMoving ? "capsule" : "capsule.fill") {
						
					}
					.frame(width: 50, height: 25)
					.foregroundStyle(.white)
					.background(.gray)
					.labelStyle(.iconOnly)
					.clipShape(.capsule)
					.offset(y: motion2.coordinateY)
					.onReceive(timer2) { _ in
						if motion2.isMoving {
							runMotionObject(&motion2)
						}
					}
					
					Button(motion3.isMoving ? "capsule" : "capsule.fill",
						   systemImage: motion3.isMoving ? "capsule" : "capsule.fill") {
						
					}
					.frame(width: 50, height: 25)
					.foregroundStyle(.white)
					.background(.gray)
					.labelStyle(.iconOnly)
					.clipShape(.capsule)
					.offset(y: motion3.coordinateY)
					.onReceive(timer3) { _ in
						if motion3.isMoving {
							runMotionObject(&motion3)
						}
					}
					
					Button(motion4.isMoving ? "capsule" : "capsule.fill",
						   systemImage: motion4.isMoving ? "capsule" : "capsule.fill") {
						
					}
					.frame(width: 50, height: 25)
					.foregroundStyle(.white)
					.background(.gray)
					.labelStyle(.iconOnly)
					.clipShape(.capsule)
					.offset(y: motion4.coordinateY)
					.onReceive(timer4) { _ in
						if motion4.isMoving {
							runMotionObject(&motion4)
						}
					}
					
					Button(motion5.isMoving ? "capsule" : "capsule.fill",
						   systemImage: motion5.isMoving ? "capsule" : "capsule.fill") {
						
					}
					.frame(width: 50, height: 25)
					.foregroundStyle(.white)
					.background(.gray)
					.labelStyle(.iconOnly)
					.clipShape(.capsule)
					.offset(y: motion5.coordinateY)
					.onReceive(timer5) { _ in
						if motion5.isMoving {
							runMotionObject(&motion5)
						}
					}
					
				}
				Spacer()
				
			}
			.sensoryFeedback(isSuccess ? .success : .error, trigger: isHapticOn)
			.frame(height: 250)
			
		}
	}
}

// MARK: Game Settings

extension ChestLockPickingMiniGameView {
	
	// MARK: - startGame
	
	/// Generate and apply schemes for all motions of the view
	func startGame() {
		
		audioManager.playSound(fileName: "click", extensionName: "mp3")
		
		guard !gameWasStarted else { return }
		
		// critical flag to avoid solving chest puzzle before starting a game
		self.gameWasStarted = true
		
		self.motionsToCatch = [false, false, false, false, false]
		
		/// Property to track if game started correctly and player have objects to catch, otherwise run it until there will be 3 and more motions
		self.motionObjectsInMove = 0
		
		// Run the loop once with increased chance to generate moving object to define difficulty
		
		for motion in 1...5 {
			
			let scheme = generateMovementScheme()
			
			applyMovementScheme(scheme, for: motion)
			
		}
		
		// Count all motion objects in move (false in array)
		
		for motion in motionsToCatch {
			if motion == false { motionObjectsInMove += 1 }
		}
		print(motionsToCatch)
		print(motionObjectsInMove)
		
	}
	
	// MARK: - stopGame
	
	/// Success or a failure you should stop all motions to prevent bugs
	func stopGame() {
		motion1.isMoving = false
		motion2.isMoving = false
		motion3.isMoving = false
		motion4.isMoving = false
		motion5.isMoving = false
	}
	
	func openChest() {
		guard !didOpenChest else { return }
		didOpenChest = true
		onGameEnd?(true)
	}
	
	// MARK: - generateMovementScheme
	
	/// Method to generate range, velocity and position of specific motion object
	func generateMovementScheme() -> MovementScheme {
		
		// Generate isMoving property
		
		let isMovingChance = Int.random(in: 1...100)
		
		var isMoving = false
		
		if isMovingChance > 35 {
			isMoving = true
		}
		
		// Generate velocity 1.0 - 5.0
		
		let velocityRange = Int.random(in: 1...100)
		
		var velocity: CGFloat = 0.0
		
		switch velocityRange {
			
		case (1...20): velocity = 2.0
			
		case (21...60): velocity = 2.5
			
		case (61...90): velocity = 3.0
			
		case (91...100): velocity = 4.0
			
		default: break
		}
		
		// Generate minRange
		// Current number is correct for given Chest LockPicking View
		// Otherwise it will go out of the view
		
		let minRange: CGFloat  = 15 // test change from 23.04
		
		// Generate maxRange
		// Current value allows to move inside the view
		let maxRange: CGFloat = 220 // test change from 23.04
		
		// fill with generated properties
		
		return MovementScheme(
			isMoving: isMoving,
			velocity: velocity,
			minRangeY: minRange,
			maxRangeY: maxRange
		)
			
	}
	
	// MARK: - applyMovementScheme
	
	/// Method to apply the scheme for specific motion object
	func applyMovementScheme(_ scheme: MovementScheme, for motion: Int) {
		
		guard scheme.isMoving else {
			motionsToCatch[motion-1] = true
			return
		}
		motionsToCatch[motion-1] = false
		
		switch motion {
			
		case 1:
			motion1.isMoving = scheme.isMoving
			motion1.velocity = scheme.velocity
			motion1.minRangeY = scheme.minRangeY
			motion1.maxRangeY = scheme.maxRangeY
			
		case 2:
			motion2.isMoving = scheme.isMoving
			motion2.velocity = scheme.velocity
			motion2.minRangeY = scheme.minRangeY
			motion2.maxRangeY = scheme.maxRangeY
			
		case 3:
			motion3.isMoving = scheme.isMoving
			motion3.velocity = scheme.velocity
			motion3.minRangeY = scheme.minRangeY
			motion3.maxRangeY = scheme.maxRangeY
			
		case 4:
			motion4.isMoving = scheme.isMoving
			motion4.velocity = scheme.velocity
			motion4.minRangeY = scheme.minRangeY
			motion4.maxRangeY = scheme.maxRangeY
			
		case 5:
			motion5.isMoving = scheme.isMoving
			motion5.velocity = scheme.velocity
			motion5.minRangeY = scheme.minRangeY
			motion5.maxRangeY = scheme.maxRangeY
			
		default: fatalError("Something went wrong with applying movement scheme")
		}
	}
	
	// MARK: - runMotionObject
	
	/// Method to define an actual movement of the motion object accordingly to it's properties
	func runMotionObject(_ motion: inout MotionController) {
		
		// object exceed it's max range -> change direction
		
		if motion.coordinateY >= motion.maxRangeY && motion.direction == .bottom {
			motion.direction = .top
			
		// object exceed it's min range -> change direction
			
		} else if motion.coordinateY <= motion.minRangeY && motion.direction == .top {
			motion.direction = .bottom
			
		// object moves down until it's max range -> increment it's Y position
			
		} else if motion.coordinateY < motion.maxRangeY && motion.direction == .bottom {
			motion.coordinateY += motion.velocity
		
		// object exceeds it's max range but moves top -> adjust it's position
			
		} else if motion.coordinateY > motion.maxRangeY && motion.direction == .top {
			motion.coordinateY -= motion.velocity
			
		// object moves up until it's min range -> decrement it's Y position
			
		} else if motion.coordinateY <= motion.maxRangeY && motion.direction == .top {
			motion.coordinateY -= motion.velocity
			
		}
	}
	
	// MARK: - checkMotionObjectPosition
	
	/// Method to check an actual position of the test object to be in a range of winning condition
	func checkMotionObjectPositon(_ motion: inout MotionController) {
		
		guard gameWasStarted else { return }
		
		if motion.coordinateY <= 35.0 {
			
			audioManager.playSound(fileName: "clickChest", extensionName: "mp3")
			motion.isMoving = false
			motion.coordinateY = 15.0
			motionsToCatch[motion.id - 1] = true
			isSuccess = true
			gameResult = "Perfect!"
			startAreaColor = .green
			boardColor = .green
			
		} else {
			audioManager.playSound(fileName: "denied", extensionName: "mp3")
			attempts -= 1
			isSuccess = false
			gameResult = "Failure"
			startAreaColor = .red
			boardColor = .red
		}
		isHapticOn = true
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			isHapticOn = false
			boardColor = .white
			startAreaColor = Color(red: 0/255.0, green: 100/255.0, blue: 0/255.0)
			gameResult = "             "
			
			if attempts == 0 {
				stopGame()
			}
			
		}
	}
}
