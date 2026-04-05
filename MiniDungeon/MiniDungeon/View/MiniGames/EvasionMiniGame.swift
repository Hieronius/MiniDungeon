import SwiftUI

/* MARK: Notes
 
 rectangle.portrait.fill - to represent user cursor
 
 // How to apply TimeLine View with latest date to improve fps ratio
 
 .onChange(of: context.date){ oldValue, newDate in
	 let delta = newDate.timeIntervalSince(lastUpdate1)
	 lastUpdate1 = newDate
	 if motion1.isMoving {
		 runMotionObject(&motion1, delta: delta)
	 }
 }
 
 */


extension MainView {
	
	// MARK: - buildEvasionMiniGame
	
	@ViewBuilder
	func buildEvasionMiniGame() -> some View {
		
		VStack {
			EvasionMiniGame()
		}
		.frame(height: 200)
	}
}

// MARK: - EvasionMiniGame

struct EvasionMiniGame: View {
	
	// MARK: - State Properties
	
	@State var isGameOn: Bool = false
	@State var isSuccess: Bool = false
	@State var boardColor: Color = .white
	@State var cursorColor: Color = .purple
	@State var resultLabel: String = "             "
	@State var resultLabelColor: Color = .white
	@State var swipeDirectionLabel = "             "
	@State var swipeDirection: Direction = .bottom
	@State var isHapticOn = false

	
	/// user cursor width should be always less than sweet spot width or it will break condition to check collision
	@State var userCursor = MotionController(
		id: 1,
		coordinateX: -((UIScreen.main.bounds.width / 2) - 40),
		velocity: 4.0,
		width: 25,
		height: 50,
		color: .black
	)
	
	/// sweet spot width should be always wider than user cursor width or it will break condition to check collision
	@State var sweetSpot = MotionController(
		id: 2,
		width: 30,
		height: 20,
		color: .green
	)
	
	@State var hitArea = MotionController(
		id: 3,
		coordinateX: 160,
		width: 50,
		height: 20,
		color: .red
	)
	
	@State var lastUpdate = Date()
	
	
	// MARK: - General Properties
	
	var onGameEnd: ((Bool) -> (Void))?
	var difficulty: Difficulty = .easy
	
	// MARK: - Body
	
	var body: some View {
		
		// Stack to put the board and it's content to it
		ZStack {
			
			// Board
			
			Rectangle()
				.frame(width: UIScreen.main.bounds.width - 20, height: 200)
				.foregroundColor(.black) // change to result outcome (red/green)
				.border(boardColor, width: 5)
			
			// Internal stack to hold a label of game result, generated direction and the whole game scales
			VStack {
				
				Text(resultLabel)
					.foregroundStyle(resultLabelColor)
				Text("Slow Enemy Attack!")
				Text(swipeDirectionLabel)
				
				TimelineView(.animation) { context in

				ZStack {
					
					// main axis of the evasion scale
					Rectangle()
						.frame(width: UIScreen.main.bounds.width - 30,
							   height: 20)
						.foregroundColor(.orange)
					
					// sweet spot
					Rectangle()
						.frame(width: sweetSpot.width,
							   height: sweetSpot.height)
						.foregroundColor(sweetSpot.color)
						.offset(x: sweetSpot.coordinateX)
					
					// hit area (failed area)
					Rectangle()
						.frame(width: hitArea.width,
							   height: hitArea.height)
						.foregroundColor(hitArea.color)
						.offset(x: hitArea.coordinateX)
					
					// player cursor
					Image(systemName: userCursor.isMoving ? "rectangle.portrait.fill" : "rectangle.portrait")
						.resizable() // 1. IMPORTANT: This lets the icon scale
						.aspectRatio(contentMode: .fit)
						.frame(width: userCursor.width, height: userCursor.height)
						.foregroundStyle(cursorColor)
						.background(userCursor.color)
						.labelStyle(.iconOnly)
						.clipShape(Rectangle())
						.offset(x: userCursor.coordinateX)
								
						.scaleEffect(userCursor.didCollide ? 1.1 : 1.0)
						.animation(.spring(response: 0.2, dampingFraction: 0.5), value: userCursor.didCollide)
						.onChange(of: context.date){ oldValue, newDate in
							let delta = newDate.timeIntervalSince(lastUpdate)
							lastUpdate = newDate
							if userCursor.isMoving {
								moveCursor(&userCursor, delta: delta)
							}
						}
				}
					
				}
			}
		}
		.onAppear { startGame() }
		
		.simultaneousGesture(
			DragGesture()
				.onEnded { value in
					// put methods to check collision here
					
					if value.translation.width > 50 {
						swipeDirectionLabel = "Did Swipe Right"
						// if predefined direction == .right -> send true to process
						if swipeDirection == .right {
							handleSwipe(isSwipeCorrect: true)
							print("Predefined Direction was Right, Swipe was Right")
						} else if swipeDirection == .left {
							handleSwipe(isSwipeCorrect: false)
							print("Predefined Direction was Right, Swipe was Left")
						}
						// otherwise -> send false
					} else if value.translation.width < -50 {
						swipeDirectionLabel = "Did Swipe Left"
						// if predefined diretion ==.left -> send true to process
						if swipeDirection == .left {
							handleSwipe(isSwipeCorrect: true)
							print("Predefined Direction was Left, Swipe was Left")
						} else {
							handleSwipe(isSwipeCorrect: false)
							print("Predefined Direction was Left, Swipe was Right")
						}
					}
				}
			)
		.sensoryFeedback(isSuccess ? .success : .error, trigger: isHapticOn)
		// Handicaped condition to make view untappable after first touch action
		// Just copy an antire line of spaces from `gameResult` property
		.allowsHitTesting(resultLabel == "             ")
	}
		
}

extension EvasionMiniGame {
	
	// MARK: - startGame
	
	func startGame() {
		
		userCursor.isMoving = true
		sweetSpot.coordinateX = generateSweetSpot()
		swipeDirection = generateSwipeDirection()
		if swipeDirection == .right {
			swipeDirectionLabel = "-> Right ->"
		} else if swipeDirection == .left {
			swipeDirectionLabel = "<- Left <-"
		}
		
	}
	
	// MARK: - gameOver
	
	func gameOver() {
		
		boardColor = .red
		resultLabelColor = .red
		resultLabel = "Got Hit!"
		userCursor.color = .red
		cursorColor = .red
		onGameEnd?(false)
		isHapticOn = true
	}
	
	// MARK: - endGame
	
	func endGame() {
		
		userCursor.coordinateX = -((UIScreen.main.bounds.width / 2) - 40)
		userCursor.isMoving = false
		userCursor.didCollide = false
		isGameOn = false
		isSuccess = false
		boardColor = .white
		userCursor.color = .purple
		cursorColor = .purple
		resultLabel = "             "
		resultLabelColor = .white
		swipeDirectionLabel = "             "
		swipeDirection = .bottom
	}
	
	// MARK: - moveCursor
	
	func moveCursor(_ object: inout MotionController, delta: TimeInterval) {
		
		let userCursorRightEdge = userCursor.coordinateX + userCursor.width / 2
		let hitAreaLeftEdge = hitArea.coordinateX - hitArea.width / 2
		
		guard object.isMoving else { return }
		
		if userCursorRightEdge < hitAreaLeftEdge {
			
			object.coordinateX += object.velocity * delta * 60
			
		} else if userCursorRightEdge >= hitAreaLeftEdge {
			
			gameOver()
			object.isMoving = false
			object.didCollide = true
		}
	}
	
	// MARK: - generateSwipeDirection
	
	func generateSwipeDirection() -> Direction {
		
		let roll = Int.random(in: 1...100)
		if roll > 50 {
			return .right
		} else {
			return .left
		}
	}
	
	// MARK: - generateSweetSpot
	
	func generateSweetSpot() -> CGFloat {
		
		let leftSide = Int(userCursor.coordinateX + userCursor.width / 2 + 100)
		let rightSide = Int(hitArea.coordinateX - hitArea.width / 2 - 20)
		
		let roll = Int.random(in: leftSide...rightSide)
		return CGFloat(roll)
		
	}
	
	// MARK: - handleSwipe
	
	func handleSwipe(isSwipeCorrect: Bool) {
		
		let userCursorLeftEdge = userCursor.coordinateX - userCursor.width / 2
		let userCursorRightEdge = userCursor.coordinateX + userCursor.width / 2
		
		let sweetSpotLeftEdge = sweetSpot.coordinateX - sweetSpot.width / 2
		let sweetSpotRightEdge = sweetSpot.coordinateX + sweetSpot.width / 2
		
		// user cursor is partially in the sweet spot by it's right side
		let isCursorRightEdgeAtSweetSpot = userCursorRightEdge >= sweetSpotLeftEdge && userCursorRightEdge < sweetSpotRightEdge
		
		// user cursor is partially in the sweet spot by it's left side
		let isCursorLeftEdgeAtSweetSpot = userCursorLeftEdge >= sweetSpotLeftEdge && userCursorLeftEdge < sweetSpotRightEdge + 1
		
		// if cursor is at the sweet spot by any of it's sides and swipe direction is correct -> successfully dodge the attack
		if (isCursorRightEdgeAtSweetSpot || isCursorLeftEdgeAtSweetSpot) && isSwipeCorrect {
			
			userCursor.didCollide = true
			userCursor = userCursor
			userCursor.isMoving = false
			boardColor = .green
			resultLabelColor = .green
			resultLabel = "Success!"
			userCursor.color = .green
			cursorColor = .green
			onGameEnd?(true)
			isSuccess = true
			
			
		// in any other cases get hit
		} else {
			
			// if user was correct on swiping on the right place
			
			userCursor.didCollide = true
			userCursor.isMoving = false
			boardColor = .red
			resultLabelColor = .red
			resultLabel = "Failure!"
			onGameEnd?(false)
			userCursor.color = .red
			cursorColor = .red
			isSuccess = false
			
		}
		isHapticOn = true
	}
}
