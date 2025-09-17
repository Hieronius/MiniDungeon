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
		
		let minDamage = Int.random(in: 2...4)
		let finalMinDamage = minDamage + Int(Double(minDamage) * difficultyLevel)
		
		let maxDamage = Int.random(in: 4...6)
		let finalMaxDamage = maxDamage + Int(Double(maxDamage) * difficultyLevel)
		
		let energy = 3
		let maxEnergy = 3
		
		let spellPower = Int.random(in: 5...10)
		let finalSpellPower = spellPower + Int(Double(spellPower) * difficultyLevel)
		
		let defence = Int.random(in: 0...2)
		let finalDefence = defence + Int(Double(defence) * difficultyLevel)
		
		if !didFinalBossSummoned {
			
			return Enemy(
				enemyCurrentHP: finalHP,
				enemyMaxHP: finalHP,
				currentMana: finalMP,
				maxMana: finalMP,
				currentEnergy: energy,
				maxEnergy: maxEnergy,
				minDamage: finalMinDamage,
				maxDamage: finalMaxDamage,
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
				minDamage: Int(Double(finalMinDamage) * bossModifier),
				maxDamage: Int(Double(finalMaxDamage) * bossModifier),
				defence: Int(Double(finalDefence) * bossModifier),
				spellPower: Int(Double(finalSpellPower) * bossModifier)
			)
		}
	}
}
