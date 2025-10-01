import SwiftUI

class MainViewModel: ObservableObject {
	
	// MARK: - Dependencies
	
	var dungeonGenerator: DungeonGenerator
	var dungeonScheme: DungeonScheme
	
	// MARK: - Properties
	
	@Published var gameState: GameState
	@Published var gameScreen: GameScreen
	
	// MARK: - Initialization
	
	init(dungeonGenerator: DungeonGenerator,
		 dungeonScheme: DungeonScheme,
		 gameState: GameState,
		 gameScreen: GameScreen) {
		
		self.dungeonGenerator = dungeonGenerator
		self.dungeonScheme = dungeonScheme
		self.gameState = gameState
		self.gameScreen = gameScreen
		
		// Generate three random specs
		self.gameState.specsToChooseAtStart = SpecialisationManager.getThreeRandomSpecialisations()
		
		// Choose and apply on of three random specs
		goToSpecialisation()
		
		// Create new map
		generateMap()
		
		// Prepare hero
		spawnHero()
	}
	
	// MARK: SetupNewGame
	
	func setupNewGame() {
		
		gameState.isHeroTurn = true
		gameState.didApplySpec = false
		
		// Reset all hero progress to 0
		gameState.hero = Hero()
		gameState.enemy = Enemy()
		gameState.hero.currentXP = 0
		gameState.hero.maxXP = 100
		gameState.currentDungeonLevel = 0
		gameState.isHeroAppeard = false
		gameState.heroPosition = (0,0)
		gameState.battlesWon = 0
		
		// Start from the beginning
		gameState.specsToChooseAtStart = SpecialisationManager.getThreeRandomSpecialisations()
		goToSpecialisation()
		generateMap()
		spawnHero()
		
		// Apply all previous upgrades on the camp
		
		for _ in 0..<gameState.hpUpgradeCount {
			gameState.hero.upgradeHP()
		}
		
		for _ in 0..<gameState.damageUpgradeCount {
			gameState.hero.upgradeDamage()
		}
		
		for _ in 0..<gameState.defenceUpgradeCount {
			gameState.hero.upgradeDefence()
		}
		
		for _ in 0..<gameState.spellPowerUpgradeCount {
			gameState.hero.upgradeSpellPower()
		}
		
	}
	
	// MARK: - getRewardsAndCleanTheScreen
	
	func getRewardsAndCleanTheScreen() {
		
		gameState.didFindLootAfterFight = false
		gameState.lootToDisplay = []
		goToDungeon()
	}
	
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
	
}
