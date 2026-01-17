import SwiftUI

// MARK: - Hero Stats Screen (View)

extension MainView {
	
	func buildEnemyStatsView() -> some View {
		
		List {
			
			Section(header: Text("Enemy Stats")) {
				
				Text("HP:  \(viewModel.gameState.enemy.enemyCurrentHP)/\(viewModel.gameState.enemy.enemyMaxHP)")
				Text("MP:  \(viewModel.gameState.enemy.currentMana)/\(viewModel.gameState.enemy.maxMana)")
			}
			
			Section(header: Text("Combat")) {
				
				Text("Damage:  \(viewModel.gameState.enemy.minDamage) - \(viewModel.gameState.enemy.maxDamage)")
				Text("Defence: \(viewModel.gameState.enemy.defence)")
			}
			
			Section(header: Text("Navigation")) {

				Button("Go To Battle") {
					viewModel.goToBattle()
				}
			}
		}
	}
}
