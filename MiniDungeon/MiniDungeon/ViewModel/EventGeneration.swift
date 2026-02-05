import SwiftUI

extension MainViewModel {
	
	// MARK: endLevelAndGenerateNewOne
	
	/// If Level complete and boss has been defeated go to the next one
	func endLevelAndGenerateNewOne() {
		
		generateMerchantLoot()
		
		goToMerchant()
		
		gameState.didEncounteredBoss = false
		gameState.currentDungeonLevel += 1
		gameState.isHeroAppeared = false
//		gameState.itemToDisplay = nil
		gameState.dungeonLevelBeenExplored = false
		
		generateMap()
		spawnHero()
	}
	
	// MARK: summonBoss
	
	/// If level been completed -> summon the boss and start the fight
	func summonBoss() {
		
		gameState.didEncounteredBoss = true
		gameState.enemy = generateEnemy(didFinalBossSummoned: gameState.didEncounteredBoss)
		restoreAllEnergy()
		goToBattle()
	}

	// MARK: spawnHero

	/// Method should traverse dungeon map in reversed order and put hero at the first non empty tile
	func spawnHero() {

		// map size

		let map = gameState.dungeonMap

		let n = map.count
		let m = map[0].count

		// map traversing

		for row in (0..<n).reversed() {
			for col in (0..<m).reversed() {
				let tile = map[row][col]
				if tile.type == .room && !gameState.isHeroAppeared {
					gameState.heroPosition = Coordinate(row: row, col: col)
					gameState.isHeroAppeared = true
				}
			}
		}
		gameState.dungeonMap[gameState.heroPosition.row][gameState.heroPosition.col].isExplored = true
	}
	
	// MARK: generateRewardRarity
	
	func generateRewardRarity() -> Rarity {
		
		let roll = Int.random(in: 1...100)
		
		switch roll {
			
		case 1: return Rarity.legendary
			
		case 2...5: return Rarity.epic
			
		case 6...15: return Rarity.rare
			
		case 16...100: return Rarity.common
			
		default: return Rarity.common
			
		}
	}
	
	// MARK: - getRewardsAndCleanTheScreen
	
	func getRewardsAndCleanTheScreen() {
		
		// TODO: Check if this is a correct place for reacting on secret room
		gameState.didEncounterSecretRoom = false
		
		gameState.didFindLootAfterFight = false
		gameState.lootToDisplay = []
		
		gameState.goldLootToDisplay = 0
		gameState.expLootToDisplay = 0
		gameState.darkEnergyLootToDisplay = 0
		gameState.healthPointsLootToDisplay = 0
		gameState.manaPointsLootToDisplay = 0
		
		// If there a new level do not intervene with Merchant View
		
		if gameState.didEncounteredBoss {
			endLevelAndGenerateNewOne()
		} else {
			goToDungeon()
			checkForLevelUP()
		}
		
		// In both cases check if there is enough dark energy to level up the flask and animate it to reflect to user
		checkForFlaskLevelUP()
	}
	
	// MARK: - Generate Loot
	
	/// Combine all types of items and it's chance to drop in a single method to call
	func generateLoot() {
		
		gameState.didFindLootAfterFight = true
		
		// extra keys loot
		
		if let loot = generateKeysLoot(didFinalBossSummoned: gameState.didEncounteredBoss) {
			gameState.hero.inventory[loot, default: 0] += 1
			gameState.lootToDisplay.append(loot.label)
			print("got a key in loot")
		}
		
		// saleable loot
		
		if let loot = generateSaleableLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss
			
		) {
			gameState.hero.inventory[loot, default: 0] += 1
			gameState.lootToDisplay.append(loot.label)
		}
		
		// potion loot
		
		if let potion = generatePotionLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss,
			of: generateRewardRarity()
		) {
			gameState.hero.inventory[potion, default: 0] += 1
			gameState.lootToDisplay.append(potion.label)
		}
		
		// weapon loot
		
		if let weapon = generateWeaponLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss,
			of: generateRewardRarity()
		) {
			gameState.hero.weapons[weapon, default: 0] += 1
			gameState.lootToDisplay.append(weapon.label)
		}
		
		// armor loot
		
		if let armor = generateArmorLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss,
			of: generateRewardRarity()
		) {
			gameState.hero.armors[armor, default: 0] += 1
			gameState.lootToDisplay.append(armor.label)
		}
		
		// gold loot
		
		let gold = generateGoldLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss
		)
		gameState.heroGold += gold
		gameState.goldLootToDisplay = gold
		
		
		// experience loot (ignore if it's a chest loot)
		if !gameState.dealthWithChest && !gameState.didEncounterSecretRoom {
			
			let exp = generateExperienceLoot(
				didFinalBossSummoned: gameState.didEncounteredBoss
			)
			
			gameState.hero.currentXP += exp
			gameState.expLootToDisplay = exp
		}
		
		// dark energy loot
		
		let energy = generateDarkEnergyLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss
		)
		gameState.hero.flask.currentXP += energy
		gameState.heroDarkEnergy += energy
		gameState.heroMaxDarkEnergyOverall += energy
		gameState.darkEnergyLootToDisplay = energy
		
	}
	
	// MARK: - Generate Weapon Loot
	
	/// Throw loot roll and if it's in the range throw rarity roll to get a random weapon of given quality
	func generateWeaponLoot(didFinalBossSummoned: Bool, of rarity: Rarity) -> Weapon? {
		
		// 1. After killing the target -> throw the loot roll
		
		var dropRoll = Int.random(in: 1...100)
		
		// If boss killed -> increase the chance for loot by 2
		
		if didFinalBossSummoned { dropRoll /= 2 }
		
		var weaponLoot: Weapon? = nil
		
		// Chance to drop any loot should be around 20%
		
		guard dropRoll <= 20 else { return nil }
		
		// 2. If we in the range of the 20% let's generate rarity of the loot
		
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
			
		case 3: weaponLoot = WeaponManager.generateWeapon(of: rarity)
			
			// In level 3+ we can drop legendary + epic + rare + common weapons
		default: weaponLoot = WeaponManager.generateWeapon(of: rarity)
		}
		
		return weaponLoot
	}
	
	// MARK: - Generate Armor Loot
	
	/// Throw loot roll and if it's in the range throw rarity roll to get a random weapon of given quality
	func generateArmorLoot(didFinalBossSummoned: Bool, of rarity: Rarity) -> Armor? {
	
		// 1. After killing the target -> throw the loot roll
		
		var dropRoll = Int.random(in: 1...100)
		
		// If boss killed -> increase the chance for loot by 2
		
		if didFinalBossSummoned { dropRoll /= 2 }
		
		guard dropRoll <= 20 else { return nil }
		
		var armorLoot: Armor? = nil
		
		// 2. If we in the range of the 20% let's generate rarity of the loot
		
		switch gameState.currentDungeonLevel {
			
			// In level 0 we can drop common armors
		case 0:
			
			if rarity == .common {
				armorLoot = ArmorManager.generateArmor(of: .common)
			}
			
			// In level 1 we can drop rare armors + common armors
		case 1:
			
			if rarity == .common {
				armorLoot = ArmorManager.generateArmor(of: .common)
				
			} else if rarity == .rare {
				armorLoot = ArmorManager.generateArmor(of: .rare)
			}
			
			// In level 2 we can drop epic armors + rare armors + common armors
		case 2:
			
			if rarity == .common {
				armorLoot = ArmorManager.generateArmor(of: .common)
				
			} else if rarity == .rare {
				armorLoot = ArmorManager.generateArmor(of: .rare)
				
			} else if rarity == .epic {
				armorLoot = ArmorManager.generateArmor(of: .epic)
			}
			
		case 3...: armorLoot = ArmorManager.generateArmor(of: rarity)
			
			
			// In level 3+ we can drop legendary + epic + rare + common weapons
		default: armorLoot = ArmorManager.generateArmor(of: rarity)
		}
		return armorLoot
	}
	
	// MARK: - Generate Potion Loot
	
	/// Throw loot roll and if it's in the range throw rarity roll to get a random potion of given quality
	func generatePotionLoot(didFinalBossSummoned: Bool, of rarity: Rarity) -> Item? {
		
		// 1. After killing the target -> throw the loot roll
		
		var dropRoll = Int.random(in: 1...100)
		
		// If boss killed -> increase the chance for loot by 2
		
		if didFinalBossSummoned { dropRoll /= 2 }
		
		guard dropRoll <= 20 else { return nil }
		
		var potionLoot: Item? = nil
		
		// 2. If we in the range of the 20% let's generate rarity of the loot
		
		switch gameState.currentDungeonLevel {
			
		case 0:
			
			if rarity == .common {
				potionLoot = ItemManager.generatePotion(of: .common)
				
			}
			
		case 1:
			
			if rarity == .common {
				potionLoot = ItemManager.generatePotion(of: .common)
				
			} else if rarity == .rare {
				potionLoot = ItemManager.generatePotion(of: .rare)
				
			}
			
		case 2:
			
			if rarity == .common {
				potionLoot = ItemManager.generatePotion(of: .common)
				
			} else if rarity == .rare {
				potionLoot = ItemManager.generatePotion(of: .rare)
				
			} else if rarity == .epic {
				potionLoot = ItemManager.generatePotion(of: .epic)
			}
			
		case 3...: potionLoot = ItemManager.generatePotion(of: rarity)
			
			
			// In level 3+ we can drop legendary + epic + rare + common potions
		default: potionLoot = ItemManager.generatePotion(of: rarity)
		}
		
		
		return potionLoot
	}
	
	// MARK: - Generate Keys Loot
	
	func generateKeysLoot(didFinalBossSummoned: Bool) -> Item? {
		
		var dropRoll = Int.random(in: 1...100)
		
		if didFinalBossSummoned { dropRoll /= 2 }
		
		guard dropRoll <= 15 else { return nil }
		
		return ItemManager.commonLoot[0]
	}
	
	// MARK: - Generate Saleable Loot
	
	/// Use method to manage loot on sale drop chance
	func generateSaleableLoot(didFinalBossSummoned: Bool) -> Item? {
		
		// 1. After killing the target -> throw the loot roll

		var dropRoll = Int.random(in: 1...100)
		
		// If boss killed -> increase the chance for loot by 2
		
		if didFinalBossSummoned { dropRoll /= 2 }
		
		guard dropRoll <= 20 else { return nil }
		
		var loot: Item? = nil
		
		// 2. If we in the range of the 20% let's generate rarity of the loot
		
		let rarity = generateRewardRarity()
		
		switch gameState.currentDungeonLevel {
			
		case 0:
			
			if rarity == .common {
				loot = ItemManager.generateLoot(of: .common)
				
			}
			
		case 1:
			
			if rarity == .common {
				loot = ItemManager.generateLoot(of: .common)
				
			} else if rarity == .rare {
				loot = ItemManager.generateLoot(of: .rare)
				
			}
			
		case 2:
			
			if rarity == .common {
				loot = ItemManager.generateLoot(of: .common)
				
			} else if rarity == .rare {
				loot = ItemManager.generateLoot(of: .rare)
				
			} else if rarity == .epic {
				loot = ItemManager.generateLoot(of: .epic)
			}
			
			// In level 3+ we can drop legendary + epic + rare + common loot
			
		case 3...: loot = ItemManager.generateLoot(of: rarity)
			
		default: loot = ItemManager.generateLoot(of: rarity)
		}
		return loot
	}
	
	// MARK: - Generate Merchant Loot
	
	func generateMerchantLoot() {
		
		gameState.merchantWeaponsLoot = [:]
		gameState.merchantArmorsLoot = [:]
		gameState.merchantInventoryLoot = [:]
		
		// Throw 5 rolls for each type of loot
		
		for _ in 1...5 {
			
			let weapon = generateWeaponLoot(didFinalBossSummoned: true,
											of: generateRewardRarity())
			if weapon != nil {
				gameState.merchantWeaponsLoot[weapon!, default: 0] += 1
			}
			
			let armor = generateArmorLoot(didFinalBossSummoned: true,
										  of: generateRewardRarity())
			if armor != nil {
				gameState.merchantArmorsLoot[armor!, default: 0] += 1
			}
			
			let potion = generatePotionLoot(didFinalBossSummoned: true,
											of: generateRewardRarity())
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
		
//		 put values back to 25...35
		var expRoll = Int.random(in: 25...35)
		
		if didFinalBossSummoned { expRoll *= 2 }
		
		return expRoll
	}
	
	// MARK: - Generate Dark Energy Loot
	
	func generateDarkEnergyLoot(didFinalBossSummoned: Bool) -> Int {
		
		var energyRoll = Int.random(in: 3...8)
//		var energyRoll = 10000
		
		if didFinalBossSummoned { energyRoll *= 2 }
		
		if gameState.shadowGreedShrineBeenActivated {
			print("You receive extra dark energy from Shadow Greed Shrine")
			return Int(Double(energyRoll) * 1.25)
		} else {
			return energyRoll
		}
	}
	
	// MARK: - handleSecretRoomOutcome
	
	/// Method to define was a room really secret, was there a loot or an enemy
	func handleSecretRoomOutcome(row: Int, col: Int) {
		
		// React on user action by changing the flag
		gameState.dungeonMap[row][col].wasTapped = true
		gameState.didTappedUnknownTile = true
		gameState.tappedTilePosition = Coordinate(row: row, col: col)
		print("tapped on unknown room -\(gameState.dungeonMap[row][col].wasTapped)")
		print("didTappedUnknownTile from GameState - \(gameState.didTappedUnknownTile)")
		print(gameState.tappedTilePosition)
		
		// change flag back to stop tile tap animation
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
			self.gameState.dungeonMap[row][col].wasTapped = false
			self.gameState.didTappedUnknownTile = false
			print("change tile property wasTapped back -  \(self.gameState.dungeonMap[row][col].wasTapped)")
			print("didTappedUnknownTile from GameState - \(self.gameState.didTappedUnknownTile)")
		}
		
		let room = gameState.dungeonMap[row][col]
		let secretRoll = Int.random(in: 1...100)
		
		guard secretRoll >= 90 && !room.events.contains(.empty) else {
			gameState.dungeonMap[row][col].events.append(.empty)
			return
		}
		
		gameState.dungeonMap[row][col].events = [.secret]
		
		let enemyRoll = Int.random(in: 1...100)
		
		if enemyRoll <= 20 {
			
			startBattleWithRandomNonEliteEnemy()
			
		} else {
			
			// If we really encounter loot mark this property as true to avoid exp generation
			// Probably should provide a different one
			gameState.didEncounterSecretRoom = true
			generateLoot()
			goToRewards()
		}
	}
	
	// MARK: - Generate Chest Lock-Picking Result
	
	/// Method to generate loot if opening the chest was a success and to generate enemy otherwise
	func calculateChestLockPickingResult(_ forSuccess: Bool) {
		
		if forSuccess {
			generateLoot()
			goToRewards()
			
		} else {
			startBattleWithRandomNonEliteEnemy()
		}
	}
	
	// MARK: getLevelBonusesAfterHeroLevelUpAndGoToLevelBonusScreen
	
	func generateLevelBonusesAfterHeroLevelUpAndGoToLevelBonusScreen() {
		
		// This line cleans previous bonuses to generate
		gameState.heroLevelBonusesToChoose = []
		
		var levelBonusesSet: Set<HeroLevelBonus> = []
		
		// Generate level of raririty -> ask LevelBonusManager to provide a random bonus accordingly to the rarity
		// Add this bonus to levelBonusesToChoose
		while levelBonusesSet.count < 3 {
			
			var counter = 0
			let rarity = generateRewardRarity()
			guard let bonus = HeroLevelBonusManager.generateLevelBonus(of: rarity) else { return }
			levelBonusesSet.insert(bonus)
			counter += 1
			
		}
		gameState.heroLevelBonusesToChoose = Array(levelBonusesSet)
		goToHeroLevelBonus()
	}
	
	// MARK: generateLevelBonusesAfterFlaskLevelUpAndGoToLevelBonusScreen()
	
	func generateLevelBonusesAfterFlaskLevelUpAndGoToLevelBonusScreen() {
		
		// This line cleans previous bonuses to generate
		gameState.flaskLevelBonusesToChoose = []
		
		var levelBonusesSet: Set<FlaskLevelBonus> = []
		
		// Generate level of raririty -> ask LevelBonusManager to provide a random bonus accordingly to the rarity
		// Add this bonus to levelBonusesToChoose
		while levelBonusesSet.count < 3 {
			
			var counter = 0
			let rarity = generateRewardRarity()
			guard let bonus = FlaskLevelBonusManager.generateLevelBonus(of: rarity) else { return }
			levelBonusesSet.insert(bonus)
			counter += 1
			
		}
		gameState.flaskLevelBonusesToChoose = Array(levelBonusesSet)
		goToFlaskLevelBonus()
	}
	
	// MARK: - Generate Trap Defusion Result
	
	func calculateTrapDefusionResult(_ forSuccess: Bool) {
		
		gameState.didFindLootAfterFight = true
		
		if forSuccess {
			
			// If Success -> give some exp and dark energy to hero
			let expLoot = Int.random(in: 1...5)
			let darkEnergyLoot = Int.random(in: 1...5)
			
			gameState.hero.currentXP += expLoot
			gameState.expLootToDisplay = expLoot
			
			gameState.heroDarkEnergy += darkEnergyLoot
			gameState.heroMaxDarkEnergyOverall += darkEnergyLoot
			gameState.hero.flask.currentXP += darkEnergyLoot
			gameState.darkEnergyLootToDisplay = darkEnergyLoot
			print("Gain some rewards")
			
			
		} else {
			
			// If Failure - deduct 10% of health and mana
			let healthPenalty = Int(Double(gameState.hero.maxHP) * 0.1)
			let manaPenalty = Int(Double(gameState.hero.maxMana) * 0.1)
			
			gameState.hero.currentHP -= healthPenalty
			gameState.healthPointsLootToDisplay = -healthPenalty
			
			if gameState.hero.currentMana >= manaPenalty {
				gameState.hero.currentMana -= manaPenalty
			} else {
				gameState.hero.currentMana = 0
			}
			gameState.manaPointsLootToDisplay = -manaPenalty
			print("Gain some penalties")
		}
	}
	
	// MARK: - Generate Enemy (03.02.26 did increased all stats by 2 except energy count for the boss)
	
	func generateEnemy(didFinalBossSummoned: Bool) -> Enemy {
		
		// Monster name generator
		guard var enemyName = ["Skeleton",
							   "Goblin",
							   "Rat",
							   "Ghoul"].randomElement()
		else {
			return Enemy()
		}
		
		if didFinalBossSummoned { enemyName += " Elite" }
		
		// Modifer for level difficulty
		// 1 level = 0 %
		// 2 level = 5 %
		// 3 level = 10 % and so on
		
		
		// Ratio to increase all stats if it's a boss
		let bossModifier: Double = 1.5
		
		// dividing 0 by 100 is totally fine
		let difficultyLevel = Double(gameState.currentDungeonLevel * 10) / 100.0
		
		// base was 25...50
		let baseHP = Int(Double.random(in: 35...65))
		let finalHP = baseHP + Int(Double(baseHP) * difficultyLevel)
		
		// base was 10...50
		let mp = Int.random(in: 15...75)
		let finalMP = mp + Int(Double(mp) * difficultyLevel)
		
		// base was 6...8
		let minDamage = Int.random(in: 8...10)
		let finalMinDamage = minDamage + Int(Double(minDamage) * difficultyLevel)
		
		// base was 10...12
		let maxDamage = Int.random(in: 15...16)
		let finalMaxDamage = maxDamage + Int(Double(maxDamage) * difficultyLevel)
		
		let energy = 3
		let maxEnergy = 3
		
		// base was 5...10
		let spellPower = Int.random(in: 7...15)
		let finalSpellPower = spellPower + Int(Double(spellPower) * difficultyLevel)
		
		// base as 0...2
		let defence = Int.random(in: 1...3)
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
				currentEnergy: energy + 1,
				maxEnergy: maxEnergy + 1,
				minDamage: Int(Double(finalMinDamage) * bossModifier),
				maxDamage: Int(Double(finalMaxDamage) * bossModifier),
				defence: Int(Double(finalDefence) * bossModifier),
				spellPower: Int(Double(finalSpellPower) * bossModifier)
			)
		}
	}
}
