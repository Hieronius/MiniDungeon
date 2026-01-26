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
		
		// IF IT'S A NEW SESSION -> CREATE A NEW SESSION
		if gameState.isFreshSession {
			
			// Create new map
			generateMap()
			
			// Prepare hero
			spawnHero()
			
			// If fresh session -> go to menu
			goToMenu()
			
		// AND IF IT'S AN OLD SESSION -> LOAD IT
		} else {
			
			// Otherwise get the last screen user was on
			// We use this duplicate property because otherwise we get artifacts while dungeon exploration probably due to SwiftUI performance bottle neck
			print("We load game state and populate dungeonMap with properties from dungeonMapInMemory")
			gameState.dungeonMap = gameState.dungeonMapInMemory
			print(gameState.upgradedFlaskTalants)
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
		let flask = Flask()
		gameState.hero = Hero(flask: flask)
		gameState.enemy = Enemy()
		gameState.lootToDisplay = []
		gameState.specToDisplay = nil
		gameState.heroLevelBonusToDisplay = nil
		gameState.comboPoints = 0
		
		gameState.currentDungeonLevel = 0
		gameState.isHeroAppeared = false
		gameState.heroPosition = Coordinate(row: 0, col: 0)
		gameState.battlesWon = 0
		
		// Start from the beginning

		goToTown()
		generateMap()
		spawnHero()
		
		// Clean Flask Level Bonuses each new run
		gameState.selectedFlaskLevelBonuses = []
		gameState.selectedHeroLevelBonuses = []
		
		// Apply all previous upgrades on the camp
		// TODO: Check are you really need this method?
		gameState.hero.restoreStatsToDefault()
		applyActiveShrinesEffects()
		
		// Restore Flask stats to basic
		// Activate Flask Talants
		gameState.hero.flask.setFlaskStatsToDefault()
		applyActiveFlaskTalantEffects()
	}
	
}
