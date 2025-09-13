import SwiftUI

// MARK: - Dungeon Generation/Movement

extension MainViewModel {
	
	// MARK: GenerateMap

	/// Extract current DungeonSnapshot -> generate new map based on current level -> save and apply new snapshot
	func generateMap() {

//		let levelScheme = dungeonScheme.dungeonLevels[gameState.currentDungeonLevel]
//		gameState.dungeonMap = self.dungeonGenerator.parseDungeonLevel(levelScheme)
		
		let scheme = self.generateRandomDungeonLevel()
		let level = self.dungeonGenerator.parseDungeonLevel(scheme)
		gameState.dungeonMap = level
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
		restoreAllEnergy()
		goToBattle()
	}
	
	// MARK: If Level complete and boss has been defeated go to the next one
	
	func endLevelAndGenerateNewOne() {
		
		gameState.didEncounteredBoss = false
		gameState.currentDungeonLevel += 1
		gameState.isHeroAppeard = false
		generateMap()
		spawnHero()
		print("New level has been created - \(gameState.currentDungeonLevel + 1)")
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
	
	/// Use random generation to create random levels
	/// Basic size of 7x7 and can be twicked accordinly to the depth of the dungeon
	/// like first few of them should have 3x3, 4x4 and so on and so on
	func generateRandomDungeonLevel() -> [[String]] {
		
		// "E" - Empty Room - 30%
		// "R" - Room with enemy - 20%
		// "C" - Corridor - 50%
		
		/* Example of dungeon scheme 7x7 (average working size)
		 let dungeonLevel11: [[String]] = [
		 
			 ["E", "R", "R", "C", "E", "R", "C"],
			 ["R", "C", "E", "C", "C", "R", "C"],
			 ["E", "E", "E", "E", "E", "C", "R"],
			 ["C", "R", "C", "C", "E", "C", "C"],
			 ["C", "E", "E", "C", "C", "R", "C"],
			 ["R", "C", "C", "E", "E", "E", "R"],
			 ["E", "E", "R", "E", "E", "E", "E"]
		 ]
		 */
		
		let rows = 7
		let cols = 7
		
		var map: [[String]] = Array(repeating: Array(repeating: "", count: cols), count: rows)
			
			for row in 0..<rows {
				for col in 0..<cols {
					map[row][col] = generateRandomElement()
				}
			}
		return map
	}
	
	func generateRandomElement() -> String {
		
		let chance = Int.random(in: 1...100)
		
		switch chance {
			
		case 1...30: return "E"
		case 31...50: return "R"
		case 51...100: return "C"
		default: return ""
		}
	}
}

