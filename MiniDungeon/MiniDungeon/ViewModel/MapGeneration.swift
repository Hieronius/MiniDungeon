import SwiftUI

// MARK: - Dungeon Generation/Movement

extension MainViewModel {
	
	// MARK: GenerateMap

	/// Extract current DungeonSnapshot -> generate new map based on current level -> save and apply new snapshot
	func generateMap() {

		let levelScheme = dungeonScheme.dungeonLevels[gameState.currentDungeonLevel]
		gameState.dungeonMap = self.dungeonGenerator.parseDungeonLevel(levelScheme)
	}
	
	// MARK: - Check if dungeon has been explored and summon the boss
	
	func checkForMapBeingExplored() {
		
		for row in 0..<gameState.dungeonMap.count {
			for col in 0..<row {
				let tile = gameState.dungeonMap[row][col]
				if !tile.isExplored && tile.type != .empty {
					print("Found unexplored tile")
					return
				}
			}
		}
		print("Level Completed. Final boss appeared")
		gameState.enemy = generateEnemy(didFinalBossSummoned: true)
		gameState.didEncounteredBoss = true
		restoreEnergy()
		goToBattle()
	}
	
	// MARK: If Level complete and boss has been defeated go to the next one
	
	func endLevelAndGenerateNewOne() {
		
		gameState.didEncounteredBoss = false
		gameState.currentDungeonLevel += 1
		gameState.isHeroAppeard = false
		generateMap()
		spawnHero()
	}

	// MARK: SpawnHero

	/// Method should traverse dungeon map in reversed order and put hero at the first non empty tile
	func spawnHero() {

		// map size

		let map = gameState.dungeonMap

		let n = map.count
		let m = map[0].count

		// map traversing

		for row in (0..<n).reversed() {
			for col in (0..<m).reversed() {
				let tile = map[row][col]
				if tile.type == .room && !gameState.isHeroAppeard {
					gameState.heroPosition = (row, col)
					gameState.isHeroAppeard = true
				}
			}
		}
		gameState.dungeonMap[gameState.heroPosition.row][gameState.heroPosition.col].isExplored = true
	}
}

