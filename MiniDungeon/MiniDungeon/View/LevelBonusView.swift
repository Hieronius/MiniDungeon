import SwiftUI

// MARK: - LevelBonus View

extension MainView {
	
	@ViewBuilder
	func buildLevelBonus() -> some View {
		
		VStack {
			
			List {
				
				Section(header: Text("Bonus Rarities")) {
					Button("\(viewModel.gameState.levelBonusesRarities[0])".uppercased()) {
						
					}
					Button("\(viewModel.gameState.levelBonusesRarities[1])".uppercased()) {
						
					}
					Button("\(viewModel.gameState.levelBonusesRarities[2])".uppercased()) {
						
					}
				}
				
				Section(header: Text("Rewards")) {
					ForEach(viewModel.gameState.levelBonusesToChoose, id: \.self) { bonus in
						Button(bonus.name) {
							viewModel.gameState.levelBonusToDisplay = bonus
						}
					}
				}
				
				Section(header: Text("Description")) {
					Text("Name - \(viewModel.gameState.levelBonusToDisplay?.name ?? "")")
					Text("Description - \(viewModel.gameState.levelBonusToDisplay?.description ?? "")")
					Button("Choose") {
//						viewModel.applySpecialisation(viewModel.gameState.specToDisplay)
						// viewModel.applyLevelBonus(viewModel.gameState.specToDisplay)
						viewModel.goToMenu()
					}
				}
			}
		}
	}
}
