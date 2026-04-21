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
//	func handleTappedDirection(_ row: Int, _ col: Int) {
	
	func handleUserMovement(for direction: Direction) {
		
		var currentHeroPosition = gameState.heroPosition
		print("user position before movement - \(currentHeroPosition)")
		
		switch direction {
			
		case .top: currentHeroPosition.row -= 1
			
		case .left: currentHeroPosition.col -= 1
			
		case .right: currentHeroPosition.col += 1
			
		case .bottom: currentHeroPosition.row += 1
		}
		
		
		guard currentHeroPosition.row >= 0 &&
				currentHeroPosition.col >= 0 &&
				currentHeroPosition.row <= 6 &&
				currentHeroPosition.col <= 6 else {
			
			print("Tried to move out of the board!")
			return
		}
		let targetTile = currentHeroPosition
		
		print("user target position after tapping joystick - \(targetTile)")

		// If valid -> move hero position to a new coordinate

		if checkIfDirectionValid(targetTile.row, targetTile.col) &&
			gameState.hero.currentHP > 0 &&
			!gameState.didEncounterTrap {
			
			audioManager.playSound(fileName: "heroStep", extensionName: "mp3")
			
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
			
			gameState.heroPosition = targetTile
			
			let heroPosition = gameState.heroPosition
			
			// MARK: Transition to Combat Screen
			
			
			if gameState.dungeonMap[heroPosition.row][heroPosition.col].events.contains(.enemy) &&
				!gameState.dungeonMap[heroPosition.row][heroPosition.col].isExplored {
				
				startBattleWithRandomNonEliteEnemy()
				
				// MARK: Encounter Trap
				
			} else if
				
				gameState.dungeonMap[heroPosition.row][heroPosition.col].events.contains(.trap) &&
					!gameState.dungeonMap[heroPosition.row][heroPosition.col].isExplored {
				
				gameState.isNavigationOpen = true
				gameState.didEncounterTrap = true
				
				// MARK: Encounter Shrine of Restoration
				
			} else if
				
				gameState.dungeonMap[heroPosition.row][heroPosition.col].events.contains(.restoration) {
				
				gameState.isNavigationOpen = true
				gameState.didEncounterRestorationShrine = true
				
				// MARK: Encounter Disenchant Shrine
				
			} else if
				
				gameState.dungeonMap[heroPosition.row][heroPosition.col].events.contains(.disenchant) {
				
				gameState.isNavigationOpen = true
				gameState.didEncounterDisenchantShrine = true
				
				// MARK: Encounter Chest Tile
				
			} else if gameState.dungeonMap[heroPosition.row][heroPosition.col].events.contains(.chest) {
				
				gameState.isNavigationOpen = true
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
			
			// custom and clanky condition to detect predefined SecretRoom during Demo(tutorial level) at the specific place at the map
			
		} else if !checkIfDirectionValid(targetTile.row, targetTile.col) &&
					gameState.dungeonMap[targetTile.row][targetTile.col].type == .empty &&
					gameState.dungeonMap[targetTile.row][targetTile.col].events == [.secret] {
			
			gameState.isNavigationOpen = true
			
			// If met during tutorial level -> set flag to false so in other cases secretRoom will be handled in traditional way
			handleSecretRoomOutcome(
				row: targetTile.row,
				col: targetTile.col,
				predefinedSecret: gameState.shouldMeetPredefinedSecretRoom
			)
			
		} else if !checkIfDirectionValid(targetTile.row, targetTile.col) &&
					gameState.hero.currentHP > 0 &&
					!gameState.didEncounterTrap &&
					!gameState.dungeonMap[targetTile.row][targetTile.col].isExplored &&
					!gameState.dungeonMap[targetTile.row][targetTile.col].events.contains(.secret) &&
					checkForHeroTileNeighbours(includeDiagonals: false).contains(gameState.dungeonMap[targetTile.row][targetTile.col]) {
			
			audioManager.playSound(fileName: "heroFailedStep", extensionName: "mp3")
			
			handleSecretRoomOutcome(
				row: targetTile.row,
				col: targetTile.col,
				predefinedSecret: false
			)
			
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
