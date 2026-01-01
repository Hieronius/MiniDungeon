import SwiftUI

// MARK: - LevelBonus View

extension MainView {
	
	@ViewBuilder
	func buildLevelBonus() -> some View {
		
		VStack {
			
			List {
				
				Section(header: Text("Level Bonus")) {
					
					ForEach(viewModel.gameState.levelBonusesToChoose.compactMap { $0 }) { bonus in
						Button(bonus.name) {
							viewModel.gameState.levelBonusToDisplay = bonus
						}
					}
				}
				
				if viewModel.gameState.levelBonusToDisplay != nil {
					Section(header: Text("Description")) {
						Text("Name - \(viewModel.gameState.levelBonusToDisplay?.name ?? "")")
							.bold()
						Text("Description:  \(viewModel.gameState.levelBonusToDisplay?.bonusDescription ?? "")")
						Button("Choose") {
							viewModel.applyLevelBonus(viewModel.gameState.levelBonusToDisplay)
						}
					}
				}
			}
		}
	}
}
