import SwiftUI

/// An entity to connect Model with View
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
		
		// Start with predefined "WARRIOR SPECIALISATION"
		self.applySpecialisation(SpecialisationManager.specialisations[0])
		
		// Activate shrines and upgrades from previous runs if there are any
		applyActiveShrineEffects()
		
		// Create new map
		generateMap()
		
		// Prepare hero
		spawnHero()
	}
	
	// MARK: SetupNewGame
	
	func setupNewGame() {
		
		gameState.didEncounteredBoss = false
		gameState.isHeroTurn = true
		gameState.didApplySpec = false
		
		// Reset all hero progress to 0
		gameState.hero = Hero()
		gameState.enemy = Enemy()
		gameState.hero.currentXP = 0
		gameState.hero.maxXP = 100
		gameState.heroGold = 0
		gameState.itemToDisplay = nil
		gameState.lootToDisplay = []
		gameState.specToDisplay = nil
		gameState.levelBonusToDisplay = nil
		gameState.comboPoints = 0
		
		// If there is less than 10 dark energy refill it, otherwise do nothing
		if gameState.heroDarkEnergy < 10 {
			let difference = 10 - gameState.heroDarkEnergy
			gameState.heroDarkEnergy += difference
		}
		gameState.currentDungeonLevel = 0
		gameState.isHeroAppeard = false
		gameState.heroPosition = (0,0)
		gameState.battlesWon = 0
		
		// TODO: There we should go to TownView -> SpecView -> Dungeon
		
		// Start from the beginning
//		gameState.specsToChooseAtStart = SpecialisationManager.getThreeRandomSpecialisations()
		goToTown()
		generateMap()
		spawnHero()
		
		// Apply all previous upgrades on the camp
		
	}
	
	// MARK: - getRewardsAndCleanTheScreen
	
	func getRewardsAndCleanTheScreen() {
		
		gameState.didFindLootAfterFight = false
		gameState.lootToDisplay = []
		
		if gameState.didEncounteredBoss {
			endLevelAndGenerateNewOne()
		} else {
			goToDungeon()
			checkForLevelUP()
		}
	}
	
}
