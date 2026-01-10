import Foundation

/*
 Extension to provide functionality of navigation between different screens at the game
 */

extension MainViewModel {
	
	// MARK: - Navigation
	
	func goToMenu() {
		gameState.gameScreen = .menu
	}
	
	func goToBattle() {
		gameState.logMessage = "Battle Begins!"
		gameState.gameScreen = .battle
	}
	
	func goToDungeon() {
		gameState.gameScreen = .dungeon
	}
	
	func goToTown() {
		gameState.gameScreen = .town
	}
	
	func goToHeroStats() {
		gameState.gameScreen = .heroStats
	}
	
	func goToEnemyStats() {
		gameState.gameScreen = .enemyStats
	}
	
	func goToInventory() {
		gameState.gameScreen = .inventory
	}
	
	func goToOptions() {
		gameState.gameScreen = .options
	}
	
	func goToRewards() {
		gameState.gameScreen = .rewards
	}
	
	func goToCombatMiniGame() {
		gameState.gameScreen = .combatMiniGame
	}
	
	func goToTrapDefusionMiniGame() {
		gameState.gameScreen = .trapDefusionMiniGame
	}
	
	func goToChestLockPickingMiniGame() {
		gameState.gameScreen = .chestLockPickingMiniGame
	}
	
	func goToSpecialisation() {
		gameState.gameScreen = .specialisation
	}
	
	func applyActiveShrineEffectsAndGoToSpecialisation() {
		gameState.gameScreen = .menu
		applyActiveShrinesEffects()
	}
	
	func goToMerchant() {
		gameState.gameScreen = .merchant
	}
	
	func goToHeroLevelBonus() {
		gameState.gameScreen = .heroLevelBonus
	}
	
	func goToFlask() {
		gameState.gameScreen = .flask
	}
	
	func goToFlaskLevelBonus() {
		gameState.gameScreen = .flaskLevelBonus
	}
	
	func goToFlaskTalants() {
		gameState.gameScreen = .flaskTalants
	}
}
