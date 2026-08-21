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
			
			Section(header: Text(isEnglish() ? "Flask Talants" : "Таланты Фляги")) {
				if isEnglish() {
					Text("Dark Energy Capacity Overall: \(viewModel.gameState.heroMaxDarkEnergyOverall)")
				} else {
					Text("Общее Количество Собранной Темной Энергии: \(viewModel.gameState.heroMaxDarkEnergyOverall)")
				}
			}
			
			// MARK: - Flask Talant Info
			
			if viewModel.gameState.flaskTalantToDisplay != nil {
				Section(header: Text(isEnglish() ? "Description" : "Описание")) {
					
					if isEnglish() {
						
						Text("Name: \(viewModel.gameState.flaskTalantToDisplay?.nameEN ?? "")")
						Text("Description: \(viewModel.gameState.flaskTalantToDisplay?.flaskTalantDescriptionEN ?? "")")
						Text("Dark Energy To Collect: \(viewModel.gameState.flaskTalantToDisplay?.darkEnergyLevelToUpgrade ?? 0) dark energy")
						Button("Activate") {
							viewModel.activateFlaskTalant(viewModel.gameState.flaskTalantToDisplay)
						}
						
					} else {
						
						Text("Название: \(viewModel.gameState.flaskTalantToDisplay?.nameRU ?? "")")
						Text("Описание: \(viewModel.gameState.flaskTalantToDisplay?.flaskTalantDescriptionRU ?? "")")
						Text("Необходимое количество темной энергии: \(viewModel.gameState.flaskTalantToDisplay?.darkEnergyLevelToUpgrade ?? 0) темной энергии")
						Button("Активировать") {
							viewModel.activateFlaskTalant(viewModel.gameState.flaskTalantToDisplay)
						}
					}
				}
			}
		}
		.frame(height: 350)
	
	List {
		
		// MARK: - Minor Talants
		
		// Implement a method to check all minor shrines not being upgraded to display this list
		
		if !viewModel.checkIsThereFlaskTalantsToUpgrade(FlaskTalantManager.minorTalants) {
			
			Section(header: Text(isEnglish() ? "Minor Talants" : "Небольшие Таланты")) {
				
				ForEach(FlaskTalantManager.minorTalants) { talant in
					
					if !viewModel.gameState.upgradedFlaskTalants.contains(talant) {
						
						if isEnglish() {
							Button("\(talant.nameEN)") {
								viewModel.gameState.flaskTalantToDisplay = talant
							}
						} else {
							Button("\(talant.nameRU)") {
								viewModel.gameState.flaskTalantToDisplay = talant
							}
						}
					}
				}
			}
		}
		
		// MARK: - Medium Talants
		
		if !viewModel.checkIsThereFlaskTalantsToUpgrade(FlaskTalantManager.mediumTalants) {
			
			Section(header: Text(isEnglish() ? "Medium Talants" : "Средние Таланты")) {
				
				ForEach(FlaskTalantManager.mediumTalants) { talant in
					
					if !viewModel.gameState.upgradedFlaskTalants.contains(talant) {
						
						if isEnglish() {
							Button("\(talant.nameEN)") {
								viewModel.gameState.flaskTalantToDisplay = talant
							}
						} else {
							Button("\(talant.nameRU)") {
								viewModel.gameState.flaskTalantToDisplay = talant
							}
						}
					}
				}
			}
		}
		
		// MARK: - Huge Talants
		
		if !viewModel.checkIsThereFlaskTalantsToUpgrade(FlaskTalantManager.hugeTalants) {
			
			Section(header: Text(isEnglish() ? "Huge Talants" : "Большие Таланты")) {
				
				ForEach(FlaskTalantManager.hugeTalants) { talant in
					
					if !viewModel.gameState.upgradedFlaskTalants.contains(talant) {
						
						if isEnglish() {
							Button("\(talant.nameEN)") {
								viewModel.gameState.flaskTalantToDisplay = talant
							}
						} else {
							Button("\(talant.nameRU)") {
								viewModel.gameState.flaskTalantToDisplay = talant
							}
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
	.frame(height: 250)
		
		// MARK: - Navigation
		
		List {
			
			Section(header: Text(isEnglish() ? "Navigation" : "Навигация")) {
				
				Menu(isEnglish() ? "Active Flask Talants" : "Активные Таланты Фляги") {
					
					// MARK: - Activated Shrines
					
					if !viewModel.gameState.upgradedFlaskTalants.isEmpty {
						
						ForEach(viewModel.gameState.upgradedFlaskTalants) { talant in
							
							if isEnglish() {
								
								Button("\(talant.nameEN)") {
									viewModel.gameState.flaskTalantToDisplay = talant
								}
								.foregroundStyle(.white)
								
							} else {
								
								Button("\(talant.nameRU)") {
									viewModel.gameState.flaskTalantToDisplay = talant
								}
								.foregroundStyle(.white)
							}
						}
					}
				}
				
				Button(isEnglish() ? "Go to Menu" : "Вернуться в Меню") {
					viewModel.applyActivateFlaskTalantsAndGoToMenu()
				}
			}
		}
	}
}
