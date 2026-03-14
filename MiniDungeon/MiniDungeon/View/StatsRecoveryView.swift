import SwiftUI

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
									in: 1...100
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
								in: 1...100
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
	
	func recoverHPLocally(by value: Int) {
		
		if (hpToRestore + currentHPValue) <= maxHPValue {
			
			if value * unitCostInGold <= currentGoldValue {
				
				print("old local hp value: \(currentHPValue)")
				print("old local gold value: \(currentGoldValue)")
				currentHPValue += value
				currentGoldValue -= (value * unitCostInGold)
				hpToRestore = 1
				print("new local hp value: \(currentHPValue)")
				print("new local gold value: \(currentGoldValue)")
				
			} else {
				print("Not Enough Gold")
				return
			}
			
		} else {
			print("Too Many HP points to recover!")
			return
		}
	}
	
	func recoverMPLocally(by value: Int) {
		
		if (mpToRestore + currentMPValue) <= maxMPValue {
			
			if value * unitCostInGold <= currentGoldValue {
				
				print("old local mp value: \(currentMPValue)")
				print("old local gold value: \(currentGoldValue)")
				currentMPValue += value
				currentGoldValue -= (value * unitCostInGold)
				mpToRestore = 1
				print("new local mp value: \(currentMPValue)")
				print("new local gold value: \(currentGoldValue)")
				
			} else {
				print("Not Enough Gold")
				return
			}
		} else {
			print("Too Many MP points to recover!")
			return
		}
		
	}
}
