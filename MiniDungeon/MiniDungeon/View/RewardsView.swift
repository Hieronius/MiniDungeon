import SwiftUI

// MARK: - Rewards Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildRewardsView() -> some View {
		
		List {
			
			Section(header: Text(isEnglish() ? "Outcome" : "Итоги")) {
				
				if isEnglish() {
					
					if viewModel.gameState.goldLootToDisplay != 0 {
						Text("Gold: \(viewModel.gameState.goldLootToDisplay)")
					}
					
					if viewModel.gameState.expLootToDisplay != 0 {
						Text("Experience: \(viewModel.gameState.expLootToDisplay)")
					}
					
					if viewModel.gameState.darkEnergyLootToDisplay != 0 {
						Text("Dark Energy: \(viewModel.gameState.darkEnergyLootToDisplay)")
					}
					
					if viewModel.gameState.healthPointsLootToDisplay != 0 {
						Text("Health Points: \(viewModel.gameState.healthPointsLootToDisplay)")
					}
					
					if viewModel.gameState.manaPointsLootToDisplay != 0 {
						Text("Mana Points: \(viewModel.gameState.manaPointsLootToDisplay)")
					}
					
				} else {
					
					if viewModel.gameState.goldLootToDisplay != 0 {
						Text("Золото: \(viewModel.gameState.goldLootToDisplay)")
					}
					
					if viewModel.gameState.expLootToDisplay != 0 {
						Text("Опыт: \(viewModel.gameState.expLootToDisplay)")
					}
					
					if viewModel.gameState.darkEnergyLootToDisplay != 0 {
						Text("Темная Энергия: \(viewModel.gameState.darkEnergyLootToDisplay)")
					}
					
					if viewModel.gameState.healthPointsLootToDisplay != 0 {
						Text("Очки Здоровья: \(viewModel.gameState.healthPointsLootToDisplay)")
					}
					
					if viewModel.gameState.manaPointsLootToDisplay != 0 {
						Text("Очки Маны: \(viewModel.gameState.manaPointsLootToDisplay)")
					}
				}
			}
			
			if !viewModel.gameState.lootToDisplay.isEmpty {
				
				Section(header: Text(isEnglish() ? "Loot" : "Добыча")) {
					
					// Test Line
					ForEach(viewModel.gameState.lootContainerToDisplay.items, id: \.self) { item in
						
						if isEnglish() {
							Text(item.labelEN)
								.foregroundStyle(item.rarity.color)
						} else {
							Text(item.labelRU)
								.foregroundStyle(item.rarity.color)
						}
					}
					
					ForEach(viewModel.gameState.lootContainerToDisplay.weapons, id: \.self) {
						weapon in
						
						if isEnglish() {
							Text(weapon.labelEN)
								.foregroundStyle(weapon.rarity.color)
							
						} else {
							Text(weapon.labelRU)
								.foregroundStyle(weapon.rarity.color)
						}
					}
					
					ForEach(viewModel.gameState.lootContainerToDisplay.armors, id: \.self) {
						armor in
						
						if isEnglish() {
							Text(armor.labelEN)
								.foregroundStyle(armor.rarity.color)
							
						} else {
							Text(armor.labelRU)
								.foregroundStyle(armor.rarity.color)
						}
					}
					
				}
			}
			
			Button(isEnglish() ? "Got it" : "Продолжить") {
				viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
				viewModel.getRewardsAndCleanTheScreen()
				itemToDisplay = nil
			}
		}
	}
}
