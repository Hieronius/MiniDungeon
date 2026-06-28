// MARK: This mini game should decide how strong hero's attack damage should be boosted

/*
 TODO:
 
 - fix spacing between spots because they are overlap
 
 - user .overlay to add an extra label for userCursor when you tap "HIT" button. It should open a label with current damage boost ratio
 */

import SwiftUI

extension MainView {
	
	struct DamageBoostMiniGameView: View {
		
		@State var isGameOn: Bool = false
		// Should we use a enum for Success becasue we have 0/10/25% success boost?
		@State var isSuccess: Bool = false
		@State var boardColor: Color = .white
		@State var cursorColor: Color = .orange
		@State var resultColor: Color = .white
		@State var resultLabel = "             "
		@State var isHapticOn: Bool = false
		@State var beenTapped: Bool = false
		
		@State var firstSweetSpotLeftCoordinateX: CGFloat = 0
		@State var secondSweetSpotLeftCoordinateX: CGFloat = 0
		@State var thirdSweetSpotLeftCoordinateX: CGFloat = 0
		
		@State var userCursor = MotionController(
			id: 1,
			systemImage: "arrow.right.square",
			isMoving: false,
			didCollide: false,
			direction: .right,
			coordinateY: 0,
			// magic value to represent user cursor starting position inside child view of MainView
			coordinateX: UIScreen.main.bounds.midX - UIScreen.main.bounds.width + 20,
			velocity: 5,
			minRangeY: 0,
			maxRangeY: 0,
			// magic value to represent a min X axis position of user cursor
			minRangeX: UIScreen.main.bounds.midX - UIScreen.main.bounds.width + 20,
			// magic value to represent a max X axis position of the user cursor to stop it when out of board bounds
			maxRangeX: UIScreen.main.bounds.midX - 20,
			width: 30,
			height: 30,
			color: .orange
		)
		
		/// Localisation of current DamageBoostMiniGame session
		var isEnglish: Bool
		
		/// A result of the mini game we send to the ViewModel to process and apply to hero damage
		var onGameEnd: ((DamageBoostOutcome) -> (Void))?
		
		var timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
		
		// MARK: - Body
		
		var body: some View {
			
			ZStack {
				
				// MARK: Board
				
				Rectangle()
					.frame(width: UIScreen.main.bounds.width, height: 200)
					.foregroundColor(.black)
					.border(boardColor, width: 5)
				
				VStack {
					
					Text(resultLabel)
						.foregroundStyle(resultColor)
					
					ZStack {
						
						// MARK: Main Axis of the game
						
						Rectangle()
							.frame(width: UIScreen.main.bounds.width - 15, height: 5)
							.foregroundStyle(.yellow)
						
						// MARK: Sweet Spot combined from 3 images
						
						Image(systemName: "square.fill")
							.resizable()
							.frame(width: 40, height: 30)
							.foregroundStyle(.blue)
							.offset(x: firstSweetSpotLeftCoordinateX)
						
						Image(systemName: "rectangle.portrait.fill")
							.resizable()
							.frame(width: 30, height: 50)
							.foregroundStyle(.purple)
							.offset(x: secondSweetSpotLeftCoordinateX)
						
						Image(systemName: "square.fill")
							.resizable()
							.frame(width: 40, height: 30)
							.foregroundStyle(.blue)
							.offset(x: thirdSweetSpotLeftCoordinateX)
						
						// MARK: User cursor to move
						
						Image(systemName: userCursor.systemImage ?? "")
							.resizable()
							.frame(width: userCursor.width, height: userCursor.height)
							.foregroundStyle(userCursor.color)
							.background(.black)
							.offset(x: userCursor.coordinateX)
							.scaleEffect(userCursor.didCollide ? 1.1 : 1.0)
							.animation(.spring(response: 0.2, dampingFraction: 0.5), value: userCursor.didCollide)
							.onReceive(timer) { _ in
								if userCursor.isMoving {
									moveCursor(object: &userCursor)
								}
							}
					}
					
					// MARK: Hit button
					
					ZStack {
						
						Rectangle()
							.frame(width: 80, height: 40)
							.foregroundStyle(.black)
							.clipShape(.capsule)
							.overlay {
								Capsule()
									.stroke(boardColor, lineWidth: 3)
							}
						Text(isEnglish ? "Hit!" : "Жми!")
						
						// place for animation
						// place for gestur recognizer
					}
					.onTapGesture {
						checkDidUserCursorLandOnSweetSpot(object: &userCursor)
					}
				}
			}
			.onAppear {
				startGame()
			}
			.sensoryFeedback(isSuccess ? .success : .error, trigger: isHapticOn)
			// Handicaped condition to make view untappable after first touch action
			// Just copy an antire line of spaces from `gameResult` property
			.allowsHitTesting(resultLabel == "             ")
		}
		
	}
}

extension MainView.DamageBoostMiniGameView {
	
	// MARK: - startGame
	
	func startGame() {
		
		generateSweetSpotCoordinateX()
		boardColor = .white
		resultColor = .white
		userCursor.systemImage = "arrow.right.square"
		userCursor.didCollide = false
		userCursor.color = .orange
		userCursor.coordinateX = UIScreen.main.bounds.midX - UIScreen.main.bounds.width + 20
		resultColor = .white
		resultLabel = "             "
		// sweetSpot.coordinate = generateSweetSpot()
		userCursor.isMoving = true
	}
	
	// MARK: - generateSweetSpotCoordinate
	
	/// Method to operate by magic numbers i did find by experimental way because i do not understand how SwiftUI render things.
	/// Note: i used a simple gap in coordinates between spots equal to their width but when you run the app you see visual gaps between them. But if you actually print coordinates of the spots they are overlap
	func generateSweetSpotCoordinateX() {
		
		let leftBorder = UIScreen.main.bounds.midX - UIScreen.main.bounds.width - 25
		let rightBorder = UIScreen.main.bounds.midX - UIScreen.main.bounds.width + 175
		
		let coordinateX = CGFloat.random(in: leftBorder...rightBorder)
		
		// 30 is a width of the first spot so we just add up
		// 20 is the width of the second sweet spot
		
		firstSweetSpotLeftCoordinateX = coordinateX + 100
		secondSweetSpotLeftCoordinateX = firstSweetSpotLeftCoordinateX + 35
		thirdSweetSpotLeftCoordinateX = secondSweetSpotLeftCoordinateX + 35
	}
	
	// MARK: - moveCursor
	
	func moveCursor(object: inout MotionController) {
		
		if object.coordinateX < object.maxRangeX - 15 {
			object.coordinateX += object.velocity
			
			// if user cursor being tapped to check against sweetSpot
			
		} else {
			object.didCollide = true
			object.isMoving = false
			object.color = .red
			object.systemImage = "multiply.square"
			boardColor = .red
			isSuccess = false
			resultColor = .red
			resultLabel = isEnglish ? "No Damage Boost!" : "Без усиления!"
			isHapticOn = true
			// no damage boost -> pass 0% ot viewMode.continueAttack()
			onGameEnd?(.none)
		}
	}
	
	// MARK: - checkDidUserCursorLandOnSweetSpot
	
	func checkDidUserCursorLandOnSweetSpot(object: inout MotionController) {
		
		object.isMoving = false
		
		// 1. grab left x coordinate from sweet spots and cursor
		
		let cursorLeftBorder = userCursor.coordinateX
		let firstSweetSpotLeftBorder = firstSweetSpotLeftCoordinateX
		let secondSweetSpotLeftBorder = secondSweetSpotLeftCoordinateX
		let thirdSweetSpotLeftBorder = thirdSweetSpotLeftCoordinateX
		
		// 2. calculate objects right x coordinate by adding object.width to left x coordinate
		
		let cursorRightBorder = cursorLeftBorder + 30
		let firstSweetSpotRightBorder = firstSweetSpotLeftCoordinateX + 40
		let secondSweetSpotRightBorder = secondSweetSpotLeftCoordinateX + 30
		let thirdSweetSpotRightBorder = thirdSweetSpotLeftCoordinateX + 40
		
		// 25% damage boost has been achieved
		
		// if left border of the cursor exceeds left border of the purple sweet spot
		if (cursorLeftBorder >= secondSweetSpotLeftBorder &&
			cursorLeftBorder <= secondSweetSpotRightBorder) ||
		(cursorRightBorder >= secondSweetSpotLeftBorder &&
		 cursorLeftBorder < secondSweetSpotLeftBorder) {
			
			object.didCollide = true
			object.color = .purple
			object.systemImage = "arrow.up.square"
			boardColor = .purple
			isSuccess = true
			resultColor = .purple
			resultLabel = isEnglish ? "25% damage boost!" : "25% усиления урона!"
			onGameEnd?(.medium)
			
		// 10% damage boost has been achieved
			
		// check the same condition of overlaping for first and third (blue) spots
		// YES WE DO PRIORITIZE HUGE 25% BONUS OVER 10% TO AVOID ANNOYED PLAYERS FOR NOW
			
		} else if (cursorLeftBorder >= firstSweetSpotLeftBorder &&
				   cursorLeftBorder <= firstSweetSpotRightBorder) ||
					(cursorRightBorder >= firstSweetSpotLeftBorder &&
					 cursorLeftBorder < firstSweetSpotLeftBorder) ||
					
					(cursorLeftBorder >= thirdSweetSpotLeftBorder &&
					 cursorLeftBorder <= thirdSweetSpotRightBorder) ||
					(cursorRightBorder >= thirdSweetSpotLeftBorder &&
					 cursorLeftBorder < thirdSweetSpotLeftBorder) {
			
			object.didCollide = true
			object.color = .blue
			object.systemImage = "arrow.up.square"
			boardColor = .green
			isSuccess = true
			resultColor = .green
			resultLabel = isEnglish ? "10% damage boost!" : "10% усиления урона!"
			onGameEnd?(.small)
			
		} else {
			
			// case if user missed all sweet spots
			
			object.color = .red
			object.systemImage = "multiply.square"
			object.didCollide = true
			boardColor = .red
			isSuccess = false
			resultColor = .red
			resultLabel = isEnglish ? "No Damage Boost!" : "Без усиления!"
			onGameEnd?(.none)
		}
		
		isHapticOn = true
		
	}
}
