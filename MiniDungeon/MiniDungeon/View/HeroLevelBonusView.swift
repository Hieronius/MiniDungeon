import SwiftUI

// MARK: - HeroLevelBonusView

extension MainView {
	
	@ViewBuilder
	func buildHeroLevelBonusView() -> some View {
		
		VStack {
			
			List {
				
				Section(header: Text("Hero Level Bonus")) {
					
					ForEach(viewModel.gameState.heroLevelBonusesToChoose.compactMap { $0 }) { bonus in
						Button(bonus.name) {
							viewModel.gameState.heroLevelBonusToDisplay = bonus
						}
					}
				}
				
				if viewModel.gameState.heroLevelBonusToDisplay != nil {
					
					Section(header: Text("Description")) {

						Text("Name - \(viewModel.gameState.heroLevelBonusToDisplay?.name ?? "")")
							.bold()
						Text("Description:  \(viewModel.gameState.heroLevelBonusToDisplay?.bonusDescription ?? "")")
						Button("Choose") {
							viewModel.applyHeroLevelBonus(viewModel.gameState.heroLevelBonusToDisplay)
						}
					}
				}
			}
		}
	}
}
