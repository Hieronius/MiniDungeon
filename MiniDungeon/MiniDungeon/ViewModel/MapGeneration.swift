import SwiftUI

// MARK: - Dungeon Generation/Movement

extension MainViewModel {
	
	// MARK: GenerateMap

	/// Generate map scheme -> generate new map based on current level
	func generateMap() {
		
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
		gameState.didEncounteredBoss = true
		gameState.enemy = generateEnemy(didFinalBossSummoned: gameState.didEncounteredBoss)
		restoreAllEnergy()
		goToBattle()
	}
	
	// MARK: If Level complete and boss has been defeated go to the next one
	
	func endLevelAndGenerateNewOne() {
		
		generateMerchantLoot()
		
		goToMerchant()
		
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
	
	// MARK: generateRandomDungeonLevel
	
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
		
		// check map for being valid and return fixed version if it's not
		return checkDungeonLevelForValidRouts(map)
		
		
	}
	
	// MARK: checkDungeonLevelForValidRouts
	
	func checkDungeonLevelForValidRouts(_ map: [[String]]) -> [[String]] {
		
		// traverse the map and find bottlenecks to fix
		
		var map = map
		
		for row in 0..<map.count {
			
			for col in 0..<map[row].count {
				
				let tile = map[row][col]
				
				if tile != "E" {
					
					// check top, left, right, bottom direction for being valid
					
					let neighbours = checkTopBotLeftRightDirectionsFromTile(row: row, col: col, in: map)
					
					if neighbours.isEmpty {
						print("Found inValid direction -> Fixed it")
						
						if let top = safeSchemeValue(atRow: row - 1, col: col, in: map), top == "E" {
							map[row - 1][col] = "C"
							
						} else if let left = safeSchemeValue(atRow: row, col: col - 1, in: map), left == "E" {
							map[row][col - 1] = "C"
							
						} else if let right = safeSchemeValue(atRow: row, col: col + 1, in: map), right == "E" {
							map[row][col + 1] = "C"
							
						} else if let bottom = safeSchemeValue(atRow: row + 1, col: col, in: map), bottom == "E" {
							map[row + 1][col] = "C"
						}
						
					}
				}
			}
		}
		
		// MARK: DFS Check here to connect all local islands
		
		while true {
			
			// grab all non empty tiles
			let allTiles = (0..<map.count).flatMap { row in
				(0..<map[row].count).compactMap { col in map [row][col] != "E" ? (row, col) : nil }
			}
			
			guard let start = allTiles.first else { break } // im empty map
			
			// run DFS from the first tile
			var visited = Set<[Int]>()
			
			/// Method to check is a next tile is reachable. If no -> return from the method. Otherwise -> add tile to "visited" and run DFS for the next possible one
			func dfs(_ row: Int, _ col: Int) {
				
				if visited.contains([row, col]) { return }
				visited.insert([row, col])
				
				for (nextRow, nextCol) in [(row - 1, col), (row + 1, col), (row, col - 1), (row, col + 1)] {
					
					if let tile = safeSchemeValue(atRow: nextRow, col: nextCol, in: map), tile != "E" {
						
						dfs(nextRow, nextCol)
					}
				}
			}
			
			dfs(start.0, start.1)
			
			// if all reachable, done
			if visited.count == allTiles.count { break }
			
			// otherwise, pick one unreachable tile and connect it
			
			if let (row, col) = allTiles.first(where: { !visited.contains([$0.0, $0.1]) }) {
				
				if let tile = safeSchemeValue(atRow: row - 1, col: col, in: map), tile == "E" {
					
					map[row - 1][col] = "C"
					
				} else if let tile = safeSchemeValue(atRow: row + 1, col: col, in: map), tile == "E" {
					
					map[row + 1][col] = "C"
					
				} else if let tile = safeSchemeValue(atRow: row, col: col - 1, in: map), tile == "E" {
					
					map[row][col - 1] = "C"
					
				} else if let tile = safeSchemeValue(atRow: row, col: col + 1, in: map), tile == "E" {
					
					map[row][col + 1] = "C"
				}
			}
		}
		return map
	}
	
	// MARK: checkTopBotLeftRightDirectionsFromTile
	
	func checkTopBotLeftRightDirectionsFromTile(row: Int, col: Int, in map: [[String]]) -> [String] {
		
		var validNeighbours: [String] = []
		
		// top
		
		if let topTile = safeSchemeValue(atRow: row - 1, col: col, in: map), topTile != "E" {
			validNeighbours.append(topTile)
		}
		
		// left
		
		if let leftTile = safeSchemeValue(atRow: row, col: col - 1, in: map), leftTile != "E" {
				validNeighbours.append(leftTile)
		}
		
		// right
		
		if let rightTile = safeSchemeValue(atRow: row, col: col + 1, in: map), rightTile != "E" {
				validNeighbours.append(rightTile)
		}
		
		// bottom
		
		if let bottomTile = safeSchemeValue(atRow: row + 1, col: col, in: map), bottomTile != "E" {
				validNeighbours.append(bottomTile)
		}
		
		return validNeighbours
	}
	
	// MARK: safeSchemeValue
	
	/// Get String value of DungeonMap Scheme before map generation
	func safeSchemeValue(atRow row: Int, col: Int, in map: [[String]]) -> String? {
		
		guard row >= 0, row < map.count &&
				col >= 0, col < map[row].count else { return nil }
		return map[row][col]
	}
	
	// MARK: generateRandomElement
	
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

