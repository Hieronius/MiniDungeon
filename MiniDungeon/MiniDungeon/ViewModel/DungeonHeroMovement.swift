import SwiftUI

extension MainViewModel {
	
	// MARK: Handle Tapped Direction

	/// Method to define Hero movement logic based on tapped direction if it's valid to move
	func handleTappedDirection(_ row: Int, _ col: Int) {

		// If valid -> move hero position to a new coordinate

		if checkIfDirectionValid(row, col) {

			// move hero to the new position
			

			gameState.heroPosition = (row, col)
			
			let heroPosition = gameState.heroPosition

			if gameState.dungeonMap[heroPosition.row][heroPosition.col].events.contains(.enemy) &&
				!gameState.dungeonMap[heroPosition.row][heroPosition.col].isExplored {
				
				// MARK: Transition to Combat Screen

				gameState.enemy = generateEnemy(didFinalBossSummoned: false)
				restoreAllEnergy()
				goToBattle()

			}
			gameState.dungeonMap[gameState.heroPosition.row][gameState.heroPosition.col].isExplored = true
			print("New Hero Position is \(row), \(col)")

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
