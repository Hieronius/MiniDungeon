import SwiftUI

/// An entity to connect Model with View
class MainViewModel: ObservableObject {
	
	// MARK: - Dependencies
	
	var swiftDataManager: SwiftDataManager
	var dungeonGenerator: DungeonGenerator
	
	// MARK: - Properties
	
	@Published var gameState: GameState
	
	// MARK: - Initialization
	
	init(swiftDataManager: SwiftDataManager,
		 dungeonGenerator: DungeonGenerator,
		 gameState: GameState,
		 gameScreen: GameScreen) {
		
		self.swiftDataManager = swiftDataManager
		self.dungeonGenerator = dungeonGenerator
		self.gameState = gameState
		
		// if there an old GameState -> Load it and go to menu
		if gameState.isFreshSession {
			
			// Create new map
			generateMap()
			
			// Prepare hero
			spawnHero()
			
			// If fresh session -> go to menu
			goToMenu()
		
		} else {
			
			// Otherwise get the last screen user was on
			
			print("We load game state and populate dungeonMap with properties from dungeonMapInMemory")
			gameState.dungeonMap = gameState.dungeonMapInMemory
		}
		
	}
}


extension MainViewModel {
	
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
		gameState.lootToDisplay = []
		gameState.specToDisplay = nil
		gameState.levelBonusToDisplay = nil
		gameState.comboPoints = 0
		
		gameState.currentDungeonLevel = 0
		gameState.isHeroAppeared = false
		gameState.heroPosition = Coordinate(row: 0, col: 0)
		gameState.battlesWon = 0
		
		// Start from the beginning

		goToTown()
		generateMap()
		spawnHero()
		
		// Apply all previous upgrades on the camp
		gameState.hero.restoreStatsToDefault()
		applyActiveShrinesEffects()
	}
	
}
