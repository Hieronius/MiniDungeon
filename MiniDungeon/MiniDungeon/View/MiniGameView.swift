import SwiftUI

// TODO:
/*
 2. Find the way to connect this view to my BattleView
 3. Find the way to start the game
 4. Find the way to get results to increase/decrease the result of an action
 5. Find the way to run the game for one time and stop the bar after reaching it's 100% -> back to battle view
 */

struct MiniGameView: View {
	
	@State var timeRemaining = 0.0
	@State var inProgress = false
	@State var bonusArea: Double = Double.random(in: 0.2...0.8)
	@State var gameResult = "             "
	@State var isSuccess = false
	@State var progressBarColor: Color = .blue
	
	let label = "Tap inside when the line will meet with the circle"
	
	var onGameEnd: ((Bool) -> Void)? // Callback for game result
	
	/// Speed of the game bar to move. You can twick for easier or harder difficulty
	var difficulty = 0.02
	
	var timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
	
	var body: some View {
		
		ZStack {
			Rectangle()
				.frame(width: UIScreen.main.bounds.width, height: 200)
				.foregroundStyle(Color.black)
				.border(.white, width: 5)
			
			VStack {
				Text("\(gameResult)")
					.foregroundStyle(isSuccess ? .green : .red)
					.onReceive(timer) { _ in
						if timeRemaining < 0.99 {
							timeRemaining += 0.01
						} else {
							timeRemaining = 0.0
							
						}
					}
				ZStack {
					Slider(value: $bonusArea)
						.frame(width: UIScreen.main.bounds.width - 20)
						.tint(.gray)
					ProgressView(value: timeRemaining)
						.frame(width: UIScreen.main.bounds.width - 20)
						.tint(progressBarColor)
				}
				Text("Tap inside when the line will meet with the circle")
			}
		}
		.onTapGesture {
			hitBonusArea()
		}
		
		// Handicaped condition to make view untappable after first touch action
		// Just copy an antire line of spaces from `gameResult` property
		.allowsHitTesting(gameResult == "             ")
	}
}

extension MiniGameView {
	
	func hitBonusArea() {
		
		if timeRemaining > bonusArea - 0.035 && timeRemaining < bonusArea + 0.05 {
			gameResult = "Perfect!"
			isSuccess = true
			progressBarColor = .green
			
		} else {
			gameResult = "Failure!"
			isSuccess = false
			progressBarColor = .red
		}
		
		// Turn it to true from battle screen while doing an attack
		inProgress = false
		
		onGameEnd?(isSuccess)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			gameResult = "          "
			bonusArea = Double.random(in: 0.2...0.8)
			timeRemaining = 0.0
			progressBarColor = .blue
		}
	}
}
