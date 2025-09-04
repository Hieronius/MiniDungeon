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
		gameScreen = .heroStats
	}
	
	func goToOptions() {
		gameScreen = .options
	}
	
	func goToRewards() {
		gameScreen = .rewards
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
	
	func fireball() {
		
		guard gameState.isHeroTurn else { return }
		gameState.enemy.enemyCurrentHP -= 100
		winLoseCondition()
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
	
	func restoreEnemyEnergy() {
		gameState.enemy.currentEnergy = gameState.enemy.maxEnergy
	}
	
	func restoreEnemyHP() {
		gameState.enemy.enemyCurrentHP = gameState.enemy.enemyMaxHP
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
}
