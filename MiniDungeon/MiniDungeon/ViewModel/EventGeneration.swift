import SwiftUI

extension MainViewModel {
	
	// MARK: - Generate Enemy
	
	func generateEnemy(didFinalBossSummoned: Bool) -> Enemy {
		
		// Monster name generator
		let enemyName = ["Skeleton", "Goblin", "Rat", "Ghoul"].randomElement()
		
		// Modifer for level difficulty
		// 1 level = 0 %
		// 2 level = 5 %
		// 3 level = 10 % and so on
		
		
		// Ratio to increase all stats if it's a boss
		let bossModifier: Double = 1.5
		
		// dividing 0 by 100 is totally fine
		let difficultyLevel = Double(gameState.currentDungeonLevel * 10) / 100.0
		
		let hp = Int(Double.random(in: 50...100))
		let finalHP = hp + Int(Double(hp) * difficultyLevel)
		
		let mp = Int.random(in: 10...50)
		let finalMP = mp + Int(Double(mp) * difficultyLevel)
		
		let damage = Int.random(in: 5...10)
		let finalDamage = damage + Int(Double(damage) * difficultyLevel)
		
		let energy = 3
		let maxEnergy = 3
		
		let spellPower = Int.random(in: 5...10)
		let finalSpellPower = spellPower + Int(Double(spellPower) * difficultyLevel)
		
		let defence = Int.random(in: 0...3)
		let finalDefence = defence + Int(Double(defence) * difficultyLevel)
		
		if !didFinalBossSummoned {
			
			return Enemy(
				enemyCurrentHP: finalHP,
				enemyMaxHP: finalHP,
				currentMana: finalMP,
				maxMana: finalMP,
				currentEnergy: energy,
				maxEnergy: maxEnergy,
				enemyDamage: finalDamage,
				defence: finalDefence,
				spellPower: finalSpellPower
			)
			
		} else {
			
			return Enemy(
				enemyCurrentHP: Int(Double(finalHP) * bossModifier),
				enemyMaxHP: Int(Double(finalHP) * bossModifier),
				currentMana: Int(Double(finalMP) * bossModifier),
				maxMana: Int(Double(finalMP) * bossModifier),
				currentEnergy: energy + 2,
				maxEnergy: maxEnergy + 2,
				enemyDamage: Int(Double(finalDamage) * bossModifier),
				defence: Int(Double(finalDefence) * bossModifier),
				spellPower: Int(Double(finalSpellPower) * bossModifier)
			)
		}
	}
}
