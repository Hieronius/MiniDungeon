import Foundation

extension MainViewModel {
	
	/*
	 Section(header: Text("Training Center")) {
		 
		 Button("Upgrade Damage - 500") {
			 viewModel.gameState.hero.upgradeDamage()
			 viewModel.gameState.heroGold -= 500
			 viewModel.gameState.damageUpgradeCount += 1
		 }
		 Button("Upgrade Health - 100") {
			 viewModel.gameState.hero.upgradeHP()
			 viewModel.gameState.heroGold -= 100
			 viewModel.gameState.hpUpgradeCount += 1
		 }
		 Button("Upgrade Defence - 1000") {
			 viewModel.gameState.hero.upgradeDefence()
			 viewModel.gameState.heroGold -= 1000
			 viewModel.gameState.defenceUpgradeCount += 1
		 }
	 }
	 */
	
	func upgradeDamage() {
		
		if gameState.heroGold >= 500 {
			gameState.hero.upgradeDamage()
			gameState.heroGold -= 500
			gameState.damageUpgradeCount += 1
		}
	}
	
	func upgradeHealth() {
		
		if gameState.heroGold >= 100 {
			gameState.hero.upgradeHP()
			gameState.heroGold -= 100
			gameState.hpUpgradeCount += 1
		}
	}
	
	func upgradeDefence() {
		
		if gameState.heroGold >= 1000 {
			
			gameState.hero.upgradeDefence()
			gameState.heroGold -= 1000
			gameState.defenceUpgradeCount += 1
		}
	}
}
