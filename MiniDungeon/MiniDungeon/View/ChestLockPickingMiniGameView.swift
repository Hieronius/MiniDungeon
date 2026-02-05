import SwiftUI

// TODO: Implement attempts to change the difficulty. 1...5. If failure -> send false to parent view and generate an enemy
// It's mean like easy-medium-hard pace of the bar to catch

// MARK: buildChestLockPickingMiniGameView

extension MainView {
	
	/// This method is optional and need only for testing purposes - to run the view independently from the MainMenu
	@ViewBuilder
	func buildChestLockPickingMiniGameView() -> some View {
		
		VStack {
			ChestLockPickingMiniGameView()
		}
		.frame(width: 400, height: 400)
	}
}

// MARK: - Direction

/// Entity to define the direction of the movement
enum Direction {
	
	case top
	case bottom
}

// MARK: - MotionController

/// Entity to define properties of the motion object
struct MotionController {
	
	/// Personal ID to identify what object has been stoped successfully
	var id: Int
	
	/// is object on the move or not
	var isMoving = false
	
	/// Is object going up or down
	var direction: Direction = .bottom
	
	/// Movement object changes only it's Y position while moving
	var coordinateY: CGFloat = 0.0
	
	/// Points per timer's tick movement object moves
	var velocity: CGFloat = 0.0
	
	/// Start position of the object to move
	var minRange: CGFloat = 0.0
	
	/// End position of the object to move
	var maxRange: CGFloat = 0.0
}

// MARK: - MovementScheme

/// A single scheme for each bar moving at the chest lock-picking view
struct MovementScheme {
	
	/// Is bar will move accordingly to this scheme
	var isMoving: Bool
	
	/// Bar speed to increment/decrement bar's `timeRemaining` property
	var velocity: CGFloat
	
	/// Place bar should be started from in CGFloat of Y coordinate
	var minRange: CGFloat
	
	/// Place bar should end at in CGFloat of Y coordinate
	var maxRange: CGFloat
}

// MARK: - ChestLockPickingMiniGameView

struct ChestLockPickingMiniGameView: View {
	
	// MARK: - State properties
	
	/// Property to detect was game started or not to prevent clicking bottom buttons before game start
	@State var gameWasStarted = false
	
	@State var gameResult = "             "
	@State var isSuccess = false
	
	@State var boardColor: Color = .white
	
	// Motion Objects
	
	@State var motion1 = MotionController(id: 1)
	@State var motion2 = MotionController(id: 2)
	@State var motion3 = MotionController(id: 3)
	@State var motion4 = MotionController(id: 4)
	@State var motion5 = MotionController(id: 5)
	
	/// An array to store the result of motion objects being catched in "safe" area
	/// 5 initial states for 5 objects to catch
	@State var motionsToCatch: [Bool?] = [false, false, false, false, false]
	
	/// Property to track if game started correctly and player have objects to catch, otherwise run it until there will be 3 and more motions
	@State var motionObjectsInMove = 0
	
	/// Property to define the level of chest lock-picking difficulty on the fly
	@State var attempts = Int.random(in: 1...3)
	
	// MARK: - Public Properties
	
	var timer1 = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
	var timer2 = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
	var timer3 = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
	var timer4 = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
	var timer5 = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
	
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
						}
					}
				} else {
					Button("Open the Chest") {
						onGameEnd?(true)
					}
					.foregroundStyle(.orange)
				}
				
				ZStack {
					
					Rectangle()
						.frame(width: 300, height: 300)
						.foregroundStyle(.black)
						.border(boardColor, width: 5)
					Rectangle()
						.frame(width: 300, height: 40)
						.border(boardColor, width: 3)
						.foregroundStyle(Color(red: 0/255.0, green: 100/255.0, blue: 0/255.0))
						.offset(y: -135)
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
			.frame(height: 280)
			
		}
	}
}

// MARK: Game Settings

extension ChestLockPickingMiniGameView {
	
	// MARK: startGame
	
	/// Generate and apply schemes for all motions of the view
	func startGame() {
		
		// critical flag to avoid solving chest puzzle before starting a game
		self.gameWasStarted = true
		
		// generate and apply movements scheme until there 3 and more movements
		
		while motionObjectsInMove <= 2 {
			
			for motion in 1...5 {
				
				let scheme = generateMovementScheme()
				
				applyMovementScheme(scheme, for: motion)
			}
		}
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
	
	// MARK: - generateMovementScheme
	
	/// Method to generate range, velocity and position of specific motion object
	func generateMovementScheme() -> MovementScheme {
		
		// Generate isMoving property
		
		let isMovingChance = Int.random(in: 1...100)
		
		var isMoving = false
		
		if isMovingChance > 50 {
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
		let minRange: CGFloat = -10.0
		
		// Generate maxRange
		// Current value allows to move inside the view
		let maxRange: CGFloat = 250.0
		
		// fill with generated properties
		
		return MovementScheme(
			isMoving: isMoving,
			velocity: velocity,
			minRange: minRange,
			maxRange: maxRange
		)
			
	}
	
	// MARK: - applyMovementScheme
	
	/// Method to apply the scheme for specific motion object
	func applyMovementScheme(_ scheme: MovementScheme, for motion: Int) {
		
		guard scheme.isMoving else {
			motionsToCatch[motion-1] = true
			return
		}
		motionObjectsInMove += 1
		motionsToCatch[motion-1] = false
		
		switch motion {
			
		case 1:
			motion1.isMoving = scheme.isMoving
			motion1.velocity = scheme.velocity
			motion1.minRange = scheme.minRange
			motion1.maxRange = scheme.maxRange
			
		case 2:
			motion2.isMoving = scheme.isMoving
			motion2.velocity = scheme.velocity
			motion2.minRange = scheme.minRange
			motion2.maxRange = scheme.maxRange
			
		case 3:
			motion3.isMoving = scheme.isMoving
			motion3.velocity = scheme.velocity
			motion3.minRange = scheme.minRange
			motion3.maxRange = scheme.maxRange
			
		case 4:
			motion4.isMoving = scheme.isMoving
			motion4.velocity = scheme.velocity
			motion4.minRange = scheme.minRange
			motion4.maxRange = scheme.maxRange
			
		case 5:
			motion5.isMoving = scheme.isMoving
			motion5.velocity = scheme.velocity
			motion5.minRange = scheme.minRange
			motion5.maxRange = scheme.maxRange
			
		default: break
		}
	}
	
	// MARK: - runMotionObject
	
	/// Method to define an actual movement of the motion object accordingly to it's properties
	func runMotionObject(_ motion: inout MotionController) {
		
		// object exceed it's max range -> change direction
		
		if motion.coordinateY >= motion.maxRange && motion.direction == .bottom {
			motion.direction = .top
			
		// object exceed it's min range -> change direction
			
		} else if motion.coordinateY <= motion.minRange && motion.direction == .top {
			motion.direction = .bottom
			
		// object moves down until it's max range -> increment it's Y position
			
		} else if motion.coordinateY < motion.maxRange && motion.direction == .bottom {
			motion.coordinateY += motion.velocity
		
		// object exceeds it's max range but moves top -> adjust it's position
			
		} else if motion.coordinateY > motion.maxRange && motion.direction == .top {
			motion.coordinateY -= motion.velocity
			
		// object moves up until it's min range -> decrement it's Y position
			
		} else if motion.coordinateY <= motion.maxRange && motion.direction == .top {
			motion.coordinateY -= motion.velocity
			
		}
	}
	
	// MARK: - checkMotionObjectPosition
	
	/// Method to check an actual position of the test object to be in a range of winning condition
	func checkMotionObjectPositon(_ motion: inout MotionController) {
		
		guard gameWasStarted else { return }
		
		if motion.coordinateY <= 10.0 {
			
			motion.isMoving = false
			motion.coordinateY = 0.0
			motionsToCatch[motion.id - 1] = true
			isSuccess = true
			gameResult = "Perfect!"
			boardColor = .green
			
		} else {
			attempts -= 1
			isSuccess = false
			gameResult = "Failure"
			boardColor = .red
		}
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			boardColor = .white
			gameResult = "             "
			
			if attempts == 0 {
				stopGame()
			}
			
		}
	}
}
