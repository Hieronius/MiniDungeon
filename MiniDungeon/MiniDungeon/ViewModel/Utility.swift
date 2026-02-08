import SwiftUI

// MARK: - Utility

extension MainViewModel {
	
	// flaskBeingTapped.toggle()
	
	// MARK: - endHeroAndEnemyAnimation
	
	func endHeroAndEnemyAnimation() {
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			self.gameState.currentHeroAnimation = .none
			self.gameState.currentEnemyAnimation = .none
		}
	}
	
	// MARK: - endHeroTurn
	
	func endHeroTurn() {
		
		guard gameState.enemy.enemyCurrentHP > 0 else { return }
		
		if gameState.isHeroTurn {
			
			gameState.didUserPressedEndTurnButton = true
			gameState.isHeroTurn = false
			restoreAllEnergy()
			
			if gameState.didEnemyUseBlock {
				endEnemyBlockEffect()
			}
			gameState.logMessage = "Now is Enemy Turn"
			
		}
		enemyTurn()
	}
	
	// MARK: - enemyTurn
	
	func enemyTurn() {
		
		if !gameState.isHeroTurn {
			
			guard gameState.enemy.currentEnergy > 0 else {
				
				// tell to the game that user again can press the button endTurn
				gameState.didUserPressedEndTurnButton = false
				
				// If enemy spent all his energy -> pass turn to hero
				gameState.isHeroTurn = true
				
				// If flask on CD deduct it by 1
				// put here so when flask is 1 turn until cd hero still will be able to get bonuses such as armor or damage
				
				if gameState.hero.flask.actionsToResetCD > 0 {
					gameState.hero.flask.actionsToResetCD -= 1
				}
				
				if gameState.didHeroUseBlock {
					endHeroBlockEffect()
				}
				
				restoreAllEnergy()
				DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
					self.gameState.logMessage = "Now is Hero Turn"
				}
				return
			}
			
			// A delay to create feeling the enemy does attacks with a little delays and not instant
			
			let extraActionDelay = 1.0 + Double(gameState.enemy.currentEnergy) / 5.0
			
			DispatchQueue.main.asyncAfter(deadline: .now() + extraActionDelay) {
				
				// Calculate current enemy hp in %
				let enemyMaxHealthInPercent = Double(self.gameState.enemy.enemyMaxHP) / 100.0
				let currentHealthInPercent = Double(self.gameState.enemy.enemyCurrentHP) / enemyMaxHealthInPercent
				
				// if enemy has less than 30% hp add heal/block as actions to choose between
				if currentHealthInPercent <= 30.0 {
					
					// 1 - 100 equal to part of 100% of the chance to get a specific action
					let chance = Int.random(in: 1...100)
					
					switch chance {
						
						// 15% for healing ability
					case 1...15:
						self.heal()
						
						// 15% for block ability
					case 16...30:
						self.block()
						
						// 70% for attack ability
					default:
						self.continueAttackAfterMiniGame(success: false)
					}
					self.enemyTurn()
					
				} else {
					
					self.continueAttackAfterMiniGame(success: false)
					self.enemyTurn()
				}
				
			}
			
		}
	}
	
	// MARK: endHeroBlockEffect
	
	/// Method to deactivate hero's block effect
	func endHeroBlockEffect() {
		
		gameState.didHeroUseBlock = false
		gameState.hero.baseDefence -= gameState.heroBlockValueBuffer
		
		// May be i don't need to set this value to 0 because it will be replaced anyway
		gameState.heroBlockValueBuffer = 0
		gameState.logMessage = "Hero Block Ability has been removed"
	}
	
	// MARK: endEnemyBlockEffect
	
	/// Method to deactivate enemy's block effect
	func endEnemyBlockEffect() {
		
		gameState.didEnemyUseBlock = false
		gameState.enemy.defence -= gameState.enemyBlockValueBuffer
		
		// May be i don't need to set this value to 0 because it will be replaced anyway
		gameState.enemyBlockValueBuffer = 0
		gameState.logMessage = "Enemy Block Ability has been removed"
	}
	
	// MARK: restoreAllEnergy
	
	func restoreAllEnergy() {
		
		gameState.isHeroTurn ?
		(gameState.hero.currentEnergy = gameState.hero.maxEnergy) :
		(gameState.enemy.currentEnergy = gameState.enemy.maxEnergy)
	}
	
	// MARK: restoreEnemyEnergy
	
	func restoreEnemyEnergy() {
		gameState.enemy.currentEnergy = gameState.enemy.maxEnergy
	}
	
	// MARK: restoreEnemyHP
	
	func restoreEnemyHP() {
		gameState.enemy.enemyCurrentHP = gameState.enemy.enemyMaxHP
	}
	
	// MARK: restoreHP
	
	func restoreHP() {
		
		gameState.hero.currentHP = gameState.hero.maxHP
		gameState.enemy.enemyCurrentHP = gameState.enemy.enemyMaxHP
	}
	
	// MARK: restoreMana
	
	func restoreMana() {
		
		gameState.hero.currentMana = gameState.hero.maxMana
		gameState.enemy.currentMana = gameState.enemy.maxMana
	}
	
	// MARK: restoreStats
	
	func restoreStats() {
		
		restoreHP()
		restoreMana()
		restoreAllEnergy()
	}
	
	// MARK: toggleCurrentSoulCollectionStatus
	
	func toggleCurrentSoulCollectionStatus() {
		
		if gameState.hero.flask.currentSoulCollectionStatus == .soulCollector {
			
			gameState.hero.flask.currentSoulCollectionStatus = .soulExtractor
			gameState.hero.flask.baseCombatImpactCapacity = 100
			
		} else if gameState.hero.flask.currentSoulCollectionStatus == .soulExtractor {
			
			gameState.hero.flask.currentSoulCollectionStatus = .soulEater
			gameState.hero.flask.baseCombatImpactCapacity = 150
			
		} else if gameState.hero.flask.currentSoulCollectionStatus == .soulEater {
			
			gameState.hero.flask.currentSoulCollectionStatus = .soulCollector
			gameState.hero.flask.baseCombatImpactCapacity = 50
		}
		
		print("current soul collection status - \(gameState.hero.flask.currentSoulCollectionStatus)")
	}
	
	// MARK: refillSoulCollection
	
	func refillSoulCollection() {
		
		gameState.hero.flask.flaskIsReadyToUnleashImpact = true
		
		gameState.hero.flask.currentCombatImpactValue = gameState.hero.flask.currentCombatImpactCapacity
		print("Soul Collection has been refilled with \(gameState.hero.flask.currentCombatImpactValue)")
	}
	
	// MARK: winLoseCondition
	
	/// If enemy is dead -> collect rewards and move on
	/// Otherwise go to the start screen, lose everything except dark energy
	func winLoseCondition() {
		
		if gameState.hero.currentHP <= 0 {
			print("The End")
			setupNewGame()
			
		} else if gameState.enemy.enemyCurrentHP <= 0 &&
					!gameState.didEncounteredBoss {
			print("Average Enemy has been defeated!")
			
			gameState.didUserPressedEndTurnButton = false
			gameState.didEncounterEnemy = false
			gameState.didEnemyUseBlock = false
			
			if gameState.didHeroUseBlock {
				endHeroBlockEffect()
			}
			// TODO: Put to a single method
			generateLoot()
			getRewardAfterFight()
			goToRewards()
			gameState.comboPoints = 0
			gameState.hero.flask.flaskIsReadyToUnleashImpact = false
			gameState.hero.flask.currentCombatImpactValue = 0
			gameState.didUseFlaskEmpowerForDefensive = false
			gameState.didUseFlaskEmpowerForOffensive = false
			
			if gameState.hero.flask.actionsToResetCD > 0 {
				gameState.hero.flask.actionsToResetCD -= 1
			}
			
			
		} else if gameState.enemy.enemyCurrentHP <= 0 &&
					gameState.didEncounteredBoss {
			
			// TODO: Put to a single method
			generateLoot()
			getRewardAfterFight()
			goToRewards()
			gameState.comboPoints = 0
			gameState.hero.flask.currentCombatImpactValue = 0
			gameState.hero.flask.flaskIsReadyToUnleashImpact = false
			gameState.didUseFlaskEmpowerForDefensive = false
			gameState.didUseFlaskEmpowerForOffensive = false
			gameState.didUserPressedEndTurnButton = false
			
			if gameState.hero.flask.actionsToResetCD > 0 {
				gameState.hero.flask.actionsToResetCD -= 1
			}
		}
		gameState.isCombatMiniGameIsOn = false
	}
	
	// MARK: getRewardAfterFight
	
	func getRewardAfterFight() {
		
		gameState.battlesWon += 1
	}
	
	// MARK: - checkForFlaskLevelUP
	
	func checkForFlaskLevelUP() {
		
		if gameState.hero.flask.currentXP >= gameState.hero.flask.expToLevelUP {
			
			gameState.hero.flask.currentComment = .readyForLevelUP
			gameState.didFlaskGetLevelUP = true
			gameState.hero.flask.cleanFlaskComment()
		}
	}
	
	// MARK: - checkForLevelUP
	
	func checkForLevelUP() {
		
		if  gameState.hero.currentXP >= gameState.hero.maxXP {
			
			generateLevelBonusesAfterHeroLevelUpAndGoToLevelBonusScreen()
			gameState.hero.currentXP = 0
			gameState.hero.maxXP += 50
			
		}
	}
	
	// MARK: - Buy/Sell Item
	
	/// If we did buy or sell successfully -> return true to make itemToDisplay property empty
	func buyOrSellItem(onSale: Bool, item: (any ItemProtocol)?) -> Bool {
		
		guard let itemToDisplay = item else { return false }
		
		switch itemToDisplay.itemType {
			
		case .weapon:
			
			guard let weapon = itemToDisplay as? Weapon else { return false }
			
			if onSale {
				
				if weapon != gameState.hero.weaponSlot {
					
					if gameState.hero.weapons[weapon] ?? 0 > 0 {
						gameState.hero.weapons[weapon]! -= 1
						// When you sell an item you get only 25% of it's value
						gameState.heroGold += weapon.price / 4
						gameState.merchantWeaponsLoot[weapon, default: 0] += 1
						
						if gameState.hero.weapons[weapon]! == 0 {
							gameState.hero.weapons[weapon] = nil
						}
					}
				} else {
					
					gameState.heroGold += weapon.price / 4
					gameState.merchantWeaponsLoot[weapon, default: 0] += 1
					gameState.hero.weaponSlot = nil
				}
				
			} else {
				
				if weapon.price <= gameState.heroGold &&
					gameState.merchantWeaponsLoot[weapon] ?? 0 > 0 {
					
					gameState.merchantWeaponsLoot[weapon]! -= 1
					gameState.hero.weapons[weapon, default: 0] += 1
					gameState.heroGold -= weapon.price
					
					if gameState.merchantWeaponsLoot[weapon]! == 0 {
						gameState.merchantWeaponsLoot[weapon] = nil
					}
				}
			}
			return true
			
		case .armor:
			
			guard let armor = itemToDisplay as? Armor else { return false }
			
			if onSale {
				
				if gameState.hero.armorSlot != armor {
					
					if gameState.hero.armors[armor] ?? 0 > 0 {
						gameState.hero.armors[armor]! -= 1
						// When you sell an item you get only 25% of it's value
						gameState.heroGold += armor.price / 4
						gameState.merchantArmorsLoot[armor, default: 0] += 1
						
						if gameState.hero.armors[armor]! == 0 {
							gameState.hero.armors[armor] = nil
						}
					}
					
				} else {
					
					gameState.merchantArmorsLoot[armor, default: 0] += 1
					gameState.heroGold += armor.price / 4
					gameState.hero.armorSlot = nil
				}
				
			} else {
				
				if armor.price <= gameState.heroGold &&
					gameState.merchantArmorsLoot[armor] ?? 0 > 0  {
					
					gameState.merchantArmorsLoot[armor]! -= 1
					gameState.hero.armors[armor, default: 0] += 1
					gameState.heroGold -= armor.price
					
					if gameState.merchantArmorsLoot[armor]! == 0 {
						gameState.merchantArmorsLoot[armor] = nil
					}
				}
			}
			
			return true
			
		case .potion:
			
			guard let potion = itemToDisplay as? Item else { return false }
			
			if onSale {
				
				if gameState.hero.inventory[potion] ?? 0 > 0 {
					gameState.hero.inventory[potion]! -= 1
					// When you sell an item you get only 25% of it's value
					gameState.heroGold += potion.price / 4
					gameState.merchantInventoryLoot[potion, default: 0] += 1
					
					if gameState.hero.inventory[potion]! == 0 {
						gameState.hero.inventory[potion] = nil
					}
					print(gameState.hero.inventory[potion] ?? 0)
				}
				
			} else {
				
				if potion.price <= gameState.heroGold &&
					gameState.merchantInventoryLoot[potion] ?? 0 > 0 {
					
					gameState.merchantInventoryLoot[potion]! -= 1
					gameState.hero.inventory[potion, default: 0] += 1
					gameState.heroGold -= potion.price
					
					if gameState.merchantInventoryLoot[potion]! == 0 {
						gameState.merchantInventoryLoot[potion] = nil
					}
				}
			}
			
			return true
			
		case .loot:
			
			guard let loot = itemToDisplay as? Item else { return false }
			
			if onSale {
				
				if gameState.hero.inventory[loot] ?? 0 > 0 {
					gameState.hero.inventory[loot]! -= 1
					// When you sell an item you get only 25% of it's value
					gameState.heroGold += loot.price / 4
					gameState.merchantInventoryLoot[loot, default: 0] += 1
					
					if gameState.hero.inventory[loot]! == 0 {
						gameState.hero.inventory[loot] = nil
					}
				}
				
			} else {
				
				if loot.price <= gameState.heroGold &&
					gameState.merchantInventoryLoot[loot] ?? 0 > 0 {
					
					gameState.merchantInventoryLoot[loot]! -= 1
					gameState.hero.inventory[loot, default: 0] += 1
					gameState.heroGold -= loot.price
					
					if gameState.merchantInventoryLoot[loot]! == 0 {
						gameState.merchantInventoryLoot[loot] = nil
					}
				}
			}
			
			return true
		}
	}
	
	// MARK: - compareSelectedItemWithEquipedOne
	
	func compareSelectedItemWithEquipedOne(_ selectedItem: (any ItemProtocol)?) -> [(String, Color)] {
		
		 var statsResult: [(String, Color)] = []

		// MARK: Weapon Stats Comparison
		
		if selectedItem is Weapon {
			
			let selectedWeapon = selectedItem as! Weapon
			
			// If there is a weapon equiped do your comparison, otherwise end this
			
			let equipedWeapon = gameState.hero.weaponSlot
			
			// min damage
			
			let minDamageDif = selectedWeapon.minDamage - (equipedWeapon?.minDamage ?? 0)
			
			let minDamageDifString = "min damage: "
			let minDamageStatsDifference = checkStatDifferenceAndCompileAsString(minDamageDifString, minDamageDif)
			
			statsResult.append(minDamageStatsDifference)
			
			// max damage
			
			let maxDamageDif = selectedWeapon.maxDamage - (equipedWeapon?.maxDamage ?? 0)
			
			let maxDamageDifString = "max damage: "
			let maxDamageStatsDifference =  checkStatDifferenceAndCompileAsString(maxDamageDifString, maxDamageDif)
			statsResult.append(maxDamageStatsDifference)
			
			// crit ratio
			
			let critRatioDif = selectedWeapon.critChance - (equipedWeapon?.critChance ?? 0)
			
			let critRatioDifString = "crit chance %: "
			let critRatioStatsDifference =  checkStatDifferenceAndCompileAsString(critRatioDifString, critRatioDif)
			statsResult.append(critRatioStatsDifference)
			
			// hit ratio
			
			let hitRatioDif = selectedWeapon.hitChance - (equipedWeapon?.hitChance ?? 0)
			
			let hitRatioDifString = "hit chance %: "
			let hitRatioStatsDifference = checkStatDifferenceAndCompileAsString(hitRatioDifString, hitRatioDif)
			statsResult.append(hitRatioStatsDifference)
			
		// MARK: Armor Stats Comparison
			
		} else if selectedItem is Armor {
			
			let selectedArmor = selectedItem as! Armor
			
			// if there is an armor equiped do your comparison, otherwise end this
			
//			guard let equipedArmor = gameState.hero.armorSlot else { return [] }
			let equipedArmor = gameState.hero.armorSlot
			
			// hp bonus
			
			let hpBonusDif = selectedArmor.healthBonus - (equipedArmor?.healthBonus ?? 0)
			
			let hpDifString = "health: "
			let hpStatsDifference =  checkStatDifferenceAndCompileAsString(hpDifString, hpBonusDif)
			statsResult.append(hpStatsDifference)
			
			// mp bonus
			
			let mpBonusDif = selectedArmor.manaBonus - (equipedArmor?.manaBonus ?? 0)
			
			let mpBonusDifString = "mana: "
			let mpBonusStatsDifference = checkStatDifferenceAndCompileAsString(mpBonusDifString, mpBonusDif)
			statsResult.append(mpBonusStatsDifference)
			
			// energy bonus
			
			let energyDif = selectedArmor.energyBonus - (equipedArmor?.energyBonus ?? 0)
			
			let energyDifString = "energy: "
			let energyStatsDifference = checkStatDifferenceAndCompileAsString(energyDifString, energyDif)
			statsResult.append(energyStatsDifference)
			
			// defence bonus
			
			let defenceDif = selectedArmor.defence - (equipedArmor?.defence ?? 0)
			
			let defenceDifString = "defence: "
			let defenceStatsDifference = checkStatDifferenceAndCompileAsString(defenceDifString, defenceDif)
			statsResult.append(defenceStatsDifference)
			
			// crit bonus
			
			let critRatioDif = selectedArmor.critChanceBonus - (equipedArmor?.critChanceBonus ?? 0)
			
			let critRatioDifString = "crit chance %: "
			let critRatioStatsDifference = checkStatDifferenceAndCompileAsString(critRatioDifString, critRatioDif)
			statsResult.append(critRatioStatsDifference)
			
			// hit bonus
			
			let hitBonusDif = selectedArmor.hitChanceBonus - (equipedArmor?.hitChanceBonus ?? 0)
			
			let hitBonusDifString = "hit chance %: "
			let hitBonusStatsDifference = checkStatDifferenceAndCompileAsString(hitBonusDifString, hitBonusDif)
			statsResult.append(hitBonusStatsDifference)
			
			// spellpower bonus
			
			let spellPowerDif = selectedArmor.spellPowerBonus - (equipedArmor?.spellPowerBonus ?? 0)
			
			let spellPowerDifString = "spell power: "
			let spellPowerStatsDifference = checkStatDifferenceAndCompileAsString(spellPowerDifString, spellPowerDif)
			statsResult.append(spellPowerStatsDifference)
			
		} else if selectedItem is Item { return [] }
		
		return statsResult
	}
	
	// MARK: - checkStatDifferenceAndCompileAsStringColorTuple
	
	func checkStatDifferenceAndCompileAsString(_ string: String, _ impact: Int) -> (String, Color) {
		
		var stringResult = string
		var colorResult = Color.white
		
		switch impact {
			
			// if == 0 it's mean we have no diff in items -> just ignore or print empty or gray color
			
		case 0:
			stringResult += "0"
			
			// if we have negative difference it's mean we lost some of stats -> deduct impact and try to make it as red color
			
		case ..<0:
			stringResult += "\(impact)"
			colorResult = .red
			
			// if we have position difference it's mean we get some bonus -> add impact and try to make it of green color
			
		case 1...:
			stringResult += "+\(impact)"
			colorResult = .green
			
		default:
			fatalError("Critical Error with calculation of items difference")
		}
		return (stringResult, colorResult)
	}
	
	// MARK: - cquipOrUseItem
	
	/// If it's a weapon or armor - equip it, otherwise use the item if possible
	func equipOrUseItem(_ item: (any ItemProtocol)?) -> Bool {
		
		guard let itemToDisplay = item else { return false }
		
		switch itemToDisplay.itemType {
			
		case .weapon:
			
			guard let weapon = itemToDisplay as? Weapon else { return false }
			
			equipWeapon(weapon)
			return true
			
		case .armor:
			
			guard let armor = itemToDisplay as? Armor else { return false }
			
			equipArmor(armor)
			return true
			
		case .potion:
			
			guard let potion = itemToDisplay as? Item else { return false }
			
			usePotion(potion)
			return true
			
		case .loot:
			return false
		}
	}
	
	// MARK: - equipWeapon
	
	func equipWeapon(_ weapon: Weapon) {
		
		// If there is a weapon currently equipped, return it to inventory count
		if let currentWeapon = gameState.hero.weaponSlot {
			gameState.hero.weapons[currentWeapon, default: 0] += 1
		}

		// Equip the new weapon
//		gameState.hero.weaponSlot = weapon
		gameState.hero.equipWeapon(weapon)

		// Decrement the count of the new weapon in inventory if present and count > 0
		if let currentCount = gameState.hero.weapons[weapon], currentCount > 0 {
			gameState.hero.weapons[weapon]! = currentCount - 1
			
			if gameState.hero.weapons[weapon]! == 0 {
				gameState.hero.weapons[weapon] = nil
			}
		}
	}
	
	// MARK: - equipArmor
	
	func equipArmor(_ armor: Armor) {
		
		// If there is a Armor currently equipped, return it to inventory count
		if let currentArmor = gameState.hero.armorSlot {
			gameState.hero.armors[currentArmor, default: 0] += 1
		}

		// Equip the new armor
//		gameState.hero.armorSlot = armor
		gameState.hero.equipArmor(armor)

		// Decrement the count of the new armor in inventory if present and count > 0
		if let currentCount = gameState.hero.armors[armor], currentCount > 0 {
			gameState.hero.armors[armor]! = currentCount - 1
			
			if gameState.hero.armors[armor]! == 0 {
				gameState.hero.armors[armor] = nil
			}
		}
		print(gameState.hero.armors.count)
	}
	
	// MARK: - displayKeys
	
	/// A simple method to reflect how many keys hero have
	func displayKeys() -> Int {
		
		let key = ItemManager.returnKeyItem()
		
		guard gameState.hero.inventory[key] != nil else { return 0 }
		return gameState.hero.inventory[key]!
	}
	
	// MARK: - usePotion
	
	func usePotion(_ potion: Item) {
		
		if gameState.hero.inventory[potion] != nil {
			if gameState.hero.inventory[potion]! > 0 {
				gameState.hero.inventory[potion]! -= 1
				
				if gameState.hero.inventory[potion]! == 0 {
					gameState.hero.inventory[potion] = nil
				}
			}
		}
		
		switch potion.label {
			
			// MARK:  Common Potions Effect
			
		case "Small Health Restoration Potion":
			
			// Heals by 10% of max HP
			let heal = Int(Double(gameState.hero.maxHP) / 10.0)
			if gameState.hero.currentHP + heal <= gameState.hero.maxHP {
				gameState.hero.currentHP += heal
			} else {
				gameState.hero.currentHP = gameState.hero.maxHP
			}
			
		case "Small Mana Restoration Potion":
			
			// Restores mana by 10% of maximum MP
			let manaRegen = Int(Double(gameState.hero.maxMana) / 10.0)
			if gameState.hero.currentMana + manaRegen <= gameState.hero.maxMana {
				gameState.hero.currentMana += manaRegen
			} else {
				gameState.hero.currentMana = gameState.hero.maxMana
			}
			
		case "Small Energy Restoration Potion":
			
			// Restores current ENERGY by 1
			let energyRegen = 1
			if gameState.hero.currentEnergy + energyRegen <= gameState.hero.maxEnergy {
				gameState.hero.currentEnergy += energyRegen
			} else {
				gameState.hero.currentEnergy = gameState.hero.maxEnergy
			}
			
			// MARK: - Rare Potions Effect
			
		case "Health Restoration Potion":
			
			// Heals by 25% of max HP
			let heal = Int(Double(gameState.hero.maxHP) / 4.0)
			if gameState.hero.currentHP + heal <= gameState.hero.maxHP {
				gameState.hero.currentHP += heal
			} else {
				gameState.hero.currentHP = gameState.hero.maxHP
			}
			
		case "Mana Restoration Potion":
			
			// Restores mana by 25% of maximum MP
			let manaRegen = Int(Double(gameState.hero.maxMana) / 4.0)
			if gameState.hero.currentMana + manaRegen <= gameState.hero.maxMana {
				gameState.hero.currentMana += manaRegen
			} else {
				gameState.hero.currentMana = gameState.hero.maxMana
			}
			
		case "Small Health Pool Elixir":
			
			// +5 current HP, +5 max HP
			let effect = 5
			gameState.hero.baseMaxHP += effect
			gameState.hero.currentHP += effect
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
		case "Small Mana Pool Elixir":
			
			// +5 current MP, +5 max MP
			let effect = 5
			gameState.hero.baseMaxMP += effect
			gameState.hero.currentMana += effect
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
		case "Small Wolf Tonic":
			
			// +1 min damage
			let effect = 1
			gameState.hero.baseMinDamage += effect
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
		case "Small Bear Tonic":
			
			// +1 max damage
			let effect = 1
			gameState.hero.baseMaxDamage += effect
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
			
		case "Small Fox Tonic":
			
			// +1% crit chance
			let effect = 1
			gameState.hero.baseCritChance += effect
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
		case "Small Owl Tonic":
			
			// +1 spell power
			let effect = 1
			gameState.hero.baseSpellPower += effect
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
		case "Small Iguana Tonic":
			
			// +1% hit chance
			let effect = 1
			gameState.hero.baseHitChance += effect
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
			// MARK: Epic Potions
			
		case "Huge Health Restoration Potion":
			
			// Heals by 35% of max health
			let heal = Int(Double(gameState.hero.maxHP) / 3.33)
			if gameState.hero.currentHP + heal <= gameState.hero.maxHP {
				gameState.hero.currentHP += heal
			} else {
				gameState.hero.currentHP = gameState.hero.maxHP
			}
			
		case "Huge Mana Restoration Potion":
			
			// "Restores mana by 35% of it's max capacity"
			let manaRegen = Int(Double(gameState.hero.maxMana) / 3.33)
			if gameState.hero.currentMana + manaRegen <= gameState.hero.maxMana {
				gameState.hero.currentMana += manaRegen
			} else {
				gameState.hero.currentMana = gameState.hero.maxMana
			}
			
		case "Elixir of Strength":
			
			// +1 min damage, +1 max damage
			let minDamageEffect = 1
			let maxDamageEffect = 1
			gameState.hero.baseMinDamage += minDamageEffect
			gameState.hero.baseMaxDamage += maxDamageEffect
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
		case "Huge Elixir of Tortoise":
			
			// +20 health, -1% hit chance
			let healthBonusEffect = 20
			let hitChanceBonusEffect = -1
			gameState.hero.baseMaxHP += healthBonusEffect
			gameState.hero.baseHitChance += hitChanceBonusEffect
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
		case "Huge Elixir of Wisdom":
			
			// +3 spell power, -1 max damage
			let spellPowerBonusEffect = 3
			let maxDamageBonusEffect = 1
			gameState.hero.baseSpellPower += spellPowerBonusEffect
			gameState.hero.baseMaxDamage += maxDamageBonusEffect
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
		case "Huge Elixir of Boldness":
			
			// +3% crit chance, -20 health, -20 mana
			let critChanceBonusEffect = 3
			let healthBonusEffect = -20
			let manaBonusEffect = -20
			gameState.hero.baseCritChance += critChanceBonusEffect
			gameState.hero.baseMaxHP += healthBonusEffect
			gameState.hero.baseMaxMP += manaBonusEffect
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
		case "Huge Elixir of Accuracy":
			
			// +3% hit chance, -1 armor, -1 spell power
			let hitChanceBonusEffect = 3
			let armorBonusEffect = 1
			let spellPowerBonusEffect = 1
			gameState.hero.baseHitChance += hitChanceBonusEffect
			gameState.hero.baseDefence += armorBonusEffect
			gameState.hero.baseSpellPower += spellPowerBonusEffect
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
		case "Legendary Potion of Energy":
			
			// +1 ENERGY
			let energyBonus = 1
			gameState.hero.baseMaxEP += energyBonus
			gameState.hero.currentEnergy = gameState.hero.baseMaxEP
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
		case "Legendary Potion of Strength":
			
			// +2 min damage, +2 max damage, +1% hit chance, +1% crit chance
			let minDamageBonusEffect = 2
			let maxDamageBonusEffect = 2
			let hitChanceBonusEffect = 1
			let critChanceBonusEffect = 1
			gameState.hero.baseMinDamage += minDamageBonusEffect
			gameState.hero.baseMaxDamage += maxDamageBonusEffect
			gameState.hero.baseHitChance += hitChanceBonusEffect
			gameState.hero.baseCritChance += critChanceBonusEffect
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
		case "Corrupted Elixir of Agility":
			
			// +5% crit chance, -2% hit chance, -30 health, -30 mana
			let critBonusEffect = 5
			let hitChanceBonusEffect = -2
			let healthBonusEffect = -30
			let manaBonusEffect = -30
			gameState.hero.baseCritChance += critBonusEffect
			gameState.hero.baseHitChance += hitChanceBonusEffect
			gameState.hero.baseMaxHP += healthBonusEffect
			gameState.hero.baseMaxMP += manaBonusEffect
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
		case "Corrupted Elixir of Wisdom":
			
			// +5 spell power, +30 mana, -2% crit chance, -30 health
			let spellPowerBonusEffect = 5
			let manaBonusEffect = 30
			let critChanceBonusEffect = -2
			let healthBonusEffect = -30
			gameState.hero.baseSpellPower += spellPowerBonusEffect
			gameState.hero.baseMaxMP += manaBonusEffect
			gameState.hero.baseCritChance += critChanceBonusEffect
			gameState.hero.baseMaxHP += healthBonusEffect
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
		case "Corrupted Elixir of Behemoth":
			
			// +3 Defence, +50 health, -1% crit chance, -1% hit chance, -30 mana, -3 spell power
			let defenceBonusEffect = 3
			let healthBonusEffect = 50
			let critChanceBonusEffect = 1
			let manaBonusEffect = -30
			let spellPowerBonusEffect = -3
			gameState.hero.baseDefence += defenceBonusEffect
			gameState.hero.baseMaxHP += healthBonusEffect
			gameState.hero.baseCritChance += critChanceBonusEffect
			gameState.hero.baseMaxMP += manaBonusEffect
			gameState.hero.baseSpellPower += spellPowerBonusEffect
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
		case "Corrupted Elixir of Focus":
			
			// +5% hit chance, -1% crit chance, -20 health, -1 defence, -20 mana, -1 spell power
			let hitChanceBonusEffect = 5
			let critChanceBonusEffect = -1
			let healthBonusEffect = -20
			let defenceBonusEffect = -1
			let manaBonusEffect = -20
			let spellPowerEffect = -1
			gameState.hero.baseHitChance += hitChanceBonusEffect
			gameState.hero.baseCritChance += critChanceBonusEffect
			gameState.hero.baseMaxHP += healthBonusEffect
			gameState.hero.baseDefence += defenceBonusEffect
			gameState.hero.baseMaxMP += manaBonusEffect
			gameState.hero.baseSpellPower += spellPowerEffect
			gameState.usedPotionsWithPermanentEffects.append(potion)
			
		default: return
		}
	}
}
