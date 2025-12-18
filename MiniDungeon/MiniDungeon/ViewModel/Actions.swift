import Foundation

// MARK: - ActionType

/// Type of action you can take inside the dungeon when encounter different types of events
enum ActionType {
	
	case restoreHealthMana
	case getFlaskCharge
	case disenchantItem
	case defuseTrap
	case lockPickChest
	case unlockChestWithKey
}

extension MainViewModel {
	
	// MARK: - applyEffect
	
	/// Apply effect of the button in `Actions` list and clear tile's events to avoid dealing with the same situation again
	func applyEffect(for action: ActionType) {
		
		switch action {
			
		case .restoreHealthMana:
			
			getHealManaOrDamageFromShrine()
			
		case .getFlaskCharge:
			
			print("got a new charge of flask")
			// 100% chance to get one charge of shadow flask
			gameState.dealtWithRestorationShrine = true
			
		case .disenchantItem:
			
			disenchantItem()
			
		case .lockPickChest:
			
			lockPickChest()
		
		case .unlockChestWithKey:
			
			unlockChestWithKey()
			
			
		default: break
		}
		
		// After any type of actions remove an event from the tile so in the future you won't find yourself at the same choice twice
		
		let position = gameState.heroPosition
		gameState.dungeonMap[position.0][position.1].events = []
	}
	
	// MARK: - lockPickChest
	
	/// Transition to Lock-Picking View
	func lockPickChest() {
		
		
		gameState.isLockPickingMiniGameIsOn = true
		gameState.dealthWithChest = true
	}
	
	/// Use 1 key to open the chest and get the loot
	func unlockChestWithKey() {
		
		guard displayKeys() > 0 else { return }
		
		let key = ItemManager.returnKeyItem()
		
		gameState.hero.inventory[key]! -= 1
		gameState.dealthWithChest = true
		generateLoot()
		goToRewards()
	}
	
	// MARK: - disenchantItem
	
	func disenchantItem() {
		
		guard let item = gameState.itemToDisplay else { return }
		
		guard item is Armor || item is Weapon  else {
			print("Item is not Armor or Weapon")
			return
		}
		print("Solid item to disenchant")
		
		switch gameState.itemToDisplay?.itemLevel {
			
		case 1: gameState.darkEnergyLootToDisplay = Int.random(in: 1...5)
		case 2: gameState.darkEnergyLootToDisplay = Int.random(in: 6...10)
		case 3: gameState.darkEnergyLootToDisplay = Int.random(in: 11...15)
		case 4: gameState.darkEnergyLootToDisplay = Int.random(in: 16...20)
		default: break
		}
		
		if item is Armor {
			
			gameState.hero.armors[item as! Armor]! -= 1
			
			if gameState.hero.armors[item as! Armor]! <= 0 {
				gameState.hero.armors[item as! Armor] = nil
				
			}
			
		} else if item is Weapon {
			
			gameState.hero.weapons[item as! Weapon]! -= 1
			
			if gameState.hero.weapons[item as! Weapon]! <= 0 {
				gameState.hero.weapons[item as! Weapon] = nil
				
			}
		}
		
		gameState.heroDarkEnergy += gameState.darkEnergyLootToDisplay
		gameState.dealtWithDisenchantShrine = true
		goToRewards()
	}
	
	// MARK: - getHealManaOrDamageFromShrine
	
	/// Put this method to `applyEffect` to get from restoration shrine
	func getHealManaOrDamageFromShrine() {
		
		// TODO: Display the outcome in Rewards screen
		
		let chance = Int.random(in: 1...10)
		
		if chance == 1 {
			
			let healthPoints = Int(Double(gameState.hero.maxHP) * 0.10)
			
			if (gameState.hero.currentHP - healthPoints) <= 0 {
				setupNewGame()
			} else {
				gameState.hero.currentHP -= healthPoints
			}
			gameState.healthPointsLootToDisplay = healthPoints
			
			let manaPoints = Int(Double(gameState.hero.maxMana) * 0.10)
			
			if (gameState.hero.currentMana - manaPoints) <= 0 {
				gameState.hero.currentMana = 0
			} else {
				gameState.hero.currentMana -= manaPoints
			}
			
			gameState.manaPointsLootToDisplay = manaPoints
			
			
		} else {
			
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
		gameState.dealtWithRestorationShrine = true
		goToRewards()
		
	}
	
	// MARK: - startTrapDefusionMiniGame
	
	func startTrapDefusionMiniGame() {
		
		gameState.dealtWithTrap = true
		gameState.isTrapDefusionMiniGameIsOn = true
		print("Defused")
	}
}
