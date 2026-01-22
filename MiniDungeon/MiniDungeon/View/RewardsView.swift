import SwiftUI

// MARK: - Rewards Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildRewardsView() -> some View {
		
		List {
			
			Section(header: Text("Outcome")) {
				
				if viewModel.gameState.goldLootToDisplay != 0 {
					Text("Gold: \(viewModel.gameState.goldLootToDisplay)")
				}
				
				if viewModel.gameState.expLootToDisplay != 0 {
					Text("Experience: \(viewModel.gameState.expLootToDisplay)")
				}
				
				if viewModel.gameState.darkEnergyLootToDisplay != 0 {
					Text("Dark Energy: \(viewModel.gameState.darkEnergyLootToDisplay)")
				}
				
				if viewModel.gameState.healthPointsLootToDisplay != 0 {
					Text("Health Points: \(viewModel.gameState.healthPointsLootToDisplay)")
				}
				
				if viewModel.gameState.manaPointsLootToDisplay != 0 {
					Text("Mana Points: \(viewModel.gameState.manaPointsLootToDisplay)")
				}
			}
			
			if !viewModel.gameState.lootToDisplay.isEmpty {
				
				Section(header: Text("Loot")) {
					
					ForEach(viewModel.gameState.lootToDisplay, id: \.self) { item in
						Text(item)
					}
					
				}
			}
			
			Button("Got it") {
				viewModel.getRewardsAndCleanTheScreen()
				itemToDisplay = nil
			}
		}
	}
}
