import SwiftUI

extension MainViewModel {
	
	// MARK: - Combat
	
	func attack() {
		
		if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			
			let hitRoll = Int.random(in: 1...100)
			if hitRoll > gameState.hero.hitChance {
				print("Hero's Attack has been missed!")
				return
			}
			
			let damage = Int.random(in: gameState.hero.minDamage...gameState.hero.maxDamage) - gameState.enemy.defence
			
			let critRoll = Int.random(in: 1...100)
			
			if damage > 0 {
				
				if critRoll <= gameState.hero.critChance {
					
					let criticalDamage = Int(Double(damage) * 1.5)
					gameState.enemy.enemyCurrentHP -= criticalDamage
					print("Critical hit - \(criticalDamage) has been done!")
					
				} else {
					gameState.enemy.enemyCurrentHP -= damage
					print("\(damage) has been done")
				}
				
			} else {
				print("0 damage has been received")
			}
			
			
		} else if !gameState.isHeroTurn && gameState.enemy.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.enemy.currentEnergy -= gameState.skillEnergyCost
			
			let hitRoll = Int.random(in: 1...100)
			if hitRoll > gameState.enemy.hitChance {
				print("Enemy Attack has been missed")
				return
			}
			
			let damage = Int.random(in: gameState.enemy.minDamage...gameState.enemy.maxDamage) - gameState.hero.defence
			
			let critRoll = Int.random(in: 1...100)
			
			if damage > 0 {
				
				if critRoll <= gameState.enemy.critChance {
					let criticalDamage = Int(Double(damage) * 1.5)
					gameState.hero.heroCurrentHP -= criticalDamage
					print("Critical hit - \(criticalDamage) has been done!")
					
				} else {
					gameState.hero.heroCurrentHP -= damage
					print("\(damage) damage has been done")
				}
				
			} else {
				print("0 damage has been received")
			}
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
			
			if gameState.didHeroUseBlock == false {
				
				gameState.hero.baseDefence += gameState.blockValue
				gameState.didHeroUseBlock = true
				print("Block Ability has been used by the Hero!")
			}
			
		} else if !gameState.isHeroTurn &&
					gameState.enemy.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.enemy.currentEnergy -= gameState.skillEnergyCost
			
			if gameState.didEnemyUseBlock == false {
				
				gameState.enemy.defence += gameState.blockValue
				gameState.didEnemyUseBlock = true
			}
			print("Block Ability has been used by the Enemy!")
		}
	}
	
	func heal() {
		
		if gameState.isHeroTurn &&
			gameState.hero.currentEnergy >= gameState.skillEnergyCost &&
			gameState.hero.currentMana >= gameState.spellManaCost {
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			gameState.hero.currentMana -= gameState.spellManaCost
			gameState.hero.heroCurrentHP += gameState.hero.spellPower
			
			if gameState.hero.heroCurrentHP >= gameState.hero.heroMaxHP {
				gameState.hero.heroCurrentHP = gameState.hero.heroMaxHP
			}
			
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
