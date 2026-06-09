import SwiftUI

// MARK: - Town Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildTownView() -> some View {
		
		List {
			
			// MARK: - Header
			
			Section(header: Text("Town")) {
				Text("Current Dark Energy: \(viewModel.gameState.heroDarkEnergy)")
			}
			
			// MARK: - Shrine Info
			
			if viewModel.gameState.shrineUpgradeToDisplay != nil {
				Section(header: Text("Description")) {
					Text("\(isEnglish() ? "Name:" : "Название:") \((isEnglish() ? (viewModel.gameState.shrineUpgradeToDisplay?.nameEN ?? "") : viewModel.gameState.shrineUpgradeToDisplay?.nameRU) ?? "")")
					Text("\(isEnglish() ? "Description:" : "Описание") \((isEnglish() ? viewModel.gameState.shrineUpgradeToDisplay?.shrineDescriptionEN : viewModel.gameState.shrineUpgradeToDisplay?.shrineDescriptionRU) ?? "")")
					
					if isEnglish() {
						Text("Cost: \(viewModel.gameState.shrineUpgradeToDisplay?.darkEnergyCost ?? 0) dark energy")
					} else {
						Text("Стоимость: \(viewModel.gameState.shrineUpgradeToDisplay?.darkEnergyCost ?? 0) темной энергии")
					}
					
					Button(isEnglish() ? "Activate" : "Активировать") {
						viewModel.activateShrine(viewModel.gameState.shrineUpgradeToDisplay)
						viewModel.gameState.shrineUpgradeToDisplay = nil
					}
				}
			}
		}
		.frame(height: 350)
		
		List {
			
			// MARK: - Minor Shrines
			
			// Implement a method to check all minor shrines not being upgraded to display this list
			
			if !viewModel.checkIsThereShrinesToUpgrade(ShrineManager.commonShrines) {
				
				Section(header: Text(isEnglish() ? "Minor Shrines" : "Небольшие Алтари")) {
					
					ForEach(ShrineManager.commonShrines) { shrine in
						
						if !viewModel.gameState.upgradedShrines.contains(shrine) {
							
							Button("\(viewModel.gameState.isEnglishLocalisation ? shrine.nameEN : shrine.nameRU)") {
								viewModel.gameState.shrineUpgradeToDisplay = shrine
							}
						}
					}
				}
			}
			
			// MARK: - Medium Shrines
			
			if !viewModel.checkIsThereShrinesToUpgrade(ShrineManager.rareShrines) {
				
				Section(header: Text(isEnglish() ? "Medium Shrines" : "Средние Алтари")) {
					
					ForEach(ShrineManager.rareShrines) { shrine in
						
						if !viewModel.gameState.upgradedShrines.contains(shrine) {
							
							Button("\(viewModel.gameState.isEnglishLocalisation ? shrine.nameEN : shrine.nameRU)") {
								viewModel.gameState.shrineUpgradeToDisplay = shrine
							}
						}
					}
				}
			}
			
			// MARK: - Big Shrines
			
			if !viewModel.checkIsThereShrinesToUpgrade(ShrineManager.epicShrines) {
				
				Section(header: Text(isEnglish() ?  "Big Shrines" : "Большие Алтари")) {
					
					ForEach(ShrineManager.epicShrines) { shrine in
						
						if !viewModel.gameState.upgradedShrines.contains(shrine) {
							
							Button("\(viewModel.gameState.isEnglishLocalisation ? shrine.nameEN : shrine.nameRU)") {
								viewModel.gameState.shrineUpgradeToDisplay = shrine
							}
						}
					}
				}
			}
			
			// MARK: - Huge Shrines
			
			if !viewModel.checkIsThereShrinesToUpgrade(ShrineManager.legendaryShrines) {
				
				Section(header: Text(isEnglish() ? "Huge Shrines" : "Великие Алтари")) {
					
					ForEach(ShrineManager.legendaryShrines) { shrine in
						
						if !viewModel.gameState.upgradedShrines.contains(shrine) {
							
							Button("\(viewModel.gameState.isEnglishLocalisation ? shrine.nameEN : shrine.nameRU)") {
								viewModel.gameState.shrineUpgradeToDisplay = shrine
							}
						}
					}
				}
			}
		}
		.frame(height: 250)
		
		// MARK: - Navigation
		
		List {
			
			Section(header: Text(isEnglish() ? "Navigation" : "Навигация")) {
				
				Menu(isEnglish() ? "Activated Shrines" : "Активные Алтари") {
					
					// MARK: - Activated Shrines
					
					if !viewModel.gameState.upgradedShrines.isEmpty {
						
						ForEach(viewModel.gameState.upgradedShrines) { shrine in
							
							Button("\(viewModel.gameState.isEnglishLocalisation ? shrine.nameEN : shrine.nameRU)") {
								viewModel.gameState.shrineUpgradeToDisplay = shrine
							}
							.foregroundStyle(.white)
						}
					}
				}
				
				// TODO: Make it to -> FlaskTalantsView
				Button(isEnglish() ? "Go to Flask Talants" : "Перейти к Талантам Фляги") {
					viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
					viewModel.applyActiveShrineEffectsAndGoToFlaskTalants()
				}
			}
		}
	}
}
