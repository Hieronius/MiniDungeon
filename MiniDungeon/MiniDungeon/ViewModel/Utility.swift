import SwiftUI

// MARK: - Utility

extension MainViewModel {
	
	// MARK: endHeroTurn
	
	func endHeroTurn() {
		
		if gameState.isHeroTurn {
			gameState.isHeroTurn = false
			restoreAllEnergy()
			
			if gameState.didEnemyUseBlock {
				endEnemyBlockEffect()
			}
			gameState.logMessage = "Now is Enemy Turn"
			print("Now is Enemy Turn")
			
		}
		
		enemyTurn()
	}
	
	// MARK: enemyTurn
	
	func enemyTurn() {
		
		if !gameState.isHeroTurn {
			
			guard gameState.enemy.currentEnergy > 0 else {
				gameState.isHeroTurn = true
				
				if gameState.didHeroUseBlock {
					endHeroBlockEffect()
				}
				
				restoreAllEnergy()
				gameState.logMessage = "Now is Hero Turn"
				print("Now is Hero Turn")
				return
			}
			
			let extraActionDelay = 0.5 + Double(gameState.enemy.currentEnergy) / 5.0
			
			DispatchQueue.main.asyncAfter(deadline: .now() + extraActionDelay) {
				
				// Calculate current enemy hp in %
				let enemyMaxHealthInPercent = Double(self.gameState.enemy.enemyMaxHP) / 100.0
				let currentHealthInPercent = Double(self.gameState.enemy.enemyCurrentHP) / enemyMaxHealthInPercent
				
				// if enemy has less than 30% hp add heal/block as actions to choose between
				if currentHealthInPercent <= 30.0 {
					print("Enemy has 30% hp and less -> Special Move will be calculated")
					
					// 1 - 100 equal to part of 100% of the chance to get a specific action
					let chance = Int.random(in: 1...100)
					
					switch chance {
						
						// 15% for healing ability
					case 1...15:
						self.heal()
						print("Enemy used Healing Ability")
						
						// 15% for block ability
					case 16...30:
						self.block()
						print("Enemy used Block Ability!")
						
						// 70% for attack ability
					default:
						self.attack()
						print("Enemy Attack!")
					}
					self.enemyTurn()
					
					// If more than 30% of hp just use attack
				} else {
					
					print("Enemy has more than 30% of hp -> Normal Move will be calculated")
					self.attack()
					print("Enemy Attack!")
					self.enemyTurn()
				}
				
			}
			
		}
	}
	
	// MARK: endHeroBlockEffects
	
	func endHeroBlockEffect() {
		
		gameState.didHeroUseBlock = false
		gameState.hero.baseDefence -= gameState.blockValue
		gameState.logMessage = "Hero Block Ability has been removed"
		print("Hero Block Ability has been removed")
	}
	
	func endEnemyBlockEffect() {
		
		gameState.didEnemyUseBlock = false
		gameState.enemy.defence -= gameState.blockValue
		gameState.logMessage = "Enemy Block Ability has been removed"
		print("Enemy Block Ability has been removed")
	}
	
	// MARK: restoreAllEnergy
	
	func restoreAllEnergy() {
		
		gameState.isHeroTurn ?
		(gameState.hero.currentEnergy = gameState.hero.maxEnergy) :
		(gameState.enemy.currentEnergy = gameState.enemy.maxEnergy)
	}
	
	// MARK: restoreEnemyEnergy
	
	func restoreEnemyEnergy() {
		gameState.enemy.currentEnergy = gameState.enemy.maxEnergy
	}
	
	// MARK: restoreEnemyHP
	
	func restoreEnemyHP() {
		gameState.enemy.enemyCurrentHP = gameState.enemy.enemyMaxHP
	}
	
	// MARK: restoreHP
	
	func restoreHP() {
		
		gameState.hero.heroCurrentHP = gameState.hero.heroMaxHP
		gameState.enemy.enemyCurrentHP = gameState.enemy.enemyMaxHP
	}
	
	// MARK: restoreMana
	
	func restoreMana() {
		
		gameState.hero.currentMana = gameState.hero.maxMana
		gameState.enemy.currentMana = gameState.enemy.maxMana
	}
	
	// MARK: restoreStats
	
	func restoreStats() {
		
		restoreHP()
		restoreMana()
		restoreAllEnergy()
	}
	
	// MARK: winLoseCondition
	
	/// If enemy is dead -> collect rewards and move on
	/// Otherwise go to the start screen, lose everything except score and gold
	func winLoseCondition() {
		
		if gameState.hero.heroCurrentHP <= 0 {
			print("The End")
			setupNewGame()
			
		} else if gameState.enemy.enemyCurrentHP <= 0 &&
					!gameState.didEncounteredBoss {
			print("Average Enemy has been defeated!")
			getRewardAfterFight()
			gameState.didEncounterEnemy = false
			goToDungeon()
			
		} else if gameState.enemy.enemyCurrentHP <= 0 &&
					gameState.didEncounteredBoss {
			
			print("Boss has been defeated!")
			getRewardAfterFight()
			endLevelAndGenerateNewOne()
			goToDungeon()
		}
	}
	
	// MARK: getRewardAfterFight
	
	func getRewardAfterFight() {
		
		gameState.battlesWon += 1
		gameState.heroCurrentXP += gameState.xpPerEnemy
		gameState.heroGold += gameState.goldPerEnemy
		
		checkForLevelUP()
	}
	
	// MARK: checkForLevelUP
	
	func checkForLevelUP() {
		
		if gameState.heroCurrentXP >= gameState.heroMaxXP {
			gameState.hero.levelUP()
			gameState.heroCurrentXP = 0
			gameState.heroMaxXP += 20
		}
	}
}
