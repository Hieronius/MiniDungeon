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
				
				Button("Upgrade Damage - 100") {
					viewModel.gameState.hero.upgradeDamage()
					viewModel.gameState.heroGold -= 100
					viewModel.gameState.damageUpgradeCount += 1
				}
				Button("Upgrade Health - 25") {
					viewModel.gameState.hero.upgradeHP()
					viewModel.gameState.heroGold -= 25
					viewModel.gameState.hpUpgradeCount += 1
				}
				Button("Upgrade Defence - 200") {
					viewModel.gameState.hero.upgradeDefence()
					viewModel.gameState.heroGold -= 200
					viewModel.gameState.defenceUpgradeCount += 1
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
