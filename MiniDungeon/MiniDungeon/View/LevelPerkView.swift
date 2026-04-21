import SwiftUI

/*
 var levelPerkToDisplay: LevelPerk?
 var levelPerkToChoose: [LevelPerk?] = []
 var selectedLevelPerks: [LevelPerk] = []
 */

// MARK: - HeroLevelBonusView

extension MainView {
	
	@ViewBuilder
	func buildLevelPerkView() -> some View {
		
		VStack {
			
			List {
				
				Section(header: Text("Level Perks")) {
					
					// Replace from gameState.selectedLevelPerks
					
					ForEach(viewModel.gameState.levelPerksToChoose.compactMap { $0 }) { bonus in
						Button(bonus.name) {
							viewModel.gameState.levelPerkToDisplay = bonus
						}
						.foregroundStyle(bonus.rarity.color)
					}
				}
				
				// Replace with gameState.LevelPerkToDisplay
				
				if viewModel.gameState.levelPerkToDisplay != nil {
					
					Section(header: Text("Description")) {

						Text("Name - \(viewModel.gameState.levelPerkToDisplay?.name ?? "")")
							.foregroundStyle(viewModel.gameState.levelPerkToDisplay?.rarity.color ?? .white)
							.bold()
						Text("Description:  \(viewModel.gameState.levelPerkToDisplay?.perkDescription ?? "")")
						Button("Choose") {
							viewModel.applyLevelPerk(viewModel.gameState.levelPerkToDisplay)
						}
					}
				}
			}
		}
	}
}
