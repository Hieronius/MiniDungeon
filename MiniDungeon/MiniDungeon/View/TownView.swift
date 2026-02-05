import SwiftUI

// MARK: - Town Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildTownView() -> some View {
		
		List {
			
			// MARK: - Header
			
			Section(header: Text("Town")) {
				Text("Current Dark Energy: \(viewModel.gameState.heroDarkEnergy)")
			}
			
			// MARK: - Shrine Info
			
			if viewModel.gameState.shrineUpgradeToDisplay != nil {
				Section(header: Text("Description")) {
					Text("Name: \(viewModel.gameState.shrineUpgradeToDisplay?.name ?? "")")
					Text("Description: \(viewModel.gameState.shrineUpgradeToDisplay?.shrineDescription ?? "")")
					Text("Cost: \(viewModel.gameState.shrineUpgradeToDisplay?.darkEnergyCost ?? 0) dark energy")
					Button("Activate") {
						viewModel.activateShrine(viewModel.gameState.shrineUpgradeToDisplay)
						viewModel.gameState.shrineUpgradeToDisplay = nil
					}
				}
			}
		}
		.frame(height: 350)
		
		List {
			
			// MARK: - Minor Shrines
			
			// Implement a method to check all minor shrines not being upgraded to display this list
			
			if !viewModel.checkIsThereShrinesToUpgrade(ShrineManager.commonShrines) {
				
				Section(header: Text("Minor Shrines")) {
					
					ForEach(ShrineManager.commonShrines) { shrine in
						
						if !viewModel.gameState.upgradedShrines.contains(shrine) {
							
							Button("\(shrine.name)") {
								viewModel.gameState.shrineUpgradeToDisplay = shrine
							}
						}
					}
				}
			}
			
			// MARK: - Medium Shrines
			
			if !viewModel.checkIsThereShrinesToUpgrade(ShrineManager.rareShrines) {
				
				Section(header: Text("Medium Shrines")) {
					
					ForEach(ShrineManager.rareShrines) { shrine in
						
						if !viewModel.gameState.upgradedShrines.contains(shrine) {
							
							Button("\(shrine.name)") {
								viewModel.gameState.shrineUpgradeToDisplay = shrine
							}
						}
					}
				}
			}
			
			// MARK: - Big Shrines
			
			if !viewModel.checkIsThereShrinesToUpgrade(ShrineManager.epicShrines) {
				
				Section(header: Text("Big Shrines")) {
					
					ForEach(ShrineManager.epicShrines) { shrine in
						
						if !viewModel.gameState.upgradedShrines.contains(shrine) {
							
							Button("\(shrine.name)") {
								viewModel.gameState.shrineUpgradeToDisplay = shrine
							}
						}
					}
				}
			}
			
			// MARK: - Huge Shrines
			
			if !viewModel.checkIsThereShrinesToUpgrade(ShrineManager.legendaryShrines) {
				
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
		}
		.frame(height: 300)
		
		// MARK: - Navigation
		
		List {
			
			Section(header: Text("Navigation")) {
				
				Menu("Active Shrines") {
					
					// MARK: - Activated Shrines
					
					if !viewModel.gameState.upgradedShrines.isEmpty {
						
						ForEach(viewModel.gameState.upgradedShrines) { shrine in
							
							Button("\(shrine.name)") {
								viewModel.gameState.shrineUpgradeToDisplay = shrine
							}
							.foregroundStyle(.white)
						}
					}
				}
				
				// TODO: Make it to -> FlaskTalantsView
				Button("Go to Flask Talants") {
					viewModel.applyActiveShrineEffectsAndGoToFlaskTalants()
				}
			}
		}
	}
}
