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
		
		generateMap()
		spawnHero()
	}
	
	// MARK: Check Hero Tile's Neighbours
	
	/// Method to return all possible neighbours of the hero's current tile
	func checkForHeroTileNeighbours() -> [Tile] {
		
		/*
		 [-1, -1] [-1, 0] [-1, 1]
		 [0, -1]  [0, 0]  [0, 1]
		 [1, -1]  [1, 0]  [1, 1]
		 */
		
		let heroTile = gameState.heroPosition
		var neighbours: [Tile] = []
		
		// difRow and difCol mean different coordinates from hero position
		
		for difRow in -1...1 {
			
			for difCol in -1...1 {
				
				// Ignore the middle (hero's) tile
				
				if difRow == 0 && difCol == 0 { continue }
				
				let neighbourRow = heroTile.row + difRow
				let neighbourCol = heroTile.col + difCol
				
				if let neighbourTile = safeTile(atRow: neighbourRow, col: neighbourCol) {
					neighbours.append(neighbourTile)
				}
			}
		}
		
		return neighbours
		
	}
	
	// MARK: Safely Tile Coordinate Retrival
	
	/// Check if possible neighbour Tile is existing in the dungeon map
	func safeTile(atRow row: Int, col: Int) -> Tile? {
		
		guard row >= 0, row < gameState.dungeonMap.count,
			  col >= 0, col < gameState.dungeonMap[row].count else {
			return nil
		}
		return gameState.dungeonMap[row][col]
	}
	
	// MARK: SetupNewGame
	
	func setupNewGame() {
		
		gameState.isHeroTurn = true
		goToMenu()
		
		// Reset all hero progress to 0
		gameState.hero = Hero(
			weaponSlot: WeaponManager.weapons[0],
			armorSlot: ArmorManager.armors[0]
		)
		gameState.enemy = Enemy()
		gameState.heroCurrentXP = 0
		gameState.heroMaxXP = 100
		gameState.currentDungeonLevel = 0
		gameState.isHeroAppeard = false
		gameState.heroPosition = (0,0)
		gameState.battlesWon = 0
		
		// Start from the beginning
		generateMap()
		spawnHero()
		
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
	
	// MARK: - Navigation
	
	func goToMenu() {
		gameScreen = .menu
	}
	
	func goToBattle() {
		gameScreen = .battle
	}
	
	func goToDungeon() {
		gameScreen = .dungeon
	}
	
	func goToTown() {
		gameScreen = .town
	}
	
	func goToHeroStats() {
		gameScreen = .stats
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
	
}
