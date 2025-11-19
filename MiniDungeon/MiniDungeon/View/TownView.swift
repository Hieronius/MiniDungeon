import SwiftUI

// MARK: - Town Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildTown() -> some View {
		
		List {
			
			Section(header: Text("Town")) {
				Text("Dark Energy: \(viewModel.gameState.heroDarkEnergy - 10 > 0 ? viewModel.gameState.heroDarkEnergy - 10 : 0)")
			}
			
			if viewModel.gameState.shrineUpgradeToDisplay != nil {
				Section(header: Text("Description")) {
					Text("Name: \(viewModel.gameState.shrineUpgradeToDisplay?.name ?? "")")
					Text("Description: \(viewModel.gameState.shrineUpgradeToDisplay?.description ?? "")")
					Text("Cost: \(viewModel.gameState.shrineUpgradeToDisplay?.darkEnergyCost ?? 0) dark energy")
					Button("Activate") {
						viewModel.activateShrine(viewModel.gameState.shrineUpgradeToDisplay)
					}
				}
			}
		}
		.frame(height: 350)
		
		
		List {
			
			if !viewModel.gameState.upgradedShrines.isEmpty {
				Section(header: Text("Active Shrines")) {
					
					ForEach(viewModel.gameState.upgradedShrines) { shrine in
						
						Button("\(shrine.name)") {
							viewModel.gameState.shrineUpgradeToDisplay = shrine
						}
						.foregroundStyle(.white)
					}
				}
			}
		}
		
		List {
			
			Section(header: Text("Minor Shrines")) {
				
				ForEach(ShrineManager.commonShrines) { shrine in
					
					if !viewModel.gameState.upgradedShrines.contains(shrine) {
						
						Button("\(shrine.name)") {
							viewModel.gameState.shrineUpgradeToDisplay = shrine
						}
					}
				}
			}
			
			Section(header: Text("Medium Shrines")) {
				
				ForEach(ShrineManager.rareShrines) { shrine in
					
					if !viewModel.gameState.upgradedShrines.contains(shrine) {
						
						Button("\(shrine.name)") {
							viewModel.gameState.shrineUpgradeToDisplay = shrine
						}
					}
				}
			}
			
			Section(header: Text("Big Shrines")) {
				
				ForEach(ShrineManager.epicShrines) { shrine in
					
					if !viewModel.gameState.upgradedShrines.contains(shrine) {
						
						Button("\(shrine.name)") {
							viewModel.gameState.shrineUpgradeToDisplay = shrine
						}
					}
				}
			}
			
			Section(header: Text("Huge Shrines")) {
				
				ForEach(ShrineManager.legendaryShrines) { shrine in
					
					if !viewModel.gameState.upgradedShrines.contains(shrine) {
						
						Button("\(shrine.name)") {
							viewModel.gameState.shrineUpgradeToDisplay = shrine
						}
					}
				}
			}
		}
		
		List {
			
			Section(header: Text("Navigation")) {
				
				Button("Go To Menu") {
					viewModel.applyActiveShrineEffectsAndGoToSpecialisation()
				}
			}
		}
	}
}
