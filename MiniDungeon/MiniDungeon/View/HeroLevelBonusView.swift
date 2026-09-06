import SwiftUI

// MARK: - HeroLevelBonusView

extension MainView {
	
	@ViewBuilder
	func buildHeroLevelBonusView() -> some View {
		
		VStack {
			
			List {
				
				Section(header: Text(isEnglish() ? "Hero Level Bonus" : "Бонус Уровня Героя")) {
					
					ForEach(viewModel.gameState.heroLevelBonusesToChoose.compactMap { $0 }) { bonus in
						Button(isEnglish() ? bonus.nameEN : bonus.nameRU) {
							viewModel.gameState.heroLevelBonusToDisplay = bonus
						}
						.foregroundStyle(bonus.rarity.color)
					}
				}
				
				if viewModel.gameState.heroLevelBonusToDisplay != nil {
					
					Section(header: Text(isEnglish() ? "Description" : "Описание")) {
						
						if isEnglish() {
							Text("Name - \(viewModel.gameState.heroLevelBonusToDisplay?.nameEN ?? "")")
								.foregroundStyle(viewModel.gameState.heroLevelBonusToDisplay?.rarity.color ?? .white)
								.bold()
						} else {
							Text("Название - \(viewModel.gameState.heroLevelBonusToDisplay?.nameRU ?? "")")
								.foregroundStyle(viewModel.gameState.heroLevelBonusToDisplay?.rarity.color ?? .white)
								.bold()
						}
						
						if isEnglish() {
							Text("Description: \(viewModel.gameState.heroLevelBonusToDisplay?.bonusDescriptionEN ?? "")")
							Button("Choose") {
								viewModel.applyHeroLevelBonus(viewModel.gameState.heroLevelBonusToDisplay)
							}
						} else {
							Text("Описание: \(viewModel.gameState.heroLevelBonusToDisplay?.bonusDescriptionRU ?? "")")
							Button("Выбрать") {
								viewModel.applyHeroLevelBonus(viewModel.gameState.heroLevelBonusToDisplay)
							}
						}
					}
				}
			}
		}
	}
}
