import Foundation

/*
 Extension to provide functionality of navigation between different screens at the game
 */

extension MainViewModel {
	
	// MARK: - Navigation
	
	func goToMenu() {
		gameState.currentGameScreen = .menu
	}
	
	func goToBattle() {
		gameState.logMessage = "Battle Begins!"
		gameState.currentGameScreen = .battle
	}
	
	func goToDungeon() {
		gameState.currentGameScreen = .dungeon
	}
	
	func goToTown() {
		gameState.currentGameScreen = .town
	}
	
	// Hero Stats Screen in and out methods
	
	func goToHeroStats() {
		gameState.currentGameScreen = .heroStats
//		gameState.isHeroStatsScreenOpen = true
//		print(gameState.isHeroStatsScreenOpen)
	}
	
	func goBackFromHeroStatsScreen() {
		gameState.isHeroStatsScreenOpen = false
	}
	
	// Enemy Stats Screen in and out methods
	
	func goToEnemyStats() {
		gameState.currentGameScreen = .enemyStats
//		gameState.isEnemyStatsScreenOpen = true
	}
	
	func goBackFromEnemyStatsScreen() {
		gameState.isEnemyStatsScreenOpen = false
	}
	
	func goToInventory() {
		gameState.currentGameScreen = .inventory
	}
	
	func goToOptions() {
		gameState.currentGameScreen = .options
	}
	
	func goToRewards() {
		gameState.currentGameScreen = .rewards
	}
	
	func goToCombatMiniGame() {
		gameState.currentGameScreen = .combatMiniGame
	}
	
	func goToTrapDefusionMiniGame() {
		gameState.currentGameScreen = .trapDefusionMiniGame
	}
	
	func goToChestLockPickingMiniGame() {
		gameState.currentGameScreen = .chestLockPickingMiniGame
	}
	
	func goToSpecialisation() {
		gameState.currentGameScreen = .specialisation
	}
	
	func applyActiveShrineEffectsAndGoToFlaskTalants() {
		applyActiveShrinesEffects()
		gameState.currentGameScreen = .flaskTalants
	}
	
	func applyActivateFlaskTalantsAndGoToMenu() {
		applyActiveFlaskTalantEffects()
		gameState.currentGameScreen = .menu
	}
	
	func goToMerchant() {
		gameState.currentGameScreen = .merchant
	}
	
	func goToHeroLevelBonus() {
		gameState.currentGameScreen = .heroLevelBonus
	}
	
	func goToFlask() {
		gameState.currentGameScreen = .flask
	}
	
	func goToFlaskLevelBonus() {
		gameState.currentGameScreen = .flaskLevelBonus
	}
	
	func goToFlaskTalants() {
		gameState.currentGameScreen = .flaskTalants
	}
}
