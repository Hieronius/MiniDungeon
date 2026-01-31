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
	
	// MARK: countMapEvents
	
	/// Method to check how many events 
	func countMapRooms() -> (Int, Int) {
		
		var eventsToExplore = 0
		var exploredEvents = 0
		
		for row in 0..<gameState.dungeonMap.count {
			
			for col in 0..<gameState.dungeonMap[row].count {
				
				let tile = gameState.dungeonMap[row][col]
				
				// MODIFICATION STARTS HERE
				if tile.type == .room && tile.isExplored { exploredEvents += 1 }
				if tile.type == .room { eventsToExplore += 1 }
				// MODIFICATION ENDS HERE
				
			}
		}
		return (exploredEvents, eventsToExplore)
	}
	
	// MARK: generateRandomDungeonLevel
	
	/// Use random generation to create random levels
	/// Basic size of 7x7 and can be twicked accordinly to the depth of the dungeon
	func generateRandomDungeonLevel() -> [[String]] {
		
		// "E" - Empty Room - 30%
		// "R" - Room with enemy - 20%
		// "C" - Corridor - 40%
		// "T" - Trap - 10%
		// "D" - Disenchant - ?%
		// "H" - Shrine of Restoration - ?%
		// "S" - Secret Rooms - ?%
		// "L" - Chest Tile - ?%
		
		/* Example of dungeon scheme 7x7 (average working size)
		 let dungeonLevel11: [[String]] = [
		 
			 ["E", "R", "R", "C", "E", "R", "C"],
			 ["R", "C", "E", "T", "C", "R", "C"],
			 ["E", "E", "E", "H", "E", "C", "R"],
			 ["C", "R", "C", "C", "E", "C", "C"],
			 ["C", "E", "E", "C", "T", "R", "C"],
			 ["R", "T", "C", "E", "E", "H", "R"],
			 ["E", "E", "R", "E", "E", "E", "E"]
		 ]
		 */
		
		let rows = 7
		let cols = 7
		
		var map: [[String]] = Array(repeating: Array(repeating: "", count: cols), count: rows)
			
			for row in 0..<rows {
				for col in 0..<cols {
					map[row][col] = generateRandomTileType()
				}
			}
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
					
					// If we found neighbours being empty it's mean there is no valid routs to take so we should create one
					// Start from top to bottom
					
					if neighbours.isEmpty {
						
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
			
			var allTiles = [(Int, Int)]()
			
			for row in 0..<map.count {
				
				for col in 0..<map[row].count {
					
					if map[row][col] != "E" {
						allTiles.append((row, col))
					}
				}
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
				
				// Generate a tile to replace unvalid one with it
				
				var validTile = generateRandomTileType()
				
				while validTile == "E" {
					validTile = generateRandomTileType()
				}
				
				if let tile = safeSchemeValue(atRow: row - 1, col: col, in: map), tile == "E" {
					
					// Edit 28.11.25 to test
					map[row - 1][col] = validTile
					
				} else if let tile = safeSchemeValue(atRow: row + 1, col: col, in: map), tile == "E" {
					
					// Edit 28.11.25 to test
					map[row + 1][col] = validTile
					
				} else if let tile = safeSchemeValue(atRow: row, col: col - 1, in: map), tile == "E" {
					
					// Edit 28.11.25 to test
					map[row][col - 1] = validTile
					
				} else if let tile = safeSchemeValue(atRow: row, col: col + 1, in: map), tile == "E" {
					
					// Edit 28.11.25 to test
					map[row][col + 1] = validTile
					
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
	
	/// Method to generate random tile types for DungeonMapScheme
	/// Just add element such as Shrine, Shop, Trap here and in generateTile
	func generateRandomTileType() -> String {
		
		let chance = Int.random(in: 1...100)
		
		switch chance {
		
		// "Empty" tile
		case 1...30: return "E"
		// "Room" tile with monster and may be chest
		case 31...50: return "R"
		// "Corridor" tile is just an empty tile to move through
		case 51...86: return "C"
		// "Loot" for loot chest tile
		case 87...90: return "L"
		// "Heal" or Restoration Shrine
		case 91...94: return "H"
		// "Trap" tile
		case 95...97: return "T"
		// "Disenchant" tile to convert items to dark energy
		case 98...100: return "D"
		
		default: return ""
		}
	}
}

