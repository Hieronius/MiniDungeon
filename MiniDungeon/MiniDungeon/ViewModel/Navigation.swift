import Foundation

extension MainViewModel {
	
	// MARK: - Navigation
	
	func goToMenu() {
		gameScreen = .menu
	}
	
	func goToBattle() {
		gameState.logMessage = "Battle Begins!"
		gameScreen = .battle
	}
	
	func goToDungeon() {
		gameScreen = .dungeon
	}
	
	func goToTown() {
		gameScreen = .town
	}
	
	func goToHeroStats() {
		gameScreen = .heroStats
	}
	
	func goToEnemyStats() {
		gameScreen = .enemyStats
	}
	
	func goToInventory() {
		gameScreen = .inventory
	}
	
	func goToOptions() {
		gameScreen = .options
	}
	
	func goToRewards() {
		gameScreen = .rewards
	}
	
	func goToMiniGame() {
		gameScreen = .miniGame
	}
	
	func goToSpecialisation() {
		gameScreen = .specialisation
	}
	
	func goToMerchant() {
		gameScreen = .merchant
	}
	
	func goToLevelBonus() {
		gameScreen = .levelBonus
	}
}
