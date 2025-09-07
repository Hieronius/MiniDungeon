import SwiftUI

// MARK: - Utility

extension MainViewModel {
	
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
