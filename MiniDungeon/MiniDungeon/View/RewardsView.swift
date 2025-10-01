import SwiftUI

// MARK: - Rewards Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildRewards() -> some View {
		
		List {
			
			Section(header: Text("Rewards")) {
				Text("Gold - \(viewModel.gameState.goldLootToDisplay)")
				Text("Experience - \(viewModel.gameState.expLootToDisplay)")
			}
			
			Section(header: Text("Loot")) {
				
				ForEach(viewModel.gameState.lootToDisplay, id: \.self) { item in
					Text(item)
				}
				
			}
			
			Button("Got it") {
				viewModel.getRewardsAndCleanTheScreen()
			}
		}
	}
}
