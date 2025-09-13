import SwiftUI

extension MainViewModel {
	
	// MARK: - Combat
	
	func attack() {
		
		if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			
			
			let damage = gameState.hero.heroDamage - gameState.enemy.defence
			
			if damage > 0 {
				gameState.enemy.enemyCurrentHP -= damage
				print("\(damage) has been received")
				
			} else {
				print("0 damage has been received")
			}
			
			
		} else if !gameState.isHeroTurn && gameState.enemy.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.enemy.currentEnergy -= gameState.skillEnergyCost
			
			let damage = gameState.enemy.enemyDamage - gameState.hero.defence
			
			if damage > 0 {
				
				gameState.hero.heroCurrentHP -= damage
				print("\(damage) damage has been done")
				
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
				
				gameState.hero.defence += gameState.blockValue
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
