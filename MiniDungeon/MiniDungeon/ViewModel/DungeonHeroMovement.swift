import SwiftUI

extension MainViewModel {
	
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
	
	// MARK: handleTappedDirection

	/// Method to define Hero movement logic based on tapped direction if it's valid to move
	func handleTappedDirection(_ row: Int, _ col: Int) {

		// If valid -> move hero position to a new coordinate

		if checkIfDirectionValid(row, col) && gameState.heroDarkEnergy > 0 {

			// move hero to the new position
			
			gameState.heroPosition = (row, col)
			
			let heroPosition = gameState.heroPosition

			if gameState.dungeonMap[heroPosition.row][heroPosition.col].events.contains(.enemy) &&
				!gameState.dungeonMap[heroPosition.row][heroPosition.col].isExplored {
				
				// MARK: Transition to Combat Screen

				startBattleWithRandomNonEliteEnemy()

			}
			// Take one Dark Energy Point for each unexplored tile
			// And do not if Mystery Shrine been activated
			if gameState.dungeonMap[gameState.heroPosition.row][gameState.heroPosition.col].isExplored == false &&
				!gameState.mysteryShrineBeenActivated {
				gameState.heroDarkEnergy -= 1
				
			}
			gameState.dungeonMap[gameState.heroPosition.row][gameState.heroPosition.col].isExplored = true
			
		} else {
			print("failed attempt to move")
		}
	}

	// MARK: Check If Direction Valid

	/// Method to check is destination tile is neighbour vertically or horizontally
	func checkIfDirectionValid(_ row: Int, _ col: Int) -> Bool {

		// If empty tile -> return false

		let tileType = gameState.dungeonMap[row][col].type
		let heroPosition = gameState.heroPosition

		guard tileType != .empty else { return false }

		// Movement valid only if only X or Y axis coordinate change by 1

		let isTopDirectionValid = (row - heroPosition.row == 1 && col == heroPosition.col)
		let isBotDirectionValid = (heroPosition.row - row == 1 && col == heroPosition.col)
		let isLeftDirectionValid = (col - heroPosition.col == 1 &&  row == heroPosition.row)
		let isRightDirectionValid = (heroPosition.col - col == 1 && row == heroPosition.row)

		// Check each of all four possible directions

		if (isTopDirectionValid || isBotDirectionValid) ||
			(isLeftDirectionValid || isRightDirectionValid) {

			return true

		} else {
			return false
		}
	}
}
