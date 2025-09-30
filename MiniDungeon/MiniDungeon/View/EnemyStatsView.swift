import SwiftUI

// MARK: - Hero Stats Screen (View)

extension MainView {
	
	func buildEnemyStats() -> some View {
		
		List {
			
			Section(header: Text("Enemy Stats")) {
				Text("HP - \(viewModel.gameState.enemy.enemyCurrentHP)/\(viewModel.gameState.enemy.enemyMaxHP)")
				Text("MP - \(viewModel.gameState.enemy.currentMana)/\(viewModel.gameState.enemy.maxMana)")
			}
			
			Section(header: Text("Combat")) {
				// damage
				// defence
			}
			
			Section(header: Text("Navigation")) {
				Button("Go To Menu") {
					viewModel.goToMenu()
				}
				Button("Go To Battle") {
					viewModel.goToBattle()
				}
			}
		}
	}
}
