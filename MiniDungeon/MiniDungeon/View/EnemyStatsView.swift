import SwiftUI

// MARK: - Hero Stats Screen (View)

extension MainView {
	
	func buildEnemyStatsView() -> some View {
		
		List {
			
			Section(header: Text(isEnglish() ? "Enemy Stats" : "О противнике")) {
				
				if isEnglish() {
					
					Text("Name: \(viewModel.gameState.enemy.name)")
					
					Text("HP: \(viewModel.gameState.enemy.currentHP)/\(viewModel.gameState.enemy.maxHP)")
					Text("MP: \(viewModel.gameState.enemy.currentMP)/\(viewModel.gameState.enemy.maxMana)")
					
				} else {
					
					Text("Название: \(viewModel.gameState.enemy.name)")
					
					Text("Здоровье: \(viewModel.gameState.enemy.currentHP)/\(viewModel.gameState.enemy.maxHP)")
					Text("Мана: \(viewModel.gameState.enemy.currentMP)/\(viewModel.gameState.enemy.maxMana)")
				}
			}
			
			Section(header: Text(isEnglish() ? "Combat" : "Бой")) {
				
				if isEnglish() {
					
					Text("Damage: \(viewModel.gameState.enemy.minDamage) - \(viewModel.gameState.enemy.maxDamage)")
					Text("Defence: \(viewModel.gameState.enemy.defence)")
					
				} else {
					
					Text("Урон: \(viewModel.gameState.enemy.minDamage) - \(viewModel.gameState.enemy.maxDamage)")
					Text("Броня: \(viewModel.gameState.enemy.defence)")
				}
			}
			
			// MARK: - Navigation
			
			Section(header: Text(isEnglish() ? "Navigation" : "Навигация")) {

				Button(isEnglish() ? "Go To Battle" : "К битве") {
					viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
					viewModel.goToBattle()
				}
			}
		}
	}
}
