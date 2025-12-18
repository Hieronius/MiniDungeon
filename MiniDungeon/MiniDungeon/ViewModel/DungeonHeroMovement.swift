import SwiftUI

extension MainViewModel {
	
	// MARK: Check Hero Tile's Neighbours
	
	/// Method to return all possible neighbours of the hero's current tile
	func checkForHeroTileNeighbours(includeDiagonals: Bool) -> [Tile] {
		
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
				
				if !includeDiagonals {
					
					if difRow == -1 && difCol == 1 { continue }
					if difRow == 1 && difCol == 1 { continue }
					if difRow == -1 && difCol == -1 { continue }
					if difRow == 1 && difCol == -1 { continue }
				}
				
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
		
		let targetTile = gameState.dungeonMap[row][col]

		// If valid -> move hero position to a new coordinate

		if checkIfDirectionValid(row, col) &&
			gameState.hero.currentHP > 0 &&
			!gameState.didEncounterTrap {
			
			// Clear the state of encountering Secret Rooms for correct work
			gameState.didEncounterSecretRoom = false
			
			// Clear the state of encountering Restoration Shrine
			gameState.didEncounterRestorationShrine = false
			gameState.dealtWithRestorationShrine = false
			
			// Clear the state of encountering Disenchant Shrine
			gameState.didEncounterDisenchantShrine = false
			gameState.dealtWithDisenchantShrine = false
			
			// Clear the state of encountering Chest Tile
			gameState.didEncounterChest = false
			gameState.dealthWithChest = false

			// move hero to the new position
			
			gameState.heroPosition = (row, col)
			
			let heroPosition = gameState.heroPosition
			
			// MARK: Transition to Combat Screen

			if gameState.dungeonMap[heroPosition.row][heroPosition.col].events.contains(.enemy) &&
				!gameState.dungeonMap[heroPosition.row][heroPosition.col].isExplored {

				startBattleWithRandomNonEliteEnemy()
				
			// MARK: Encounter Trap

			} else if
				
				gameState.dungeonMap[heroPosition.row][heroPosition.col].events.contains(.trap) &&
					!gameState.dungeonMap[heroPosition.row][heroPosition.col].isExplored {
				
				gameState.didEncounterTrap = true
				
			// MARK: Encounter Shrine of Restoration
				
			} else if
				
				gameState.dungeonMap[heroPosition.row][heroPosition.col].events.contains(.restoration) {
				
				gameState.didEncounterRestorationShrine = true
			
			// MARK: Encounter Disenchant Shrine
				
			} else if
				
				gameState.dungeonMap[heroPosition.row][heroPosition.col].events.contains(.disenchant) {
				
				gameState.didEncounterDisenchantShrine = true
				
				// MARK: Encounter Chest Tile
				
			} else if gameState.dungeonMap[heroPosition.row][heroPosition.col].events.contains(.chest) {
				
				gameState.didEncounterChest = true
			}
			
			gameState.dungeonMap[gameState.heroPosition.row][gameState.heroPosition.col].isExplored = true
			
			// MARK: If Not Explored -> Check For Secret Room Or Put ".empty" event
			
			// Check is hero did not stay on possible Secret Tile
			// Check is hero still alive
			// Check is this tile still not explored
			// Check is this tile in a range of neighbours without diagonal tiles
			// Check was this tile with secret founded before
			// TODO: Test didEncounterTrap check -> you should not be able to move
			
		} else  if !checkIfDirectionValid(row, col) &&
					gameState.hero.currentHP > 0 &&
					!gameState.didEncounterTrap &&
					!gameState.dungeonMap[row][col].isExplored &&
					!gameState.dungeonMap[row][col].events.contains(.secret) &&
					checkForHeroTileNeighbours(includeDiagonals: false).contains(targetTile) {
			
			handleSecretRoomOutcome(row: row, col: col)
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
