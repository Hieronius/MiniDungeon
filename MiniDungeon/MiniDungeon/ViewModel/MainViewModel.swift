import SwiftUI

class MainViewModel: ObservableObject {
	
	// MARK: - Dependencies
	
	var dungeonGenerator: DungeonGenerator
	var dungeonScheme: DungeonScheme
	
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
	
	// MARK: - Navigation
	
	func goToMenu() {
		gameScreen = .menu
	}
	
	func goToBattle() {
		gameScreen = .battle
		restoreStats()
	}
	
	func goToDungeon() {
		gameScreen = .dungeon
	}
	
	func goToTown() {
		gameScreen = .town
	}
	
	// MARK: - Combat
	
	func attack() {
		
		if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			gameState.enemy.enemyCurrentHP -= gameState.hero.heroDamage
			
		} else if !gameState.isHeroTurn && gameState.enemy.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.enemy.currentEnergy -= gameState.skillEnergyCost
			gameState.hero.heroCurrentHP -= gameState.enemy.enemyDamage
		}
		
		winLoseCondition()
		print(!gameState.isHeroTurn ? "\(gameState.hero.heroCurrentHP)" : "\(gameState.enemy.enemyCurrentHP)")
	}
	
	func block() {
		
		if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			gameState.hero.defence += gameState.blockValue
			
		} else if !gameState.isHeroTurn && gameState.enemy.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.enemy.currentEnergy -= gameState.skillEnergyCost
			gameState.enemy.defence += gameState.blockValue
		}
	}
	
	func heal() {
		
		if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			gameState.hero.heroCurrentHP += gameState.hero.spellPower
			
			if gameState.hero.heroCurrentHP >= gameState.hero.heroMaxHP {
				gameState.hero.heroCurrentHP = gameState.hero.heroMaxHP
			}
			
		} else if !gameState.isHeroTurn && gameState.enemy.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.enemy.currentEnergy -= gameState.skillEnergyCost
			gameState.enemy.enemyCurrentHP += gameState.enemy.spellPower
			
			if gameState.enemy.enemyCurrentHP >= gameState.enemy.enemyMaxHP {
				gameState.enemy.enemyCurrentHP = gameState.enemy.enemyMaxHP
			}
			
		}
		
	}
	
	// MARK: - Utility
	
	func endHeroTurn() {
		
		if gameState.isHeroTurn {
			gameState.isHeroTurn = false
			restoreEnergy()
			print("Now is Enemy Turn")
		}
		
		enemyTurn()
	}
	
	func enemyTurn() {
		
		if !gameState.isHeroTurn {
			
			guard gameState.enemy.currentEnergy > 0 else {
				gameState.isHeroTurn = true
				restoreEnergy()
				print("Now is Hero Turn")
				return
			}
			
			let extraActionDelay = 0.5 + Double(gameState.enemy.currentEnergy) / 5.0
			
			DispatchQueue.main.asyncAfter(deadline: .now() + extraActionDelay) {
				print("Enemy Attack!")
				self.attack()
				self.enemyTurn()
			}
			
		}
		
	}
	
	func restoreEnergy() {
		
		gameState.isHeroTurn ?
		(gameState.hero.currentEnergy = gameState.hero.maxEnergy) :
		(gameState.enemy.currentEnergy = gameState.enemy.maxEnergy)
	}
	
	func restoreHP() {
		
		gameState.hero.heroCurrentHP = gameState.hero.heroMaxHP
		gameState.enemy.enemyCurrentHP = gameState.enemy.enemyMaxHP
	}
	
	func restoreMana() {
		
		gameState.hero.currentMana = gameState.hero.maxMana
		gameState.enemy.currentMana = gameState.enemy.maxMana
	}
	
	func restoreStats() {
		
		restoreHP()
		restoreMana()
		restoreEnergy()
	}
	
	func winLoseCondition() {
		
		if gameState.hero.heroCurrentHP <= 0 {
			fatalError("The End")
		} else if gameState.enemy.enemyCurrentHP <= 0 {
			getRewardAfterFight()
			gameState.didEncounterEnemy = false
			goToDungeon()
		}
	}
	
	func getRewardAfterFight() {
		
		gameState.battlesWon += 1
		gameState.heroCurrentXP += gameState.xpPerEnemy
		gameState.heroGold += gameState.goldPerEnemy
		
		checkForLevelUP()
	}
	
	func checkForLevelUP() {
		if gameState.heroCurrentXP >= gameState.heroMaxXP {
			gameState.hero.levelUP()
			gameState.heroCurrentXP = 0
			gameState.heroMaxXP += 20
		}
	}
	
	// MARK: - Dungeon Generation/Movement
	
	
	
	// MARK: GenerateMap

	/// Extract current DungeonSnapshot -> generate new map based on current level -> save and apply new snapshot
	func generateMap() {

		let levelScheme = dungeonScheme.dungeonLevel10
		gameState.dungeonMap = self.dungeonGenerator.parseDungeonLevel(levelScheme)
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
				print("We are under attack!")
				print(heroPosition)

				goToBattle()
				restoreStats()

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
