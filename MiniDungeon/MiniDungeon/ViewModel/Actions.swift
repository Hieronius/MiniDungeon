import Foundation

// MARK: - ActionType

/// Type of action you can take inside the dungeon when encounter different types of events
enum ActionType {
	
	case restoreHealthManaWithSmallChanceToGetDamage
	case getFlaskCharge
	case disenchantItem
	case defuseTrap
	case lockPickChest
	case unlockChestWithKey
}

extension MainViewModel {
	
	// MARK: - applyEffect
	
	/// Apply effect of the button in `Actions` list and clear tile's events to avoid dealing with the same situation again
	func applyEffect(for action: ActionType, item: (any ItemProtocol)?) {
		
		switch action {
			
		case .restoreHealthManaWithSmallChanceToGetDamage:
			
			getHealManaOrDamageFromShrine()
			
		case .getFlaskCharge:
			
			getShadowFlaskCharge()
			
		case .disenchantItem:
			
			disenchantItem(item)
			
		case .lockPickChest:
			
			lockPickChest()
		
		case .unlockChestWithKey:
			
			unlockChestWithKey()
			
			
		default: break
		}
		
		// After any type of actions remove an event from the tile so in the future you won't find yourself at the same choice twice
		
		let position = gameState.heroPosition
		gameState.dungeonMap[position.row][position.col].events = []
	}
	
	// MARK: - lockPickChest
	
	/// Transition to Lock-Picking View
	func lockPickChest() {
		
		
		gameState.isLockPickingMiniGameIsOn = true
		gameState.dealthWithChest = true
	}
	
	// MARK: - unlockChestWithKey
	
	/// Use 1 key to open the chest and get the loot
	func unlockChestWithKey() {
		
		guard displayKeys() > 0 else { return }
		
		let key = ItemManager.returnKeyItem()
		
		gameState.hero.inventory[key]! -= 1
		
		if gameState.hero.inventory[key]! <= 0 {
			gameState.hero.inventory[key] = nil
		}
		gameState.dealthWithChest = true
		generateLoot()
		goToRewards()
	}
	
	// MARK: - disenchantItem
	
	func disenchantItem(_ item: (any ItemProtocol)?){
		
		guard let item = item else { return }
		
		guard item is Armor || item is Weapon  else {
			print("Item is not Armor or Weapon")
			return
		}
		print("Solid item to disenchant")
		
		switch item.itemLevel {
			
		case 1: gameState.darkEnergyLootToDisplay = Int.random(in: 1...5)
		case 2: gameState.darkEnergyLootToDisplay = Int.random(in: 6...10)
		case 3: gameState.darkEnergyLootToDisplay = Int.random(in: 11...15)
		case 4: gameState.darkEnergyLootToDisplay = Int.random(in: 16...20)
		default: break
		}
		
		if item is Armor {
			
			if !(gameState.hero.armorSlot == item as? Armor) {
				gameState.hero.armors[item as! Armor]! -= 1
				
				if gameState.hero.armors[item as! Armor]! <= 0 {
					gameState.hero.armors[item as! Armor] = nil
					
				}
				
			} else {
				gameState.hero.armorSlot = nil
			}
			
		} else if item is Weapon {
			
			if !(gameState.hero.weaponSlot == item as? Weapon) {
				gameState.hero.weapons[item as! Weapon]! -= 1
				
				if gameState.hero.weapons[item as! Weapon]! <= 0 {
					gameState.hero.weapons[item as! Weapon] = nil
					
				}
				
			} else {
				gameState.hero.weaponSlot = nil
			}
			
		}
		
		gameState.heroDarkEnergy += gameState.darkEnergyLootToDisplay
		gameState.heroMaxDarkEnergyOverall += gameState.darkEnergyLootToDisplay
		gameState.hero.flask.currentXP += gameState.darkEnergyLootToDisplay
		gameState.dealtWithDisenchantShrine = true
		
		// place to erase tile character to "" to reflect that an event has been completed
		let position = gameState.heroPosition
//
		gameState.dungeonMap[position.row][position.col].type = .corridor
		goToRewards()
	}
	
	// MARK: - getHealManaOrDamageFromShrine
	
	/// Put this method to `applyEffect` to get from restoration shrine
	func getHealManaOrDamageFromShrine() {
		
		// TODO: Display the outcome in Rewards screen
		
		let chance = Int.random(in: 1...10)
		print(chance)
		
		// Seems like having a 10% chance to get damage is not fun especially for newbyes.
		// Set this condition to 0 so it won't be triggered for the time being
		if chance == 0 {
			
			print("YOU RECEIVE DAMAGE FROM RESTORATION SHRINE")
			
			let healthPoints = Int(Double(gameState.hero.maxHP) * 0.10)
			
			if (gameState.hero.currentHP - healthPoints) <= 0 {
				// TODO: setupNewGame at this stage will ignore TownScreen, fix it
//				setupNewGame()
//				winLoseCondition()
			} else {
				gameState.hero.currentHP -= healthPoints
			}
			gameState.healthPointsLootToDisplay = -healthPoints
			
			let manaPoints = Int(Double(gameState.hero.maxMana) * 0.10)
			
			if (gameState.hero.currentMana - manaPoints) <= 0 {
				gameState.hero.currentMana = 0
			} else {
				gameState.hero.currentMana -= manaPoints
			}
			
			gameState.manaPointsLootToDisplay = -manaPoints
			
			
		} else {
			
			print("YOU RECEIVE HEALING FROM RESTORATION SHRINE")
			
			let healthPoints = Int(Double(gameState.hero.maxHP) * 0.25)
			
			if (gameState.hero.currentHP + healthPoints) > gameState.hero.maxHP {
				gameState.hero.currentHP = gameState.hero.maxHP
			} else {
				gameState.hero.currentHP += healthPoints
			}
			gameState.healthPointsLootToDisplay = healthPoints
			
			let manaPoints = Int(Double(gameState.hero.maxMana) * 0.25)
			
			if (gameState.hero.currentMana + manaPoints) > gameState.hero.maxMana {
				gameState.hero.currentMana = gameState.hero.maxMana
			} else {
				gameState.hero.currentMana += manaPoints
			}
			gameState.manaPointsLootToDisplay = manaPoints
		}
		let position = gameState.heroPosition
		gameState.dungeonMap[position.row][position.col].type = .corridor
		gameState.dealtWithRestorationShrine = true
		goToRewards()
		
	}
	
	// MARK: getShadowFlaskCharge
	
	func getShadowFlaskCharge() {
		
		let currentCharges = gameState.hero.flask.currentCharges
		let maxCharges = gameState.hero.flask.currentMaxCharges
		
		print("attempt to restore flask charge")
		
		guard currentCharges < maxCharges else { return }
		gameState.hero.flask.currentCharges += 1
		gameState.dealtWithRestorationShrine = true
		print("got a charge for the flask")
	}
	
	// MARK: - startTrapDefusionMiniGame
	
	func startTrapDefusionMiniGame() {
		
		gameState.dealtWithTrap = true
		gameState.isTrapDefusionMiniGameIsOn = true
		print("Defused")
	}
	
	// MARK: - handleTrapDefusionMiniGameResult
	
	func handleTrapDefusionMiniGameResult(_ result: Bool) {
		
		// this property seems to be duplicated
		gameState.isTrapDefusionMiniGameSuccessful = result
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.gameState.isTrapDefusionMiniGameIsOn = false
			self.calculateTrapDefusionResult(result)
			self.gameState.didEncounterTrap = false
			
			// place to erase tile character to "" to reflect that an event has been completed
			let position = self.gameState.heroPosition
//					viewModel.gameState.dungeonMap[position.row][position.col].events = []
			self.gameState.dungeonMap[position.row][position.col].type = .corridor
			
			// with this one
			self.gameState.didTrapDefusionIsSuccess = result
			self.goToRewards()
			
			
		}
	}
	
	// MARK: - handleChestLockPickingMiniGameResult
	
	func handleChestLockPickingMiniGameResult(_ result: Bool) {
		
		gameState.isLockPickingMiniGameIsSuccess = result
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.gameState.isLockPickingMiniGameIsOn = false
			self.calculateChestLockPickingResult(result)
			self.gameState.didEncounterChest = false
			// with this one
			self.gameState.didChestLockPickingIsSuccess = result
			
			// place to erase tile character to "" to reflect that an event has been completed
			let position = self.gameState.heroPosition
			
			self.gameState.dungeonMap[position.row][position.col].type = .corridor
			
		}
	}
}
