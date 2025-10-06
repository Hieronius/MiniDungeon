import SwiftUI

// MARK: - LevelBonus View

extension MainView {
	
	@ViewBuilder
	func buildLevelBonus() -> some View {
		
		VStack {
			
			List {
				
				Section(header: Text("Level Bonus")) {
					Button("\(viewModel.gameState.levelBonusesToChoose[0].name)") {
						viewModel.gameState.levelBonusToDisplay = viewModel.gameState.levelBonusesToChoose[0]
					}
					Button("\(viewModel.gameState.levelBonusesToChoose[1].name)") {
						viewModel.gameState.levelBonusToDisplay = viewModel.gameState.levelBonusesToChoose[1]
					}
					Button("\(viewModel.gameState.levelBonusesToChoose[2].name)") {
						viewModel.gameState.levelBonusToDisplay = viewModel.gameState.levelBonusesToChoose[2]
					}
				}
				
				Section(header: Text("Description")) {
					Text("Name - \(viewModel.gameState.levelBonusToDisplay?.name ?? "")")
					Text("Description:  \(viewModel.gameState.levelBonusToDisplay?.description ?? "")")
					Button("Choose") {
						viewModel.applyLevelBonus(viewModel.gameState.levelBonusToDisplay)
						viewModel.gameState.hero.levelUP()
						viewModel.goToDungeon()
					}
				}
			}
		}
	}
}
