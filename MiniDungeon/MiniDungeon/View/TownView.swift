import SwiftUI

// MARK: - Town Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildTown() -> some View {
		
		List {
			
			Section(header: Text("Town")) {
				Text("Available Skill Points - \(viewModel.gameState.hero.skillPoints)")
				Text("Hero's Gold - \(viewModel.gameState.heroGold)")
			}
			
			Section(header: Text("Training Center")) {
				
				Button("Upgrade Damage - 500") {
					viewModel.upgradeDamage()
				}
				Button("Upgrade Health - 100") {
					viewModel.upgradeHealth()
				}
				Button("Upgrade Defence - 1000") {
					viewModel.upgradeDefence()
				}
			}
			
			Section(header: Text("Market")) {
				
				Button("Buy Health Potion") {
					//
				}
				Button("Buy Steal Sword") {
					//
				}
			}
			
			Section(header: Text("Navigation")) {
				
				Button("Go To Battle") {
					viewModel.goToBattle()
				}
				Button("Go To Dungeon") {
					viewModel.goToDungeon()
				}
				Button("Go To Menu") {
					viewModel.goToMenu()
				}
			}
		}
	}
}
