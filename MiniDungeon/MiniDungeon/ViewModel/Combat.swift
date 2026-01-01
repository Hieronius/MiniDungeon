import SwiftUI

extension MainViewModel {
	
	// MARK: Start Mini Game
	
	/// Check energy for action and start a miniGame
	func startMiniGame() {
		
		if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost {
			gameState.isCombatMiniGameIsOn = true
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
		
		gameState.isCombatMiniGameIsOn = false
		gameState.isCombatMiniGameSuccessful = success
		
		if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			
			// hit chance
			
			let hitRoll = Int.random(in: 1...100)
			if hitRoll > gameState.hero.hitChance {
				gameState.logMessage = "Hero's Attack has been missed!"
				return
			}
			
			// damage - enemy defence
			
			var damage = Int.random(in: gameState.hero.minDamage...gameState.hero.maxDamage) - gameState.enemy.defence
			
			// mini game success check
			
			if gameState.isCombatMiniGameSuccessful  {
				damage = Int(Double(damage) * 1.25)
				gameState.logMessage += "Nice Hit!"
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
			
			// If hero hit an enemy even with 0 damage -> add combo points
			if gameState.comboPoints < 5 {
				print("HELLO?")
				gameState.comboPoints += 1
				print(gameState.comboPoints)
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
	
	// MARK: ComboAttack
	
	/// You can use this attack when hero has 3 or more combo points
	/// Attack will always hit with special effects accordingly to how much combo points hero have
	/// 3 points -> +50% damage
	/// 4 points -> Ignore Armor
	/// 5 points -> 100% crit
	func comboAttack() {
		
		guard gameState.hero.currentEnergy >= 1 else { return }
		guard gameState.comboPoints >= 3 else { return }
		

		switch gameState.comboPoints {
			
		case 3:
			
			// With 3 combo points it will be an attack of 150% of damage
			
			let baseDamage = Int(Double(Int.random(in: gameState.hero.minDamage...gameState.hero.maxDamage) - gameState.enemy.defence) * 1.5)
			
			let critRoll = Int.random(in: 1...100)
			
			if critRoll <= gameState.hero.critChance {
				
				let criticalDamage = Int(Double(baseDamage) * 1.5)
				gameState.enemy.enemyCurrentHP -= criticalDamage
				gameState.logMessage = "Critical Combo hit! - \(criticalDamage) has been done!"
				// if critical strike successful get 1 extra dark energy
				gameState.heroDarkEnergy += 1
				
			} else {
				gameState.enemy.enemyCurrentHP -= baseDamage
				gameState.logMessage = "\(baseDamage) Combo damage has been done!"
			}
			
		case 4:
			
			// With 4 Combo Points - 175% of damage + ignore target armor
			
			let baseDamage = Int(Double(Int.random(in: gameState.hero.minDamage...gameState.hero.maxDamage)) * 1.75)
			
			let critRoll = Int.random(in: 1...100)
			
			if critRoll <= gameState.hero.critChance {
				
				let criticalDamage = Int(Double(baseDamage) * 1.5)
				gameState.enemy.enemyCurrentHP -= criticalDamage
				gameState.logMessage = "Critical Combo hit! - \(criticalDamage) has been done!"
				// if critical strike successful get 1 extra dark energy
				gameState.heroDarkEnergy += 1
				
			} else {
				gameState.enemy.enemyCurrentHP -= baseDamage
				gameState.logMessage = "\(baseDamage) Combo damage has been done!"
			}
			
		case 5:
			
			// With 5 Combo Points you deal 300% damage
			
			let baseDamage = Int.random(in: gameState.hero.minDamage...gameState.hero.maxDamage)
			let damage = Double(baseDamage - gameState.enemy.defence) * 2.0
			
			let criticalDamage = Int(damage * 1.5)
			gameState.enemy.enemyCurrentHP -= criticalDamage
			gameState.logMessage = "Critical Combo hit! - \(criticalDamage) has been done!"
			// if critical strike successful get 1 extra dark energy
			gameState.heroDarkEnergy += 1
			
			
		default: fatalError("Something went wrong with combo attack")
			
		}
		
		gameState.didEnemyReceivedComboAttack = true
		gameState.comboPoints = 0
		gameState.hero.currentEnergy -= 1
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			self.winLoseCondition()
			self.gameState.didEnemyReceivedComboAttack = false
		}
	}
	
	// MARK: TestEnemyExecute
	
	func testEnemyExecute() {
		
		guard gameState.isHeroTurn else { return }
		gameState.enemy.enemyCurrentHP -= 100
		winLoseCondition()
	}
	
	// MARK: TestEnergyRestoration
	
	func testComboPointsRestoration() {
		
		guard gameState.isHeroTurn else { return }
		gameState.comboPoints = 5
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
				
				// Enemy should get 50% of block value due to lack of test data so it won't ruin an entire game
				gameState.enemy.defence += (gameState.blockValue / 2)
				gameState.didEnemyUseBlock = true
			}
			gameState.logMessage = "Block Ability has been used by the Enemy!"
		}
	}
	
	// MARK: Heal
	
	func heal() {
		
		// Hero Turn
		
		if gameState.isHeroTurn &&
			gameState.hero.currentEnergy >= gameState.skillEnergyCost &&
			gameState.hero.currentMana >= gameState.spellManaCost {
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			gameState.hero.currentMana -= gameState.spellManaCost
			gameState.hero.currentHP += gameState.hero.spellPower
			
			if gameState.hero.currentHP >= gameState.hero.maxHP {
				gameState.hero.currentHP = gameState.hero.maxHP
			}
			
			gameState.logMessage = "\(gameState.hero.spellPower) amount of health has been recovered by hero"
			
		} else if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost &&
			gameState.hero.currentMana < gameState.spellManaCost {
			gameState.logMessage = "Not enough mana to cast"
			
			
			// Enemy Turn
			
		} else if !gameState.isHeroTurn &&
					gameState.enemy.currentEnergy >= gameState.skillEnergyCost &&
					gameState.enemy.currentMana >= gameState.spellManaCost {
			
			gameState.enemy.currentEnergy -= gameState.skillEnergyCost
			gameState.enemy.enemyCurrentHP += gameState.enemy.spellPower
			gameState.logMessage = "\(gameState.enemy.spellPower) amount of health has been recovered by enemy"
			
			if gameState.enemy.enemyCurrentHP >= gameState.enemy.enemyMaxHP {
				gameState.enemy.enemyCurrentHP = gameState.enemy.enemyMaxHP
			}
			
		}
		
	}
}
