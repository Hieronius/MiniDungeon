import SwiftUI

extension MainViewModel {
	
	// MARK: endLevelAndGenerateNewOne
	
	/// If Level complete and boss has been defeated go to the next one
	func endLevelAndGenerateNewOne() {
		
		if gameState.didEndDemoLevel {
			
			generateLevelPerksAfterEndingDungeonLevelAndGoToLevelPerkScreen()
			
		} else {
			
			generateMerchantLoot()
			
			goToMerchant()
			
		}
		
		gameState.didEncounteredBoss = false
		gameState.currentDungeonLevel += 1
		
		// this condition should run only once after demo level
		if gameState.currentDungeonLevel > 1 {
			
			if !gameState.didEndDemoLevel {
				
				gameState.hero.flask.baseMaxCharges += 1
				gameState.hero.flask.currentCharges += 1
				print("add 1 charge after ending demo level once")
			}
			gameState.didEndDemoLevel = true
			
		}
		
		gameState.didHeroAppear = false
		gameState.dungeonLevelBeenExplored = false
		
		generateMap()
		spawnHero()
	}
	
	// MARK: summonBoss
	
	/// If level been completed -> summon the boss and start the fight
	func summonBoss() {
		
		gameState.didBossFightSoundEnd = false
		audioManager.playSound(fileName: "summonBoss", extensionName: "mp3")
		gameState.didEncounteredBoss = true
		gameState.enemy = generateEnemy(didFinalBossSummoned: gameState.didEncounteredBoss)
		restoreAllEnergy()
		goToBattle()
		
		// 4 flags set to false to avoid extra event activation button at the next level
		gameState.dealthWithChest = true
		gameState.dealtWithTrap = true
		gameState.dealtWithDisenchantShrine = true
		gameState.dealtWithRestorationShrine = true
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			self.gameState.didBossFightSoundEnd = true
			print(self.gameState.didBossFightSoundEnd)
			self.gameState.isCoinFlipMiniGameOn = true
			self.audioManager.playSound(fileName: "coinFlip", extensionName: "mp3")
		}
	}
	
	// MARK: - spawnHeroAtDemoLevel
	
	func spawnHeroAtDemoLevel() {
		
		print("START")
		// Predefined coordinates of farest left R tile of the demo level
		let row = 3
		let col = 0
		
		gameState.heroPosition = Coordinate(row: row, col: col)
		gameState.didHeroAppear = true
		
		gameState.dungeonMap[gameState.heroPosition.row][gameState.heroPosition.col].isExplored = true
	}

	// MARK: - spawnHero

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
				if tile.type == .room && !gameState.didHeroAppear {
					gameState.heroPosition = Coordinate(row: row, col: col)
					gameState.didHeroAppear = true
				}
			}
		}
		gameState.dungeonMap[gameState.heroPosition.row][gameState.heroPosition.col].isExplored = true
	}
	
	// MARK: generateRewardRarity
	
	/// Method to generate level of rarity of any item, talant or perk in the game
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
		
		// Test line about Loot
		gameState.lootContainerToDisplay = Loot(
			experience: 0,
			gold: 0,
			darkEnergy: 0,
			items: [],
			armors: [],
			weapons: []
		)
		
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
			checkForHeroLevelUP()
		}
		
		// In both cases check if there is enough dark energy to level up the flask and animate it to reflect to user
		checkForFlaskLevelUP()
	}
	
	// MARK: - Generate Loot
	
	/// Combine all types of items and it's chance to drop in a single method to call
	func generateLoot() {
		
		var lootContainer = Loot(experience: 0, gold: 0, darkEnergy: 0, items: [], armors: [], weapons: [])
		
		gameState.didFindLootAfterFight = true
		
		// extra keys loot
		
		if let loot = generateKeysLoot(didFinalBossSummoned: gameState.didEncounteredBoss) {
			gameState.hero.inventory[loot, default: 0] += 1
			gameState.lootToDisplay.append(loot.label)
			print("got a key in loot")
			
			// Test line to integrate Loot struct as viewModel
			lootContainer.items.append(loot)
			
			
		}
		
		// saleable loot
		
		if let loot = generateSaleableLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss
			
		) {
			gameState.hero.inventory[loot, default: 0] += 1
			gameState.lootToDisplay.append(loot.label)
			
			// Test line to integrate Loot struct as viewModel
			lootContainer.items.append(loot)
		}
		
		// potion loot
		
		if let potion = generatePotionLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss,
			of: generateRewardRarity()
		) {
			gameState.hero.inventory[potion, default: 0] += 1
			gameState.lootToDisplay.append(potion.label)
			
			// Test line to integrate Loot struct as viewModel
			lootContainer.items.append(potion)
		}
		
		// weapon loot
		
		if let weapon = generateWeaponLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss,
			of: generateRewardRarity()
		) {
			gameState.hero.weapons[weapon, default: 0] += 1
			gameState.lootToDisplay.append(weapon.label)
			
			// Test line to integrate Loot struct as viewModel
			lootContainer.weapons.append(weapon)
		}
		
		// armor loot
		
		if let armor = generateArmorLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss,
			of: generateRewardRarity()
		) {
			gameState.hero.armors[armor, default: 0] += 1
			gameState.lootToDisplay.append(armor.label)
			
			// Test line to integrate Loot struct as viewModel
			lootContainer.armors.append(armor)
		}
		
		// 100% Demo Loot Drop
		
		if gameState.battlesWon == 1 && !gameState.didEndDemoLevel {
			
			let armor = ArmorManager.commonArmors[0]
			gameState.hero.armors[armor, default: 0] += 1
			gameState.lootToDisplay.append(armor.label)
			print("Demo Armor has been droped")
			
			// Test line to integrate Loot struct as viewModel
			lootContainer.armors.append(armor)
			
		} else if gameState.battlesWon == 2 && !gameState.didEndDemoLevel {
			
			let weapon = WeaponManager.commonWeapons[1]
			gameState.hero.weapons[weapon, default: 0] += 1
			gameState.lootToDisplay.append(weapon.label)
			print("Demo Weapon has been droped")
			
			// Test line to integrate Loot struct as viewModel
			lootContainer.weapons.append(weapon)
		}
		
		// gold loot
		
		var gold = generateGoldLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss
		)
		
		// Test line to integrate Loot struct as viewModel
		lootContainer.gold = gold
		
		// Greed Perk Check
		
		if gameState.isGreedPerkActive {
			gold += calculateGreedPerkEffect(for: gold)
			
			// Test line to integrate Loot struct as viewModel
			lootContainer.gold += gold
		}
		gameState.heroGold += gold
		gameState.goldLootToDisplay = gold
		
		
		// experience loot (ignore if it's a chest loot)
		if !gameState.dealthWithChest && !gameState.didEncounterSecretRoom {
			
			var exp = generateExperienceLoot(
				didFinalBossSummoned: gameState.didEncounteredBoss
			)
			
			// Test line to integrate Loot struct as viewModel
			lootContainer.experience = exp
			
			// Greed Perk Check
			
			if gameState.isGreedPerkActive {
				exp += calculateGreedPerkEffect(for: exp)
				
				// Test line to integrate Loot struct as viewModel
				lootContainer.experience += calculateGreedPerkEffect(for: exp)
			}
			
			gameState.hero.currentXP += exp
			gameState.expLootToDisplay = exp
		}
		
		// dark energy loot
		
		var energy = generateDarkEnergyLoot(
			didFinalBossSummoned: gameState.didEncounteredBoss
		)
		
		// Test line to integrate Loot struct as viewModel
		lootContainer.darkEnergy += energy
		
		// // Greed Perk Check
		
		if gameState.isGreedPerkActive {
			energy += calculateGreedPerkEffect(for: energy)
			
			// Test line to integrate Loot struct as viewModel
			lootContainer.darkEnergy += calculateGreedPerkEffect(for: energy)
		}
		gameState.hero.flask.currentXP += energy
		gameState.heroDarkEnergy += energy
		gameState.heroMaxDarkEnergyOverall += energy
		gameState.darkEnergyLootToDisplay = energy
		gameState.lootContainerToDisplay = lootContainer
		
	}
	
	// MARK: - calculateGreedPerkEffect
	
	/// Method should calculate extra perk bonus to gold/energy/experience loot
	func calculateGreedPerkEffect(for loot: Int) -> Int {
		
		let bonusLoot = Int(Double(loot) * gameState.greedPerkEffectModifier)
		print("extra bonus loot \(bonusLoot) due to Greed Perk")
		return bonusLoot
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
			
			// In level 1,2 we can drop common weapons
		case 1,2:
			
			if rarity == .common {
				weaponLoot = WeaponManager.generateWeapon(of: .common)
			}
			
			// In level 3 we can drop rare weapons + common weapons
		case 3:
			
			if rarity == .common {
				weaponLoot = WeaponManager.generateWeapon(of: .common)
				
			} else if rarity == .rare {
				weaponLoot = WeaponManager.generateWeapon(of: .rare)
			}
			
			// In level 4 we can drop epic weapons + rare weapons + common weapons
		case 4:
			
			if rarity == .common {
				weaponLoot = WeaponManager.generateWeapon(of: .common)
				
			} else if rarity == .rare {
				weaponLoot = WeaponManager.generateWeapon(of: .rare)
				
			} else if rarity == .epic {
				weaponLoot = WeaponManager.generateWeapon(of: .epic)
			}
			
			// In level 5+ we can drop legendary + epic + rare + common weapons
			
		case 5: weaponLoot = WeaponManager.generateWeapon(of: rarity)
			
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
			
			// In level 1,2 we can drop common armors
		case 1,2:
			
			if rarity == .common {
				armorLoot = ArmorManager.generateArmor(of: .common)
			}
			
			// In level 3 we can drop rare armors + common armors
		case 3:
			
			if rarity == .common {
				armorLoot = ArmorManager.generateArmor(of: .common)
				
			} else if rarity == .rare {
				armorLoot = ArmorManager.generateArmor(of: .rare)
			}
			
			// In level 4 we can drop epic armors + rare armors + common armors
		case 4:
			
			if rarity == .common {
				armorLoot = ArmorManager.generateArmor(of: .common)
				
			} else if rarity == .rare {
				armorLoot = ArmorManager.generateArmor(of: .rare)
				
			} else if rarity == .epic {
				armorLoot = ArmorManager.generateArmor(of: .epic)
			}
			
			// In level 5+ we can drop legendary + epic + rare + common weapons
		case 5...: armorLoot = ArmorManager.generateArmor(of: rarity)
			
			
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
			
		case 1,2:
			
			if rarity == .common {
				potionLoot = ItemManager.generatePotion(of: .common)
				
			}
			
		case 3:
			
			if rarity == .common {
				potionLoot = ItemManager.generatePotion(of: .common)
				
			} else if rarity == .rare {
				potionLoot = ItemManager.generatePotion(of: .rare)
				
			}
			
		case 4:
			
			if rarity == .common {
				potionLoot = ItemManager.generatePotion(of: .common)
				
			} else if rarity == .rare {
				potionLoot = ItemManager.generatePotion(of: .rare)
				
			} else if rarity == .epic {
				potionLoot = ItemManager.generatePotion(of: .epic)
			}
			
		case 5...: potionLoot = ItemManager.generatePotion(of: rarity)
			
			
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
			
		case 1,2:
			
			if rarity == .common {
				loot = ItemManager.generateLoot(of: .common)
				
			}
			
		case 3:
			
			if rarity == .common {
				loot = ItemManager.generateLoot(of: .common)
				
			} else if rarity == .rare {
				loot = ItemManager.generateLoot(of: .rare)
				
			}
			
		case 4:
			
			if rarity == .common {
				loot = ItemManager.generateLoot(of: .common)
				
			} else if rarity == .rare {
				loot = ItemManager.generateLoot(of: .rare)
				
			} else if rarity == .epic {
				loot = ItemManager.generateLoot(of: .epic)
			}
			
			// In level 3+ we can drop legendary + epic + rare + common loot
			
		case 5...: loot = ItemManager.generateLoot(of: rarity)
			
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
		
		var expRoll = Int.random(in: 30...40)
		
		if didFinalBossSummoned { expRoll *= 2 }
		
		return expRoll
	}
	
	// MARK: - Generate Dark Energy Loot
	
	func generateDarkEnergyLoot(didFinalBossSummoned: Bool) -> Int {
		
		var energyRoll = Int.random(in: 5...10)
		
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
	///
	/// predefinedSecret mean that we wan't to set a specific room to be a secret
	/// for example if we want to implement it in demo
	func handleSecretRoomOutcome(row: Int, col: Int, predefinedSecret: Bool) {
		
		// React on user action by changing the flag
		gameState.dungeonMap[row][col].wasTapped = true
		gameState.didTappedUnknownTile = true
		gameState.tappedTilePosition = Coordinate(row: row, col: col)
		
		// change flag back to stop tile tap animation
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
			self.gameState.dungeonMap[row][col].wasTapped = false
			self.gameState.didTappedUnknownTile = false
		}
		
		let room = gameState.dungeonMap[row][col]
		
		var secretRoll = 0
		
		if predefinedSecret {
			gameState.shouldMeetPredefinedSecretRoom = false
			secretRoll = 100
		} else {
			secretRoll = Int.random(in: 1...100)
		}
		
		guard secretRoll >= 90 && !room.events.contains(.empty) else {
			gameState.dungeonMap[row][col].events.append(.empty)
			return
		}
		
		audioManager.playSound(fileName: "secretDoor", extensionName: "mp3")
		
//		gameState.dungeonMap[row][col].events = [.secret]
		gameState.dungeonMap[row][col].events.append(.secret)
		
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
	
	// MARK: - getLevelBonusesAfterHeroLevelUpAndGoToLevelBonusScreen
	
	func generateLevelBonusesAfterHeroLevelUpAndGoToLevelBonusScreen() {
		
		audioManager.playSound(fileName: "heroLevelUP", extensionName: "mp3")
		
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
	
	// MARK: - generateLevelPerksAfterEndingDungeonLevelAndGoToLevelPerkScreen
	
	func generateLevelPerksAfterEndingDungeonLevelAndGoToLevelPerkScreen() {
		
		// play audio - "you get a new perk!"
		
		// This line cleans previous perks to generate
		gameState.levelPerksToChoose = []
		
		var levelPerksSet: Set<LevelPerk> = []
		
		// Generate level of raririty -> ask LevelPerkManager to provide a random bonus accordingly to the rarity
		// Add this bonus to levelPerksToChoose
		while levelPerksSet.count < 3 {
			
			var counter = 0
			let rarity = generateRewardRarity()
			guard let perk = LevelPerkManager.generateLevelPerk(of: rarity) else {
				return
			}
			levelPerksSet.insert(perk)
			counter += 1
			
		}
		gameState.levelPerksToChoose = Array(levelPerksSet)
		goToLevelPerk()
	}
	
	// MARK: - generateLevelBonusesAfterFlaskLevelUpAndGoToLevelBonusScreen
	
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
		
		// MARK: if Demo Level cut all stats by gameState.demoLevelEnemyPowerRatio
		
		// base was 25...50
		let baseHP = Int(Double.random(in: 35...65))
		
		var finalHP = 0
		
		if gameState.didEndDemoLevel {
			finalHP = baseHP + Int(Double(baseHP) * difficultyLevel)
		} else {
			finalHP = Int((Double(baseHP) + Double(baseHP) * difficultyLevel) * gameState.demoLevelEnemyPowerRatio)
		}
			
		
		
		// base was 10...50
		let baseMP = Int.random(in: 15...35)
		
		var finalMP = 0
		
		if gameState.didEndDemoLevel {
			finalMP = baseMP + Int(Double(baseMP) * difficultyLevel)
		} else {
			finalMP = Int((Double(baseMP) + Double(baseMP) * difficultyLevel) * gameState.demoLevelEnemyPowerRatio)
		}
		
		// base was 6...8
		let minDamage = Int.random(in: 8...10)
		
		var finalMinDamage = 0
		
		if gameState.didEndDemoLevel {
			finalMinDamage = minDamage + Int(Double(minDamage) * difficultyLevel)
		} else {
			finalMinDamage = Int((Double(minDamage) + Double(minDamage) * difficultyLevel) * gameState.demoLevelEnemyPowerRatio)
		}
		
		// base was 10...12
		let maxDamage = Int.random(in: 15...16)
		
		var finalMaxDamage = 0
		
		if gameState.didEndDemoLevel {
			finalMaxDamage = maxDamage + Int(Double(maxDamage) * difficultyLevel)
		} else {
			finalMaxDamage = Int((Double(maxDamage) + Double(maxDamage) * difficultyLevel) * gameState.demoLevelEnemyPowerRatio)
		}
		
		let energy = 3
		let maxEnergy = 3
		
		// base was 5...10
		let spellPower = Int.random(in: 7...15)
		
		var finalSpellPower = 0
		
		if gameState.didEndDemoLevel {
			finalSpellPower = spellPower + Int(Double(spellPower) * difficultyLevel)
		} else {
			finalSpellPower = Int((Double(spellPower) + Double(spellPower) * difficultyLevel) * gameState.demoLevelEnemyPowerRatio)
		}
		
		// base as 0...2
		let defence = Int.random(in: 1...3)
		
		var finalDefence = 0
		
		if gameState.didEndDemoLevel {
			finalDefence = defence + Int(Double(defence) * difficultyLevel)
		} else {
			finalDefence = Int((Double(defence) + Double(defence) * difficultyLevel) * gameState.demoLevelEnemyPowerRatio)
		}
		
		if !didFinalBossSummoned {
			
			return Enemy(
				name: enemyName,
				currentHP: finalHP,
				maxHP: finalHP,
				currentMP: finalMP,
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
				isBoss: true,
				currentHP: Int(Double(finalHP) * bossModifier),
				maxHP: Int(Double(finalHP) * bossModifier),
				currentMP: Int(Double(finalMP) * bossModifier),
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
