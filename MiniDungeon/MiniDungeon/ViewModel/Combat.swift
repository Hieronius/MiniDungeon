import SwiftUI

extension MainViewModel {
	
	// MARK: Start Mini Game
	
	/// Check energy for action and start a miniGame
	func startMiniGame() {
		
		if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost {
			gameState.isMiniGameOn = true
		}
	}
	
	// MARK: startBattleWithRandomNonEliteEnemy
	
	/// Method to prepare game state and both sides for a battle
	func startBattleWithRandomNonEliteEnemy() {
		
		gameState.enemy = generateEnemy(didFinalBossSummoned: false)
		restoreAllEnergy()
		gameState.didHeroUseBlock = false
		gameState.didEnemyUseBlock = false
		goToBattle()
		gameState.logMessage = "Battle begin!"
	}
	
	// MARK: - Attack
	
	func continueAttackAfterMiniGame(success: Bool) {
		
		gameState.isMiniGameOn = false
		gameState.isMiniGameSuccessful = success
		
		if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			
			// hit chance
			
			let hitRoll = Int.random(in: 1...100)
			if hitRoll > gameState.hero.hitChance {
				gameState.logMessage = "Hero's Attack has been missed!"
				return
			}
			
			// damage
			
			var damage = Int.random(in: gameState.hero.minDamage...gameState.hero.maxDamage) - gameState.enemy.defence
			
			// mini game success check
			
			if gameState.isMiniGameSuccessful  {
				damage = Int(Double(damage) * 1.25)
				gameState.logMessage += " Nice Hit!"
			}
			
			// crit chance
			
			let critRoll = Int.random(in: 1...100)
			
			if damage > 0 {
				
				if critRoll <= gameState.hero.critChance {
					
					let criticalDamage = Int(Double(damage) * 1.5)
					gameState.enemy.enemyCurrentHP -= criticalDamage
					gameState.logMessage = "Critical hit - \(criticalDamage) has been done!"
					// if critical strike successful get 1 extra dark energy
					gameState.heroDarkEnergy += 1
					
				} else {
					gameState.enemy.enemyCurrentHP -= damage
					gameState.logMessage = "\(damage) damage has been done."
				}
				
			}
			
			
		} else if !gameState.isHeroTurn && gameState.enemy.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.enemy.currentEnergy -= gameState.skillEnergyCost
			
			let hitRoll = Int.random(in: 1...100)
			if hitRoll > gameState.enemy.hitChance {
				gameState.logMessage = "Enemy Attack has been missed"
				return
			}
			
			let damage = Int.random(in: gameState.enemy.minDamage...gameState.enemy.maxDamage) - gameState.hero.defence
			
			let critRoll = Int.random(in: 1...100)
			
			if damage > 0 {
				
				if critRoll <= gameState.enemy.critChance {
					let criticalDamage = Int(Double(damage) * 1.5)
					gameState.hero.currentHP -= criticalDamage
					gameState.logMessage = "Critical hit - \(criticalDamage) has been done!"
					
					// If enemy get a critical strike and hero has more than 0 dark energy -> deduct a single one
					if gameState.heroDarkEnergy > 0 {
						gameState.heroDarkEnergy -= 1
					}
					
				} else {
					gameState.hero.currentHP -= damage
					gameState.logMessage = "\(damage) damage has been done by enemy"
				}
				
			} else {
				gameState.logMessage = "0 damage has been made"
			}
		}
		
		winLoseCondition()
	}
	
	// MARK: Fireball
	
	func fireball() {
		
		guard gameState.isHeroTurn else { return }
		gameState.enemy.enemyCurrentHP -= 100
		winLoseCondition()
	}
	
	// MARK: Block
	
	func block() {
		
		if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			
			if gameState.didHeroUseBlock == false {
				
				gameState.hero.baseDefence += gameState.blockValue
				gameState.didHeroUseBlock = true
				gameState.logMessage = "Block Ability has been used by the Hero!"
			}
			
		} else if !gameState.isHeroTurn &&
					gameState.enemy.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.enemy.currentEnergy -= gameState.skillEnergyCost
			
			if gameState.didEnemyUseBlock == false {
				
				gameState.enemy.defence += gameState.blockValue
				gameState.didEnemyUseBlock = true
			}
			gameState.logMessage = "Block Ability has been used by the Enemy!"
		}
	}
	
	// MARK: Heal
	
	func heal() {
		
		if gameState.isHeroTurn &&
			gameState.hero.currentEnergy >= gameState.skillEnergyCost &&
			gameState.hero.currentMana >= gameState.spellManaCost {
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			gameState.hero.currentMana -= gameState.spellManaCost
			gameState.hero.currentHP += gameState.hero.spellPower
			
			if gameState.hero.currentHP >= gameState.hero.maxHP {
				gameState.hero.currentHP = gameState.hero.maxHP
			}
			
			gameState.logMessage = "\(gameState.hero.spellPower) amount of health has been recovered"
			
		} else if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost &&
			gameState.hero.currentMana < gameState.spellManaCost {
			gameState.logMessage = "Not enough mana to cast"
			
		} else if !gameState.isHeroTurn &&
					gameState.enemy.currentEnergy >= gameState.skillEnergyCost &&
					gameState.enemy.currentMana >= gameState.spellManaCost {
			
			gameState.enemy.currentEnergy -= gameState.skillEnergyCost
			gameState.enemy.enemyCurrentHP += gameState.enemy.spellPower
			
			if gameState.enemy.enemyCurrentHP >= gameState.enemy.enemyMaxHP {
				gameState.enemy.enemyCurrentHP = gameState.enemy.enemyMaxHP
			}
			
		}
		
	}
}
