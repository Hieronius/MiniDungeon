import SwiftUI

// MARK: - HeroLevelBonusView

extension MainView {
	
	@ViewBuilder
	func buildLevelPerkView() -> some View {
		
		VStack {
			
			List {
				
				Section(header: Text(isEnglish() ? "Level Perks" : "Перк Уровня")) {
					
					// Replace from gameState.selectedLevelPerks
					
					ForEach(viewModel.gameState.levelPerksToChoose.compactMap { $0 }) { bonus in
						
						if isEnglish() {
							
							Button(bonus.nameEN) {
								viewModel.gameState.levelPerkToDisplay = bonus
							}
							.foregroundStyle(bonus.rarity.color)
							
						} else {
							
							Button(bonus.nameRU) {
								viewModel.gameState.levelPerkToDisplay = bonus
							}
							.foregroundStyle(bonus.rarity.color)
						}
					}
				}
				
				// Replace with gameState.LevelPerkToDisplay
				
				if viewModel.gameState.levelPerkToDisplay != nil {
					
					Section(header: Text(isEnglish() ? "Description" : "Описание")) {

						if isEnglish() {
							Text("Name: \(viewModel.gameState.levelPerkToDisplay?.nameEN ?? "")")
								.foregroundStyle(viewModel.gameState.levelPerkToDisplay?.rarity.color ?? .white)
								.bold()
							Text("Description:  \(viewModel.gameState.levelPerkToDisplay?.perkDescriptionEN ?? "")")
							Button("Choose") {
								viewModel.applyLevelPerk(viewModel.gameState.levelPerkToDisplay)
							}
							
						} else {
							
							Text("Название: \(viewModel.gameState.levelPerkToDisplay?.nameRU ?? "")")
								.foregroundStyle(viewModel.gameState.levelPerkToDisplay?.rarity.color ?? .white)
								.bold()
							Text("Описание:  \(viewModel.gameState.levelPerkToDisplay?.perkDescriptionRU ?? "")")
							Button("Выбрать") {
								viewModel.applyLevelPerk(viewModel.gameState.levelPerkToDisplay)
							}
						}
					}
				}
			}
		}
	}
}
