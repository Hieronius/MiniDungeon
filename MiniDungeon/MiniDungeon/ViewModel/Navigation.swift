import Foundation

/*
 Extension to provide functionality of navigation between different screens at the game
 */

extension MainViewModel {
	
	// MARK: - Navigation
	
	func goToMenu() {
		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		gameState.currentGameScreen = .menu
	}
	
	func goToBattle() {
		gameState.logMessage = "Battle Begins!"
		gameState.currentGameScreen = .battle
	}
	
	func goToDungeon() {
		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		gameState.currentGameScreen = .dungeon
	}
	
	func goToTown() {
		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		gameState.currentGameScreen = .town
	}
	
	// Hero Stats Screen in and out methods
	
	func goToHeroStats() {
		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		gameState.currentGameScreen = .heroStats
	}
	
	func goBackFromHeroStatsScreen() {
		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		gameState.isHeroStatsScreenOpen = false
	}
	
	// Enemy Stats Screen in and out methods
	
	func goToEnemyStats() {
		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		gameState.currentGameScreen = .enemyStats
	}
	
	func goBackFromEnemyStatsScreen() {
		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		gameState.isEnemyStatsScreenOpen = false
	}
	
	func goToInventory() {
		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		gameState.currentGameScreen = .inventory
	}
	
	func goToOptions() {
		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		gameState.currentGameScreen = .options
	}
	
	func goToRewards() {
		gameState.currentGameScreen = .rewards
	}
	
	func goToCombatMiniGame() {
		gameState.currentGameScreen = .combatMiniGame
	}
	
	func goToTrapDefusionMiniGame() {
		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		gameState.currentGameScreen = .trapDefusionMiniGame
	}
	
	func goToChestLockPickingMiniGame() {
		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		gameState.currentGameScreen = .chestLockPickingMiniGame
	}
	
	func goToSpecialisation() {
		gameState.currentGameScreen = .specialisation
	}
	
	func applyActiveShrineEffectsAndGoToFlaskTalants() {
		
		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		applyActiveShrinesEffects()
		gameState.currentGameScreen = .flaskTalants
	}
	
	func applyActivateFlaskTalantsAndGoToMenu() {
		
		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		applyActiveFlaskTalantEffects()
		
		// Probalby should be put on separate method
		if gameState.didEndDemoLevel {
			gameState.hero.flask.baseMaxCharges += 1
			gameState.hero.flask.currentCharges += 1
			print("add a flask charge after Demo completion")
		}
		gameState.currentGameScreen = .menu
	}
	
	func goToMerchant() {
		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		gameState.currentGameScreen = .merchant
	}
	
	func goToHeroLevelBonus() {
//		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		gameState.currentGameScreen = .heroLevelBonus
	}
	
	func goToFlask() {
//		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		gameState.currentGameScreen = .flask
	}
	
	func goToFlaskLevelBonus() {
		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		gameState.currentGameScreen = .flaskLevelBonus
	}
	
	func goToFlaskTalants() {
		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		gameState.currentGameScreen = .flaskTalants
	}
	
	func goToShadowBallMiniGame() {
		gameState.currentGameScreen = .shadowBallMiniGame
	}
	
	func goToTestTimelineView() {
		gameState.currentGameScreen = .testTimelineView
	}
	
	func goToJoystickView() {
		gameState.currentGameScreen = .joystickView
	}
	
	func goToEvasionMiniGame() {
		gameState.currentGameScreen = .evasionMiniGame
	}
	
	func goToStatsRecovery() {
		self.audioManager.playSound(fileName: "click", extensionName: "mp3")
		gameState.currentGameScreen = .statsRecovery
	}
	
	func goToCoinFlipMiniGame() {
		gameState.currentGameScreen = .coinFlipMiniGame
	}
	
	func goToLevelPerk() {
		self.audioManager.playSound(fileName: "levelPerkSound", extensionName: "mp3")
		gameState.currentGameScreen = .levelPerk
	}
	
	func goToTestCollisionView() {
		gameState.currentGameScreen = .testCollisionView
	}
}
