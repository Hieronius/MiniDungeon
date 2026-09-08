/*
 This view should mirror the same logic as HeroLevelBonus
 
 - Throw 3 different bonuses to choose each level up of the flask
 - Remove at the start of each session
 */


import SwiftUI

// MARK: - FlaskLevelBonusView

extension MainView {
	
	@ViewBuilder
	func buildFlaskLevelBonusView() -> some View {
		
		VStack {
			
			List {
				
				Section(header: Text(isEnglish() ? "Flask Level Bonus" : "Бонус Уровня Фляги")) {
					
					ForEach(viewModel.gameState.flaskLevelBonusesToChoose.compactMap { $0 }) { bonus in
						
						if isEnglish() {
							Button(bonus.nameEN) {
								viewModel.gameState.flaskLevelBonusToDisplay = bonus
							}
							.foregroundStyle(bonus.rarity.color)
							
						} else {
							Button(bonus.nameRU) {
								viewModel.gameState.flaskLevelBonusToDisplay = bonus
							}
							.foregroundStyle(bonus.rarity.color)
						}
					}
				}
				
				if viewModel.gameState.flaskLevelBonusToDisplay != nil {
					Section(header: Text(isEnglish() ? "Description" : "Описание")) {
						
						if isEnglish() {
							Text("Name - \(viewModel.gameState.flaskLevelBonusToDisplay?.nameEN ?? "")")
								.foregroundStyle(viewModel.gameState.flaskLevelBonusToDisplay?.rarity.color ?? .white)
								.bold()
							Text("Description: \(viewModel.gameState.flaskLevelBonusToDisplay?.bonusDescriptionEN ?? "")")
							Button("Choose") {
								viewModel.applyFlaskLevelBonus(viewModel.gameState.flaskLevelBonusToDisplay)
							}
							
						} else {
							
							Text("Название - \(viewModel.gameState.flaskLevelBonusToDisplay?.nameRU ?? "")")
								.foregroundStyle(viewModel.gameState.flaskLevelBonusToDisplay?.rarity.color ?? .white)
								.bold()
							Text("Описание: \(viewModel.gameState.flaskLevelBonusToDisplay?.bonusDescriptionRU ?? "")")
							Button("Выбрать") {
								viewModel.applyFlaskLevelBonus(viewModel.gameState.flaskLevelBonusToDisplay)
							}
						}
					}
					}
				}
			}
		}
	}
