import SwiftUI

// MARK: - StatsRecoveryView

extension MainView {
	
	/// View with Sliders to recover HP/MP for gold. It's changes values locally and passes it to the GameState via viewModel when you press button "Confirm"
	struct StatsRecoveryView: View {
		
		@State var currentHPValue: Int
		@State var hpToRestore = 1
		@State var maxHPValue: Int
		
		@State var currentMPValue: Int
		@State var mpToRestore = 1
		@State var maxMPValue: Int
		@State var currentGoldValue: Int
		
		var audioManager: AudioManager
		
		var unitCostInGold = 5
		
		var statsRecoveryResult: ((StatsRecoveryResult) -> Void)?
		
		
		var body: some View {
			
			ZStack {
				
				// Board
				
				Rectangle()
					.frame(width: UIScreen.main.bounds.width - 30, height: 350)
					.foregroundStyle(.black)
					.border(.white, width: 5)
				
				// Main VStack
				
				VStack {
					Spacer()
					
					Text("HP: \(currentHPValue)/\(maxHPValue)")
					Text("MP: \(currentMPValue)/\(maxMPValue)")
					Text("Gold: \(currentGoldValue)")
					
					// VStack for HP
					
					VStack {
						
						Spacer()
						
						VStack {
							HStack {
								Text("HP")
								Slider(
									value: .convert($hpToRestore),
									in: 1...100,
									onEditingChanged: { _ in
										audioManager.playSound(fileName: "sliderScroll1", extensionName: "mp3")
									}
								)
								.frame(width: UIScreen.main.bounds.width - 150)
							}
							Button("Restore \(hpToRestore) hp for \(hpToRestore * unitCostInGold) gold") {
								
								recoverHPLocally(by: hpToRestore)
						
							}
							.buttonStyle(.bordered)
						}
						
						// VStack for MP
						
						VStack {
							
						HStack {
							
							Slider(
								value: .convert($mpToRestore),
								in: 1...100,
								onEditingChanged: { _ in
									audioManager.playSound(fileName: "sliderScroll1", extensionName: "mp3")
								}
							)
							.frame(width: UIScreen.main.bounds.width - 150)
						}
							Button("Restore \(mpToRestore) mp for \(mpToRestore * unitCostInGold) gold") {
								
								recoverMPLocally(by: mpToRestore)
							}
							.buttonStyle(.bordered)
						}
						Spacer()
						Button("Confirm") {
							audioManager.playSound(fileName: "confirm", extensionName: "mp3")
							statsRecoveryResult?(
								
								StatsRecoveryResult(
									newCurrentHPValue: currentHPValue,
									newCurrentMPValue: currentMPValue,
									newCurrentGoldValue: currentGoldValue
								)
							)
						}
						Spacer()
					}
					
					
				}
			}
		}
	}
	
}

extension MainView.StatsRecoveryView {
	
	// MARK: - recoverHPLocally
	
	func recoverHPLocally(by value: Int) {
		
		if (hpToRestore + currentHPValue) <= maxHPValue {
			
			if value * unitCostInGold <= currentGoldValue {
				
				audioManager.playSound(fileName: "confirm1", extensionName: "mp3")
				print("old local hp value: \(currentHPValue)")
				print("old local gold value: \(currentGoldValue)")
				currentHPValue += value
				currentGoldValue -= (value * unitCostInGold)
				hpToRestore = 1
				print("new local hp value: \(currentHPValue)")
				print("new local gold value: \(currentGoldValue)")
				
			} else {
				print("Not Enough Gold")
				audioManager.playSound(fileName: "denied", extensionName: "mp3")
				return
			}
			
		} else {
			print("Too Many HP points to recover!")
			return
		}
	}
	
	// MARK: - recoverMPLocally
	
	func recoverMPLocally(by value: Int) {
		
		if (mpToRestore + currentMPValue) <= maxMPValue {
			
			audioManager.playSound(fileName: "confirm1", extensionName: "mp3")
			
			if value * unitCostInGold <= currentGoldValue {
				
				print("old local mp value: \(currentMPValue)")
				print("old local gold value: \(currentGoldValue)")
				currentMPValue += value
				currentGoldValue -= (value * unitCostInGold)
				mpToRestore = 1
				print("new local mp value: \(currentMPValue)")
				print("new local gold value: \(currentGoldValue)")
				
			} else {
				audioManager.playSound(fileName: "denied", extensionName: "mp3")
				print("Not Enough Gold")
				return
			}
		} else {
			print("Too Many MP points to recover!")
			return
		}
		
	}
}
