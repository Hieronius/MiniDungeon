/*
 This View should appear after you activate shrines in TownView and should contains a bunch of talants you simply get via collecting dark energy
 */

import SwiftUI

// MARK: - Flask Talants (View)

extension MainView {

	@ViewBuilder
	func buildFlaskTalantsView() -> some View {
		
		List {
			
			// MARK: - Header
			
			Section(header: Text("Flask Talants")) {
				Text("Dark Energy Capacity Overall: \(viewModel.gameState.heroMaxDarkEnergyOverall)")
			}
			
			// MARK: - Flask Talant Info
			
			if viewModel.gameState.flaskTalantToDisplay != nil {
				Section(header: Text("Description")) {
					Text("Name: \(viewModel.gameState.flaskTalantToDisplay?.name ?? "")")
					Text("Description: \(viewModel.gameState.flaskTalantToDisplay?.flaskTalantDescription ?? "")")
					Text("Dark Energy To Collect: \(viewModel.gameState.flaskTalantToDisplay?.darkEnergyLevelToUpgrade ?? 0) dark energy")
					Button("Activate") {
						viewModel.activateFlaskTalant(viewModel.gameState.flaskTalantToDisplay)
					}
				}
			}
		}
		.frame(height: 350)
	
	List {
		
		// MARK: - Minor Talants
		
		// Implement a method to check all minor shrines not being upgraded to display this list
		
		if !viewModel.checkIsThereFlaskTalantsToUpgrade(FlaskTalantManager.minorTalants) {
			
			Section(header: Text("Minor Talants")) {
				
				ForEach(FlaskTalantManager.minorTalants) { talant in
					
					if !viewModel.gameState.upgradedFlaskTalants.contains(talant) {
						
						Button("\(talant.name)") {
							viewModel.gameState.flaskTalantToDisplay = talant
						}
					}
				}
			}
		}
		
		// MARK: - Medium Talants
		
		if !viewModel.checkIsThereFlaskTalantsToUpgrade(FlaskTalantManager.mediumTalants) {
			
			Section(header: Text("Medium Talants")) {
				
				ForEach(FlaskTalantManager.mediumTalants) { talant in
					
					if !viewModel.gameState.upgradedFlaskTalants.contains(talant) {
						
						Button("\(talant.name)") {
							viewModel.gameState.flaskTalantToDisplay = talant
						}
					}
				}
			}
		}
		
		// MARK: - Huge Talants
		
		if !viewModel.checkIsThereFlaskTalantsToUpgrade(FlaskTalantManager.hugeTalants) {
			
			Section(header: Text("Huge Talants")) {
				
				ForEach(FlaskTalantManager.hugeTalants) { talant in
					
					if !viewModel.gameState.upgradedFlaskTalants.contains(talant) {
						
						Button("\(talant.name)") {
							viewModel.gameState.flaskTalantToDisplay = talant
						}
					}
				}
			}
		}
		
		// MARK: - Great Talants (LOGIC STILL NOT IMPLEMENTED -> UNCOMMENT WHEN IT'S DONE)
		
//		if !viewModel.checkIsThereFlaskTalantsToUpgrade(FlaskTalantManager.greatTalants) {
//			
//			Section(header: Text("Great Talants")) {
//				
//				ForEach(FlaskTalantManager.greatTalants) { talant in
//					
//					if !viewModel.gameState.upgradedFlaskTalants.contains(talant) {
//						
//						Button("\(talant.name)") {
//							viewModel.gameState.flaskTalantToDisplay = talant
//						}
//					}
//				}
//			}
//		}
	}
	.frame(height: 300)
		
		// MARK: - Navigation
		
		List {
			
			Section(header: Text("Navigation")) {
				
				Menu("Active Flask Talants") {
					
					// MARK: - Activated Shrines
					
					if !viewModel.gameState.upgradedFlaskTalants.isEmpty {
						
						ForEach(viewModel.gameState.upgradedFlaskTalants) { talant in
							
							Button("\(talant.name)") {
								viewModel.gameState.flaskTalantToDisplay = talant
							}
							.foregroundStyle(.white)
						}
					}
				}
				
				Button("Go to Menu") {
					viewModel.applyActivateFlaskTalantsAndGoToMenu()
				}
			}
		}
	}
}
