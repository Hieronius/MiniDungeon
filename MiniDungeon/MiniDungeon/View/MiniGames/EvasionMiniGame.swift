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
	
	@ViewBuilder
	func buildEvasionMiniGame() -> some View {
		
		VStack {
			EvasionMiniGame()
		}
		.frame(height: 200)
	}
}

/*
 ZStack {
 
 	.Board
 
VStack {
 
 	. success/failure label
 
 	.directionLabel
 
 	ZStack {
 
 		.xAxis
 		.SweetSpot
 		.HitSpot
 		.UserCursor
 

 */

struct EvasionMiniGame: View {
	
	// MARK: - State Properties
	
	@State var result: Bool = false
	@State var boardColor: Color = .white
	@State var cursorColor: Color = .purple
	@State var resultLabel: String = "             "
	@State var resultLabelColor: Color = .white
	@State var swipeDirectionLabel = "             "
	@State var swipeDirection: Direction = .bottom
	
	@State var userCursor = MotionController(
		id: 1,
		coordinateX: -((UIScreen.main.bounds.width / 2) - 40),
		velocity: 5.0,
		width: 25,
		height: 50,
		color: .black
	)
	
	@State var sweetSpot = MotionController(
		id: 2,
		width: 20,
		height: 50,
		color: .green
	)
	
	@State var hitArea = MotionController(
		id: 3,
		coordinateX: 135,
		width: 100,
		height: 20,
		color: .red
	)
	
	@State var lastUpdate = Date()
	
	
	// MARK: - General Properties
	
	var onGameEnd: ((Bool) -> (Void))?
	var difficulty: Difficulty = .easy
	
	
	
	var body: some View {
		
		// Stack to put the board and it's content to it
		ZStack {
			
			Rectangle()
				.frame(width: UIScreen.main.bounds.width - 20)
				.foregroundColor(.black) // change to result outcome (red/green)
				.border(boardColor, width: 5)
			
			// Internal stack to hold a label of game result, generated direction and the whole game scales
			VStack {
				
				HStack {
					
					Button("Start Game") {
						startGame()
					}
					
					Button("End Game") {
						endGame()
					}
				}
				
				Text(resultLabel)
					.foregroundStyle(resultLabelColor)
				
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
//						.offset(x: UIScreen.main.bounds.width)
					
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
								
						.scaleEffect(userCursor.didCollide ? 1.2 : 1.0)
						.animation(.spring(response: 0.2, dampingFraction: 0.5), value: userCursor.didCollide && !userCursor.isMoving)
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
		.simultaneousGesture(
			DragGesture()
				.onEnded { value in
					// put methods to check collision here
					
					handleSwipe()
					if value.translation.width > 50 {
						swipeDirectionLabel = "Did Swipe Right"
					} else if value.translation.width < -50 {
						swipeDirectionLabel = "Did Swipe Left"
					}
				}
			)
		// Handicaped condition to make view untappable after first touch action
		// Just copy an antire line of spaces from `gameResult` property
		.allowsHitTesting(resultLabel == "             ")
	}
}

extension EvasionMiniGame {
	
	func startGame() {
		
		// set cursor.isMoving to true
		userCursor.isMoving = true
		
	}
	
	func endGame() {
		
		userCursor.isMoving = false
		userCursor.coordinateX = -((UIScreen.main.bounds.width / 2) - 40)
		// set cursor.isMoving to false
		// isMiniGameOn = false
	}
	
	func moveCursor(_ object: inout MotionController, delta: TimeInterval) {
		
		let userCursorRightEdge = userCursor.coordinateX + userCursor.width
		let hitAreaLeftEdge = hitArea.coordinateX
		
		if object.isMoving && userCursorRightEdge < hitAreaLeftEdge {
			
			object.coordinateX += object.velocity

			
			
			// if user did try to swipe on sweet spot -> check direction for evasion * stop cursor
			
			
			// if user did swipe on hit area after sweet spot -> fail evasion & stop cursor
			
			// if user did reach a board edge -> fail evasion & stop cursor
			
			
		} else {
			
			// TODO: This block won't stop to execute when condition met
			handleSwipe()
//			userCursor.didCollide = true
//			userCursor.isMoving = false
//			boardColor = .red
//			resultLabelColor = .red
//			resultLabel = "Failure!"
//			userCursor.color = .red
//			cursorColor = .red
//			onGameEnd?(false)
//			print("Still Running")
		}
		// cursor.offSet(x: += velocity)
	}
	
	func generateSwipeDirection() {
		
		// let roll
	}
	
	func generateSweetSpot() {
		
		// let roll
	}
	
	func handleSwipe() {
		
		let userCursorLeftEdge = userCursor.coordinateX
		let userCursorRightEdge = userCursor.coordinateX + userCursor.width
		
		let sweetSpotLeftEdge = sweetSpot.coordinateX
		let sweetSpotRightEdge = sweetSpot.coordinateX + sweetSpot.width
		
		// if user failed to swipe in sweet spot area
		
		// TODO: Wrong Win condition. Write it down on the tablet
		if userCursorLeftEdge < sweetSpotLeftEdge &&
		userCursorRightEdge > sweetSpotRightEdge {
			
			userCursor.didCollide = true
			userCursor.isMoving = false
			boardColor = .red
			resultLabelColor = .red
			resultLabel = "Failure!"
			userCursor.color = .red
			cursorColor = .red
			onGameEnd?(false)
			
			// TODO: Wrong lose condition. Write it down on the tablet
		} else {
			
			// if user was correct on swiping on the right place
			
			userCursor.didCollide = true
			userCursor.isMoving = false
			boardColor = .green
			resultLabelColor = .green
			resultLabel = "Success!"
			onGameEnd?(true)
			userCursor.color = .green
			cursorColor = .green
			
		}
	}
	
	func checkIfEvasionWasSuccess() -> Bool {
		
		// handleSwipeDirection
		// if true -> check coordinates, else -> return hit on the hero
		// cursor.xOffSet +/- 10 == sweetSpot.xOffSet
		
		return false
	}
	
	func checkSwipeDirection(direction: Direction) -> Bool {
		
		// if direction == swipe.direction -> return true
		// else return false
		// handle swipe gesture
		return false
	}
}
