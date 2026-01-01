import SwiftUI

/*
 TODO: You can add more arrows such as arrow.diagonalLeft/Right to increase difficulty
 TODO: Refactor code to avoid redundant button settings
 TODO: To increase the size of the buttons use .scaleEffect(1.0 - 2.0)
 */

// MARK: - buildTrapDefusionMiniGameView

extension MainView {
	
	/// This method is optional and need only for testing purposes - to run the view independently from the MainMenu
	@ViewBuilder
	func buildTrapDefusionMiniGameView() -> some View {
		
		VStack {
			TrapDefusionMiniGameView()
		}
	}
}

// MARK: - Arrows

enum Arrows: String, CaseIterable {
	
	case arrowUp = "arrow.up"
	case arrowDown = "arrow.down"
	case arrowLeft = "arrow.left"
	case arrowRight = "arrow.right"
}

// MARK: - TrapDefusionMiniGame

struct TrapDefusionMiniGameView: View {
	
	@State var gameResult = "               "
	@State var isSuccess = false
	@State var boardColor = Color.white
	@State var gameWasStarted = false
	
	@State var button1Index = 0
	@State var button2Index = 0
	@State var button3Index = 0
	@State var button4Index = 0
	@State var button5Index = 0
	@State var button6Index = 0
	@State var button7Index = 0
	@State var button8Index = 0
	@State var button9Index = 0
	
	@State var index = 0
	
	@State var patternButtons: [Int: Int] = [:]
	@State var tappedButtons: [Int: Int] = [:]
	
	/// This callback we send to parent view to react on game result
	var onGameEnd: ((Bool) -> Void)?
	
	var body: some View {
		
		// MARK: - Body
		
		ZStack {
			Rectangle()
				.frame(width: 275, height: 275)
				.foregroundStyle(.black)
				.border(boardColor, width: 5)
			
			VStack {
				
				Text(gameResult)
					.foregroundStyle(isSuccess ? .green : .red)
				Button("Start the game") {
					startGame()
				}
				
				// MARK: Row 1
				
				HStack {
					
					// Button 1
					
					Button(Arrows.allCases[button1Index].rawValue, systemImage: Arrows.allCases[button1Index].rawValue) {
						
						if button1Index < Arrows.allCases.count - 1 {
							button1Index += 1
							tappedButtons[1] = button1Index
						} else {
							button1Index = 0
							tappedButtons[1] = nil
						}
					}
					.frame(width: 50, height: 50)
					.buttonStyle(.bordered)
					.foregroundColor(.white)
					.labelStyle(.iconOnly)
					
					// Button 2
					
					Button(Arrows.allCases[button2Index].rawValue, systemImage: Arrows.allCases[button2Index].rawValue) {
						
						if button2Index < Arrows.allCases.count - 1 {
							button2Index += 1
							tappedButtons[2] = button2Index
						} else {
							button2Index = 0
							tappedButtons[2] = nil
						}
					}
					.frame(width: 50, height: 50)
					.buttonStyle(.bordered)
					.foregroundColor(.white)
					.labelStyle(.iconOnly)
					
					// Button 3
					
					Button(Arrows.allCases[button3Index].rawValue, systemImage: Arrows.allCases[button3Index].rawValue) {
						
						if button3Index < Arrows.allCases.count - 1 {
							button3Index += 1
							tappedButtons[3] = button3Index
						} else {
							button3Index = 0
							tappedButtons[3] = nil
						}
					}
					.frame(width: 50, height: 50)
					.buttonStyle(.bordered)
					.foregroundColor(.white)
					.labelStyle(.iconOnly)
				}
				
				// MARK: Row 2
				
				HStack {
					
					// Button 4
					
					Button(Arrows.allCases[button4Index].rawValue, systemImage: Arrows.allCases[button4Index].rawValue) {
						
						if button4Index < Arrows.allCases.count - 1 {
							button4Index += 1
							tappedButtons[4] = button4Index
						} else {
							button4Index = 0
							tappedButtons[4] = nil
						}
					}
					.frame(width: 50, height: 50)
					.buttonStyle(.bordered)
					.foregroundColor(.white)
					.labelStyle(.iconOnly)
					
					// Button 5
					
					Button(Arrows.allCases[button5Index].rawValue, systemImage: Arrows.allCases[button5Index].rawValue) {
						
						if button5Index < Arrows.allCases.count - 1 {
							button5Index += 1
							tappedButtons[5] = button5Index
						} else {
							button5Index = 0
							tappedButtons[5] = nil
						}
					}
					.frame(width: 50, height: 50)
					.buttonStyle(.bordered)
					.foregroundColor(.white)
					.labelStyle(.iconOnly)
					
					// Button 6
					
					Button(Arrows.allCases[button6Index].rawValue, systemImage: Arrows.allCases[button6Index].rawValue) {
						
						if button6Index < Arrows.allCases.count - 1 {
							button6Index += 1
							tappedButtons[6] = button6Index
						} else {
							button6Index = 0
							tappedButtons[6] = nil
						}
					}
					.frame(width: 50, height: 50)
					.buttonStyle(.bordered)
					.foregroundColor(.white)
					.labelStyle(.iconOnly)
				}
				
				// MARK: Row 3
				
				HStack {
					
					// Button 7
					
					Button(Arrows.allCases[button7Index].rawValue, systemImage: Arrows.allCases[button7Index].rawValue) {
						
						if button7Index < Arrows.allCases.count - 1 {
							button7Index += 1
							tappedButtons[7] = button7Index
						} else {
							button7Index = 0
							tappedButtons[7] = nil
						}
					}
					.frame(width: 50, height: 50)
					.buttonStyle(.bordered)
					.foregroundColor(.white)
					.labelStyle(.iconOnly)
					
					// Button 8
					
					Button(Arrows.allCases[button8Index].rawValue, systemImage: Arrows.allCases[button8Index].rawValue) {
						
						if button8Index < Arrows.allCases.count - 1 {
							button8Index += 1
							tappedButtons[8] = button8Index
						} else {
							button8Index = 0
							tappedButtons[8] = nil
						}
					}
					.frame(width: 50, height: 50)
					.buttonStyle(.bordered)
					.foregroundColor(.white)
					.labelStyle(.iconOnly)
					
					// Button 9
					
					Button(Arrows.allCases[button9Index].rawValue, systemImage: Arrows.allCases[button9Index].rawValue) {
						
						if button9Index < Arrows.allCases.count - 1 {
							button9Index += 1
							tappedButtons[9] = button9Index
						} else {
							button9Index = 0
							tappedButtons[9] = nil
						}
					}
					.frame(width: 50, height: 50)
					.buttonStyle(.bordered)
					.foregroundColor(.white)
					.labelStyle(.iconOnly)
				}
				
				Button("Defuse") {
					self.defuseTrap()
				}
			}
		}
		
	}
}
	
// MARK: Game Generation

extension TrapDefusionMiniGameView {
	
	func startGame() {
		
		// 1. Create or fill a dictionary of button positions with it's arrow index
		
		gameWasStarted = true
		
		patternButtons = [:]
		tappedButtons = [:]
		setButtonsPositionsToDefault()
		
		while patternButtons.count < 3 {
			
			let button = Int.random(in: 1...9)
			let index = Int.random(in: 1...3)
			
			if (patternButtons.keys.filter { $0 == button }).isEmpty {
				patternButtons[button] = index
			}
				
		}
		
		// 2. Read the dictionary and set arrows accordingly to it's new indices
		
		for position in patternButtons {
			
			switch position.key {
				
			case 1: button1Index = position.value
			case 2: button2Index = position.value
			case 3: button3Index = position.value
			case 4: button4Index = position.value
			case 5: button5Index = position.value
			case 6: button6Index = position.value
			case 7: button7Index = position.value
			case 8: button8Index = position.value
			case 9: button9Index = position.value
			default: break
			}
		}
		
		// 3. Clear all buttons back to default position of arrow.up
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
			setButtonsPositionsToDefault()
		}
		
	}
	
	/// Set all buttons to "Arrow.up" position
	func setButtonsPositionsToDefault() {
		button1Index = 0
		button2Index = 0
		button3Index = 0
		button4Index = 0
		button5Index = 0
		button6Index = 0
		button7Index = 0
		button8Index = 0
		button9Index = 0
	}
	
	/// Method to detect if user's tapped buttons are equal to pattern ones and if yes -> send Success to MapView, otherwise send False
	func defuseTrap() {
		
		guard !patternButtons.isEmpty && gameWasStarted else { return }
		
		if patternButtons == tappedButtons {
			isSuccess = true
			gameResult = "Success!"
			boardColor = .green
		} else {
			isSuccess = false
			gameResult = "Failure!"
			boardColor = .red
		}
		onGameEnd?(isSuccess)
		
		// add to avoid unconsistencies
		setButtonsPositionsToDefault()
		gameWasStarted = false
	}
}
