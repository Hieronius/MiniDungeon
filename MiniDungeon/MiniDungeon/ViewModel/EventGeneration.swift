import SwiftUI

extension MainViewModel {
	
	// MARK: generateRewardRarity
	
	func generateRewardRarity() -> Rarity {
		
		let roll = Int.random(in: 1...100)
		
		switch roll {
			
		case 1...5: return Rarity.legendary
			
		case 6...15: return Rarity.epic
			
		case 16...30: return Rarity.rare
			
		case 31...100: return Rarity.common
			
		default: return Rarity.common
			
		}
	}
	
	// MARK: generateLoot
	
	/// Combine all types of items and it's chance to drop in a single method to call
	func generateLoot() {
		
		gameState.didFindLootAfterFight = true
		
		// saleable loot
		
		if let loot = generateSaleableLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss
		) {
			gameState.hero.inventory[loot, default: 0] += 1
			gameState.lootToDisplay.append(loot.label)
			print("found \(loot)")
		}
		
		// potion loot
		
		if let potion = generatePotionLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss
		) {
			gameState.hero.inventory[potion, default: 0] += 1
			gameState.lootToDisplay.append(potion.label)
			print("found \(potion)")
		}
		
		// weapon loot
		
		if let weapon = generateWeaponLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss
		) {
			gameState.hero.weapons[weapon, default: 0] += 1
			gameState.lootToDisplay.append(weapon.label)
			print("found and equiped \(weapon)")
			print(gameState.hero.weapons)
		}
		
		// armor loot
		
		if let armor = generateArmorLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss
		) {
			gameState.hero.armors[armor, default: 0] += 1
			gameState.lootToDisplay.append(armor.label)
			print("found and equiped \(armor)")
			print(gameState.hero.armors)
		}
		
		// gold loot
		
		let gold = generateGoldLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss
		)
		gameState.heroGold += gold
		gameState.goldLootToDisplay = gold
		
		// experience loot
		
		let exp = generateExperienceLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss
		)
		gameState.hero.currentXP += exp
		gameState.expLootToDisplay = exp
	}
	
	// MARK: - Generate Weapon Loot
	
	/// Throw loot roll and if it's in the range throw rarity roll to get a random weapon of given quality
	func generateWeaponLoot(didFinalBossSummoned: Bool) -> Weapon? {
		
		// 1. After killing the target -> throw the loot roll
		
		var dropRoll = Int.random(in: 1...100)
		
		// If boss killed -> increase the chance for loot by 2
		
		if didFinalBossSummoned { dropRoll /= 2 }
		
		var weaponLoot: Weapon? = nil
		
		// Chance to drop any loot should be around 20%
		
		guard dropRoll <= 20 else { return nil }
		
		// 2. If we in the range of the 20% let's generate rarity of the loot
		
		let rarity = generateRewardRarity()
		
		switch gameState.currentDungeonLevel {
			
			// In level 0 we can drop common weapons
		case 0:
			
			if rarity == .common {
				weaponLoot = WeaponManager.generateWeapon(of: .common)
			}
			
			// In level 1 we can drop rare weapons + common weapons
		case 1:
			
			if rarity == .common {
				weaponLoot = WeaponManager.generateWeapon(of: .common)
				
			} else if rarity == .rare {
				weaponLoot = WeaponManager.generateWeapon(of: .rare)
			}
			
			// In level 2 we can drop epic weapons + rare weapons + common weapons
		case 2:
			
			if rarity == .common {
				weaponLoot = WeaponManager.generateWeapon(of: .common)
				
			} else if rarity == .rare {
				weaponLoot = WeaponManager.generateWeapon(of: .rare)
				
			} else if rarity == .epic {
				weaponLoot = WeaponManager.generateWeapon(of: .epic)
			}
			
			// In level 3+ we can drop legendary + epic + rare + common weapons
		default: weaponLoot = WeaponManager.generateWeapon(of: rarity)
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
		
		/* Feels like we need a pool of armor rolls to drop
		   So we can add more drops for each level
		*/
		
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
	
	func generateMerchantLoot() {
		
		gameState.merchantWeaponsLoot = [:]
		gameState.merchantArmorsLoot = [:]
		gameState.merchantInventoryLoot = [:]
		
		for _ in 1...5 {
			
			let weapon = generateWeaponLoot(didFinalBossSummoned: true)
			if weapon != nil {
				gameState.merchantWeaponsLoot[weapon!, default: 0] += 1
			}
			
			let armor = generateArmorLoot(didFinalBossSummoned: true)
			if armor != nil {
				gameState.merchantArmorsLoot[armor!, default: 0] += 1
			}
			
			let potion = generatePotionLoot(didFinalBossSummoned: true)
			if potion != nil {
				gameState.merchantInventoryLoot[potion!, default: 0] += 1
			}
		}
		
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
