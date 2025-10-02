import SwiftUI

extension MainViewModel {
	
	// MARK: - Generate Weapon Loot
	
	func generateWeaponLoot(didFinalBossSummoned: Bool) -> Weapon? {
		
		/*
		 1 level = 10% to generate level 1 weapon
		 2 level = 9% to generate level 2 weapon
		 3 level = 8% to generate level 3 weapon
		 4 level = 7% to generate level 4 weapon
		 5 level = 6% to generate level 5 weapon
		 */
		
		var dropRoll = Int.random(in: 1...100)
		
		if didFinalBossSummoned { dropRoll /= 2 }
		
		var weaponLoot: Weapon? = nil
		
		switch gameState.currentDungeonLevel {
			
		case 0: if dropRoll <= 10 { weaponLoot = WeaponManager.weapons[0] }
			
		case 1: if dropRoll <= 9 { weaponLoot = WeaponManager.weapons[1] }
			
		case 2: if dropRoll <= 8 { weaponLoot = WeaponManager.weapons[2] }
			
		case 3: if dropRoll <= 7 { weaponLoot = WeaponManager.weapons[3] }
			
		case 4: if dropRoll <= 6 { weaponLoot = WeaponManager.weapons[4] }
			
		default:
			break
		}
		return weaponLoot
	}
	
	// MARK: - Generate Armor Loot
	
	func generateArmorLoot(didFinalBossSummoned: Bool) -> Armor? {
		
		/*
		 1 level = 10% to generate level 1 armor
		 2 level = 9% to generate level 2 armor
		 3 level = 8% to generate level 3 armor
		 4 level = 7% to generate level 4 armor
		 5 level = 6% to generate level 5 armor
		 */
		
		var dropRoll = Int.random(in: 1...100)
		
		if didFinalBossSummoned { dropRoll /= 2 }
		
		var armorLoot: Armor? = nil
		
		switch gameState.currentDungeonLevel {
			
		case 0: if dropRoll <= 10 { armorLoot = ArmorManager.armors[0] }
			
		case 1: if dropRoll <= 9 { armorLoot = ArmorManager.armors[1] }
			
		case 2: if dropRoll <= 8 { armorLoot = ArmorManager.armors[2] }
			
		case 3: if dropRoll <= 7 { armorLoot = ArmorManager.armors[3] }
			
		case 4: if dropRoll <= 6 { armorLoot = ArmorManager.armors[4] }
			
		default:
			break
		}
		return armorLoot
	}
	
	// MARK: - Generate Potion Loot
	
	func generatePotionLoot(didFinalBossSummoned: Bool) -> Item? {
		
		var dropRoll = Int.random(in: 1...100)
		
		if didFinalBossSummoned { dropRoll /= 2 }
		
		var potion: Item? = nil
		
		if dropRoll <= 10 {
			
			let itemIndex = Int.random(in: 0...1)
			potion = ItemManager.potions[itemIndex]
		}
		return potion
	}
	
	// MARK: - Generate Saleable Loot
	
	/// Use method to manage loot on sale drop chance
	func generateSaleableLoot(didFinalBossSummoned: Bool) -> Item? {
		
		// bubbles, trinkets and so on
		var dropRoll = Int.random(in: 1...100)
		
		if didFinalBossSummoned { dropRoll /= 2 }
		
		var loot: Item? = nil
		
		if dropRoll <= 10 {
			
			let itemIndex = Int.random(in: 0...2)
			loot = ItemManager.loot[itemIndex]
		}
		return loot
	}
	
	// MARK: - Generate Merchant Loot
	
	func generateMerchantLoot() -> [any ItemProtocol] {
		
		var items: [any ItemProtocol] = []
		
		
		
		return items
	}
	
	// MARK: - Generate Gold Loot
	
	/// Method to generate random amount of gold after winning the fight
	func generateGoldLoot(didFinalBossSummoned: Bool) -> Int {
		
		var goldRoll = Int.random(in: 10...30)
		
		if didFinalBossSummoned { goldRoll *= 2 }
		
		return goldRoll
	}
	
	// MARK: - Generate Experience Loot
	
	/// Method to generate random amount of experience based on enemy level
	func generateExperienceLoot(didFinalBossSummoned: Bool) -> Int {
		
		var expRoll = Int.random(in: 25...35)
		
		if didFinalBossSummoned { expRoll *= 2 }
		
		return expRoll
	}
	
	// MARK: - Generate Enemy
	
	func generateEnemy(didFinalBossSummoned: Bool) -> Enemy {
		
		// Monster name generator
		guard var enemyName = ["Skeleton", "Goblin", "Rat", "Ghoul"].randomElement() else { return Enemy() }
		
		if didFinalBossSummoned { enemyName += " Elite" }
		
		// Modifer for level difficulty
		// 1 level = 0 %
		// 2 level = 5 %
		// 3 level = 10 % and so on
		
		
		// Ratio to increase all stats if it's a boss
		let bossModifier: Double = 1.5
		
		// dividing 0 by 100 is totally fine
		let difficultyLevel = Double(gameState.currentDungeonLevel * 10) / 100.0
		
		let baseHP = Int(Double.random(in: 25...50))
		let finalHP = baseHP + Int(Double(baseHP) * difficultyLevel)
		
		let mp = Int.random(in: 10...50)
		let finalMP = mp + Int(Double(mp) * difficultyLevel)
		
		let minDamage = Int.random(in: 6...8)
		let finalMinDamage = minDamage + Int(Double(minDamage) * difficultyLevel)
		
		let maxDamage = Int.random(in: 10...12)
		let finalMaxDamage = maxDamage + Int(Double(maxDamage) * difficultyLevel)
		
		let energy = 3
		let maxEnergy = 3
		
		let spellPower = Int.random(in: 5...10)
		let finalSpellPower = spellPower + Int(Double(spellPower) * difficultyLevel)
		
		let defence = Int.random(in: 0...2)
		let finalDefence = defence + Int(Double(defence) * difficultyLevel)
		
		if !didFinalBossSummoned {
			
			return Enemy(
				name: enemyName,
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
				name: enemyName,
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
