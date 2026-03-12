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
		
		statName: String,
		currentValue: Double,
		minValue: Double,
		maxValue: Double,
		gold: Int
		
	) -> some View {
		
		VStack {
			StatsRecoveryView(
				statName: statName,
				currentValue: currentValue,
				minValue: minValue,
				maxValue: maxValue,
				gold: gold
			)
		}
	}
}

struct StatsRecoveryView: View {
	
	@State var statName = ""
	@State var currentValue: Double = 0.0
	@State var minValue: Double = 0.0
	@State var maxValue: Double = 100.0
	@State var gold: Int = 0
	
	
	var body: some View {
		
		ZStack {
			
			Rectangle()
				.frame(width: UIScreen.main.bounds.width - 30, height: 200)
				.foregroundStyle(.black)
				.border(.white, width: 5)
			
			VStack {
				
				VStack {
					HStack {
						Text("\(statName)")
//						Slider(value: $currentValue)
						Slider(
							value: $currentValue,
							
							in: minValue...maxValue
						)
						
							.frame(width: UIScreen.main.bounds.width - 150)
					}
					HStack {
						Button("Restore \(Int(currentValue))") {
							// viewModel.gameState.hero.currentHP += (currentValue - minValue)
						}
					}
				}
				
				
			}
		}
	}
}
