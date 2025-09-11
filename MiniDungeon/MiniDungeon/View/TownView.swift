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
				
				Button("Upgrade Damage - 50G") {
					viewModel.gameState.hero.upgradeDamage()
					viewModel.gameState.heroGold -= 50
				}
				Button("Upgrade Health - 50G") {
					viewModel.gameState.hero.upgradeHP()
					viewModel.gameState.heroGold -= 50
				}
				Button("Upgrade Defence - 50G") {
					viewModel.gameState.hero.upgradeDefence()
					// gold probably should be in Hero struct
					viewModel.gameState.heroGold -= 50
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
