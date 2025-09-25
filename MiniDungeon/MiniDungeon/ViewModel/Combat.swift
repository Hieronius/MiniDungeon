import SwiftUI

extension MainViewModel {
	
	// MARK: - Attack
	
	func attack() {
		
		if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost {
			
			// TODO: mini game "Fast Reload" starts here
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			
			// hit chance
			
			let hitRoll = Int.random(in: 1...100)
			if hitRoll > gameState.hero.hitChance {
				gameState.logMessage = "Hero's Attack has been missed!"
				print("Hero's Attack has been missed!")
				return
			}
			
			// damage
			
			let damage = Int.random(in: gameState.hero.minDamage...gameState.hero.maxDamage) - gameState.enemy.defence
			
			// crit chance
			
			let critRoll = Int.random(in: 1...100)
			
			if damage > 0 {
				
				if critRoll <= gameState.hero.critChance {
					
					let criticalDamage = Int(Double(damage) * 1.5)
					gameState.enemy.enemyCurrentHP -= criticalDamage
					gameState.logMessage = "Critical hit - \(criticalDamage) has been done!"
					print("Critical hit - \(criticalDamage) has been done!")
					
				} else {
					gameState.enemy.enemyCurrentHP -= damage
					gameState.logMessage = "\(damage) damage has been done"
					print("\(damage) damage has been done")
				}
				
			} else {
				print("0 damage has been received")
			}
			
			
		} else if !gameState.isHeroTurn && gameState.enemy.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.enemy.currentEnergy -= gameState.skillEnergyCost
			
			let hitRoll = Int.random(in: 1...100)
			if hitRoll > gameState.enemy.hitChance {
				gameState.logMessage = "Enemy Attack has been missed"
				print("Enemy Attack has been missed")
				return
			}
			
			let damage = Int.random(in: gameState.enemy.minDamage...gameState.enemy.maxDamage) - gameState.hero.defence
			
			let critRoll = Int.random(in: 1...100)
			
			if damage > 0 {
				
				if critRoll <= gameState.enemy.critChance {
					let criticalDamage = Int(Double(damage) * 1.5)
					gameState.hero.currentHP -= criticalDamage
					gameState.logMessage = "Critical hit - \(criticalDamage) has been done!"
					print("Critical hit - \(criticalDamage) has been done!")
					
				} else {
					gameState.hero.currentHP -= damage
					gameState.logMessage = "\(damage) damage has been done"
					print("\(damage) damage has been done")
				}
				
			} else {
				gameState.logMessage = "0 damage has been received"
				print("0 damage has been received")
			}
		}
		
		winLoseCondition()
		print(!gameState.isHeroTurn ? "\(gameState.hero.currentHP)" : "\(gameState.enemy.enemyCurrentHP)")
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
				print("Block Ability has been used by the Hero!")
			}
			
		} else if !gameState.isHeroTurn &&
					gameState.enemy.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.enemy.currentEnergy -= gameState.skillEnergyCost
			
			if gameState.didEnemyUseBlock == false {
				
				gameState.enemy.defence += gameState.blockValue
				gameState.didEnemyUseBlock = true
			}
			gameState.logMessage = "Block Ability has been used by the Enemy!"
			print("Block Ability has been used by the Enemy!")
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
			print("\(gameState.hero.spellPower) amount of health has been recovered")
			
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
