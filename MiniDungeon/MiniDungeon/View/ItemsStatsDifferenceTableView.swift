import SwiftUI

extension MainView {
	
	@ViewBuilder
	func buildItemsStatsDifferenceTable(forStats: [(String, Color)]) -> some View {
		
		List {
			
			/*
			 forStats.enumerated -> [[index :("stat", .white)]]
			 for each element it will define an index
			 code below uses that index as offset to create a list of unique values
			 an actual stat (string, color) can be used to decide what to print and of what color
			 0 - should be of default color (.white)
			 >0 - should be green
			 <0 - should be red
			 */
			
			ForEach(Array(forStats.enumerated()), id: \.offset) { index, stat in
				Text(stat.0)
					.foregroundColor(stat.1)
			}
			Button("Close") {
				viewModel.gameState.isArmorsStatsDifferenceOpen = false
				viewModel.gameState.isWeaponsStatsDifferenceOpen = false
			}
		}
	}
	
}
