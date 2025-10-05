import SwiftUI

// MARK: - Utility

extension MainViewModel {
	
	// MARK: endHeroTurn
	
	func endHeroTurn() {
		
		if gameState.isHeroTurn {
			gameState.isHeroTurn = false
			restoreAllEnergy()
			
			if gameState.didEnemyUseBlock {
				endEnemyBlockEffect()
			}
			gameState.logMessage = "Now is Enemy Turn"
			print("Now is Enemy Turn")
			
		}
		
		enemyTurn()
	}
	
	// MARK: enemyTurn
	
	func enemyTurn() {
		
		if !gameState.isHeroTurn {
			
			guard gameState.enemy.currentEnergy > 0 else {
				gameState.isHeroTurn = true
				
				if gameState.didHeroUseBlock {
					endHeroBlockEffect()
				}
				
				restoreAllEnergy()
				gameState.logMessage = "Now is Hero Turn"
				print("Now is Hero Turn")
				return
			}
			
			let extraActionDelay = 0.5 + Double(gameState.enemy.currentEnergy) / 5.0
			
			DispatchQueue.main.asyncAfter(deadline: .now() + extraActionDelay) {
				
				// Calculate current enemy hp in %
				let enemyMaxHealthInPercent = Double(self.gameState.enemy.enemyMaxHP) / 100.0
				let currentHealthInPercent = Double(self.gameState.enemy.enemyCurrentHP) / enemyMaxHealthInPercent
				
				// if enemy has less than 30% hp add heal/block as actions to choose between
				if currentHealthInPercent <= 30.0 {
					print("Enemy has 30% hp and less -> Special Move will be calculated")
					
					// 1 - 100 equal to part of 100% of the chance to get a specific action
					let chance = Int.random(in: 1...100)
					
					switch chance {
						
						// 15% for healing ability
					case 1...15:
						self.heal()
						print("Enemy used Healing Ability")
						
						// 15% for block ability
					case 16...30:
						self.block()
						print("Enemy used Block Ability!")
						
						// 70% for attack ability
					default:
						self.continueAttackAfterMiniGame(success: false)
						print("Enemy Attack!")
					}
					self.enemyTurn()
					
					// If more than 30% of hp just use attack
				} else {
					
					print("Enemy has more than 30% of hp -> Normal Move will be calculated")
					self.continueAttackAfterMiniGame(success: false)
					print("Enemy Attack!")
					self.enemyTurn()
				}
				
			}
			
		}
	}
	
	// MARK: endHeroBlockEffects
	
	func endHeroBlockEffect() {
		
		gameState.didHeroUseBlock = false
		gameState.hero.baseDefence -= gameState.blockValue
		gameState.logMessage = "Hero Block Ability has been removed"
		print("Hero Block Ability has been removed")
	}
	
	func endEnemyBlockEffect() {
		
		gameState.didEnemyUseBlock = false
		gameState.enemy.defence -= gameState.blockValue
		gameState.logMessage = "Enemy Block Ability has been removed"
		print("Enemy Block Ability has been removed")
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
	
	// MARK: winLoseCondition
	
	/// If enemy is dead -> collect rewards and move on
	/// Otherwise go to the start screen, lose everything except score and gold
	func winLoseCondition() {
		
		if gameState.hero.currentHP <= 0 {
			print("The End")
			setupNewGame()
			
		} else if gameState.enemy.enemyCurrentHP <= 0 &&
					!gameState.didEncounteredBoss {
			print("Average Enemy has been defeated!")
			gameState.didEncounterEnemy = false
			generateLoot()
			getRewardAfterFight()
			goToRewards()
			
		} else if gameState.enemy.enemyCurrentHP <= 0 &&
					gameState.didEncounteredBoss {
			
			print("Boss has been defeated!")
			generateLoot()
			getRewardAfterFight()
			goToRewards()
			endLevelAndGenerateNewOne()
		}
	}
	
	// MARK: getRewardAfterFight
	
	func getRewardAfterFight() {
		
		gameState.battlesWon += 1
		checkForLevelUP()
	}
	
	// MARK: checkForLevelUP
	
	func checkForLevelUP() {
		
		if  gameState.hero.currentXP >= gameState.hero.maxXP {
			gameState.hero.levelUP()
			gameState.hero.currentXP = 0
			gameState.hero.maxXP += 50
			
			getRewardAfterLevel()
		}
	}
	
	// MARK: getRewardAfterLevel
	
	func getRewardAfterLevel() {
		
		// This line works as a placeholder for bonuses -> remove it with actual bonuses
		gameState.levelBonusesRarities = []
		
		// This line cleans previous bonuses to generate
		gameState.levelBonusesToChoose = []
		
		// Generate level of raririty -> ask LevelBonusManager to provide a random bonus accordingly to the rarity
		// Add this bonus to levelBonusesToChoose
		for _ in 1...3 {
			gameState.levelBonusesRarities.append(generateRewardRarity())
		}
		
		goToRewards()
	}
	
	// MARK: Buy/Sell Item
	
	func buyOrSellItem(onSale: Bool) {
		
		guard let itemToDisplay = gameState.itemToDisplay else { return }
		
		switch itemToDisplay.itemType {
			
		case .weapon:
			
			guard let weapon = itemToDisplay as? Weapon else { return }
			
			if onSale {
				
				if gameState.hero.weapons[weapon] ?? 0 >= 1 {
					gameState.hero.weapons[weapon]! -= 1
					gameState.heroGold += weapon.price
					gameState.merchantWeaponsLoot[weapon, default: 0] += 1
					
					if gameState.hero.weapons[weapon]! == 0 {
						gameState.hero.weapons[weapon] = nil
					}
				}
				
			} else {
				
				if weapon.price <= gameState.heroGold &&
					gameState.merchantWeaponsLoot[weapon] ?? 0 >= 1 {
					
						gameState.merchantWeaponsLoot[weapon]! -= 1
						gameState.hero.weapons[weapon, default: 0] += 1
						gameState.heroGold -= weapon.price
						
						if gameState.merchantWeaponsLoot[weapon]! == 0 {
							gameState.merchantWeaponsLoot[weapon] = nil
						}
					}
			}
			
		case .armor:
			
			guard let armor = itemToDisplay as? Armor else { return }
			
			if onSale {
				
				if gameState.hero.armors[armor] ?? 0 >= 1 {
					gameState.hero.armors[armor]! -= 1
					gameState.heroGold += armor.price
					gameState.merchantArmorsLoot[armor, default: 0] += 1
					
					if gameState.hero.armors[armor]! == 0 {
						gameState.hero.armors[armor] = nil
					}
				}
				
			} else {
				
				if armor.price <= gameState.heroGold &&
					gameState.merchantArmorsLoot[armor] ?? 0 >= 1  {
					
					gameState.merchantArmorsLoot[armor]! -= 1
					gameState.hero.armors[armor, default: 0] += 1
					gameState.heroGold -= armor.price
					
					if gameState.merchantArmorsLoot[armor]! == 0 {
						gameState.merchantArmorsLoot[armor] = nil
					}
				}
			}
			
		case .potion:
			
			guard let potion = itemToDisplay as? Item else { return }
			
			if onSale {
				
				if gameState.hero.inventory[potion] ?? 0 >= 1 {
					gameState.hero.inventory[potion]! -= 1
					gameState.heroGold += potion.price
					gameState.merchantInventoryLoot[potion, default: 0] += 1
					
					if gameState.hero.inventory[potion]! == 0 {
						gameState.hero.inventory[potion] = nil
					}
				}
				
			} else {
				
				if potion.price <= gameState.heroGold &&
					gameState.merchantInventoryLoot[potion] ?? 0 >= 1 {
					
					gameState.merchantInventoryLoot[potion]! -= 1
					gameState.hero.inventory[potion, default: 0] += 1
					gameState.heroGold -= potion.price
					
					if gameState.merchantInventoryLoot[potion]! == 0 {
						gameState.merchantInventoryLoot[potion] = nil
					}
				}
			}
			
		case .loot:
			
			guard let loot = itemToDisplay as? Item else { return }
			
			if onSale {
				
				if gameState.hero.inventory[loot] ?? 0 >= 1 {
					gameState.hero.inventory[loot]! -= 1
					gameState.heroGold += loot.price
					gameState.merchantInventoryLoot[loot, default: 0] += 1
					
					if gameState.hero.inventory[loot]! == 0 {
						gameState.hero.inventory[loot] = nil
					}
				}
				
			} else {
				
				if loot.price <= gameState.heroGold &&
					gameState.merchantInventoryLoot[loot] ?? 0 >= 1 {
					
					gameState.merchantInventoryLoot[loot]! -= 1
					gameState.hero.inventory[loot, default: 0] += 1
					gameState.heroGold -= loot.price
					
					if gameState.merchantInventoryLoot[loot]! == 0 {
						gameState.merchantInventoryLoot[loot] = nil
					}
				}
			}
		}
	}
	
	// MARK: EquipOrUseItem
	
	/// If it's a weapon or armor - equip it, otherwise use the item if possible
	func equipOrUseItem() {
		
		guard let itemToDisplay = gameState.itemToDisplay else { return }
		
		switch itemToDisplay.itemType {
			
		case .weapon:
			
			guard let weapon = itemToDisplay as? Weapon else { return }
			
			equipWeapon(weapon)
			
		case .armor:
			
			guard let armor = itemToDisplay as? Armor else { return }
			
			equipArmor(armor)
			
		case .potion: usePotion(itemToDisplay as! Item)
			
		case .loot:
			print("it's a loot")
		}
	}
	
	// MARK: equipWeapon
	
	func equipWeapon(_ weapon: Weapon) {
		
		// If there is a weapon currently equipped, return it to inventory count
		if let currentWeapon = gameState.hero.weaponSlot {
			gameState.hero.weapons[currentWeapon, default: 0] += 1
		}

		// Equip the new weapon
		gameState.hero.weaponSlot = weapon

		// Decrement the count of the new weapon in inventory if present and count > 0
		if let currentCount = gameState.hero.weapons[weapon], currentCount > 0 {
			gameState.hero.weapons[weapon]! = currentCount - 1
			
			if gameState.hero.weapons[weapon]! == 0 {
				gameState.hero.weapons[weapon] = nil
			}
		}
	}
	
	func equipArmor(_ armor: Armor) {
		
		// If there is a Armor currently equipped, return it to inventory count
		if let currentArmor = gameState.hero.armorSlot {
			gameState.hero.armors[currentArmor, default: 0] += 1
		}

		// Equip the new armor
		gameState.hero.armorSlot = armor

		// Decrement the count of the new armor in inventory if present and count > 0
		if let currentCount = gameState.hero.armors[armor], currentCount > 0 {
			gameState.hero.armors[armor]! = currentCount - 1
			
			if gameState.hero.armors[armor]! == 0 {
				gameState.hero.armors[armor] = nil
			}
		}
	}
	
	// MARK: usePotion
	
	func usePotion(_ potion: Item) {
		
		/*
		 Item(label: "Small Health Potion", itemType: .potion, itemLevel: 1, description: "Heals by 25% of maximum HP", price: 75),
		 
		 Item(label: "Mana Potion", itemType: .potion, itemLevel: 1, description: "Resumes mana by 25% of maximum MP", price: 75),
		 
		 Item(label: "Great Health Elixir", itemType: .potion, itemLevel: 2, description: "Adds 10% to maximum HP", price: 300),
		 
		 Item(label: "Great Mana Elixir", itemType: .potion, itemLevel: 2, description: "Adds 10% to maximum MP", price: 300),
		 */
		
		if gameState.hero.inventory[potion] != nil {
			if gameState.hero.inventory[potion]! > 0 {
				gameState.hero.inventory[potion]! -= 1
				
				if gameState.hero.inventory[potion]! == 0 {
					gameState.hero.inventory[potion] = nil
				}
			}
		}
		
		switch potion.label {
			
		case "Small Health Potion":
			
			// heals by 25% of max HP
			let heal = Int(Double(gameState.hero.maxHP) / 4.0)
			if gameState.hero.currentHP + heal <= gameState.hero.maxHP {
				gameState.hero.currentHP += heal
			} else {
				gameState.hero.currentHP = gameState.hero.maxHP
			}
			
		case "Mana Potion":
			
			// Resumes mana by 25% of maximum MP
			let manaRegen = Int(Double(gameState.hero.maxMana) / 4.0)
			if gameState.hero.currentMana + manaRegen <= gameState.hero.maxMana {
				gameState.hero.currentMana += manaRegen
			} else {
				gameState.hero.currentMana = gameState.hero.maxMana
			}
			
		case "Great Health Elixir":
			
			// Adds 10% to maximum HP
			let value = Int(Double(gameState.hero.maxHP) * 0.1)
			gameState.hero.maxHP += value
			
		case "Great Mana Elixir":
			
			// Adds 10% to maximum MP
			let value = Int(Double(gameState.hero.maxMana) * 0.1)
			gameState.hero.maxMana += value
			
		default: return
		}
	}
}
