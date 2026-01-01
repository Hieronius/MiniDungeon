import SwiftUI

struct CombatMiniGameView: View {
	
	@State var timeRemaining = 0.0
	@State var inProgress = false
	@State var bonusArea: Double = Double.random(in: 0.2...0.8)
	@State var gameResult = "             "
	@State var isSuccess = false
	@State var progressBarColor: Color = .blue
	@State var boardColor: Color = .white
	
	// Probably should be replaced by button "HIT"
	let label = "Tap inside when the line will meet with the circle"
	
	/// This callback we send to parent view to react on game result
	var onGameEnd: ((Bool) -> Void)? // Callback for game result
	
	/// Speed of the game bar to move. You can twick for easier or harder difficulty
	var difficulty = 0.02
	
	var timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
	
	// MARK: - Body
	
	var body: some View {
		
		ZStack {
			Rectangle()
				.frame(width: UIScreen.main.bounds.width, height: 200)
				.foregroundStyle(Color.black)
				.border(boardColor, width: 5)
			
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
				Button {
					hitBonusArea()
				} label: {
					Text("Hit!")
					
						.frame(width: 100, height: 50)
						.foregroundStyle(.white)
						.background(.black)
						.clipShape(.capsule)
						.overlay {
							Capsule()
								.stroke(.white, lineWidth: 3)
						}
				}
				
				
			}
		}
		
		// Handicaped condition to make view untappable after first touch action
		// Just copy an antire line of spaces from `gameResult` property
		.allowsHitTesting(gameResult == "             ")
	}
}

extension CombatMiniGameView {
	
	func hitBonusArea() {
		
		if timeRemaining > bonusArea - 0.035 && timeRemaining < bonusArea + 0.05 {
			gameResult = "Perfect!"
			isSuccess = true
			boardColor = .green
			
		} else {
			gameResult = "Failure!"
			isSuccess = false
			boardColor = .red
		}
		
		// Turn it to true from battle screen while doing an attack
		inProgress = false
		
		onGameEnd?(isSuccess)
		
		// TODO: IF YOU EXPLORE ANY BUGS WITH COMBAT MINI GAME LOOK AT HERE
//		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//			gameResult = "          "
//			bonusArea = Double.random(in: 0.2...0.8)
//			timeRemaining = 0.0
//			progressBarColor = .blue
//		}
	}
}
