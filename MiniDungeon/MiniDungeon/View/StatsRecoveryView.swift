import SwiftUI

/*
 
 TODO: 👇
 - ZStack
 - Board
 - Text(HP)
 - SliderView (0...100)
 - Button (restore \(hp) for \(hp * hpCost)
 - viewModel.restoreStat(_ stat: HP, _ forGold: Int) -> hero.currentHP += hpRecoveryValue
 - button "close" -> isStatsRecoveryViewOpen = false
 
 
 
 
 
 */

extension MainView {
	
	@ViewBuilder
	func buildStatsRecoveryView(
		
		currentHPValue: Int,
		maxHPValue: Int,
		currentMPValue: Int,
		maxMPValue: Int,
		gold: Int
		
	) -> some View {
		
		VStack {
			StatsRecoveryView(
				
				currentHPValue: currentHPValue,
				maxHPValue: maxHPValue,
				currentMPValue: currentMPValue,
				maxMPValue: maxMPValue,
				gold: gold
			)
		}
	}
}

extension MainView {
	
	struct StatsRecoveryView: View {
		
		@State var currentHPValue: Int
		@State var hpToRestore = 1
		@State var maxHPValue: Int
		
		@State var currentMPValue: Int
		@State var mpToRestore = 1
		@State var maxMPValue: Int
		@State var gold: Int
		
		var statsRecoveryResult: ((Int, Int, Int) -> ())?
		
		
		var body: some View {
			
			ZStack {
				
				// Board
				
				Rectangle()
					.frame(width: UIScreen.main.bounds.width - 30, height: 250)
					.foregroundStyle(.black)
					.border(.white, width: 5)
				
				// Main VStack
				
				VStack {
					Spacer()
					
					Text("Current HP: \(currentHPValue)/\(maxHPValue) Current MP: \(currentMPValue)/\(maxMPValue) Gold: \(gold)")
					
					// VStack for HP
					
					VStack {
						
						Spacer()
						
						VStack {
							HStack {
								Text("HP: \(hpToRestore)")
								Slider(
									value: .convert($hpToRestore),
									in: 1...100
								)
								.frame(width: UIScreen.main.bounds.width - 150)
							}
							Button("Restore for \(hpToRestore * 5) Gold") {
//								 restore locally
							}
						}
						
						// VStack for MP
						
						VStack {
							
						HStack {
							Text("MP: \(mpToRestore)")
							
							Slider(
								value: .convert($mpToRestore),
								in: 1...100
							)
							.frame(width: UIScreen.main.bounds.width - 150)
						}
							Button("Restore MP") {
								// restore locally
							}
						}
						Spacer()
						Button("Close Window") {
							// send result closure to mainView and update current HP, MP and Gold
						}
						Spacer()
					}
					
					
				}
			}
		}
	}
}
