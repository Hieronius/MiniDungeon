import Foundation

extension MainViewModel {
	
	/// Method to activate shrine by adding a selected one
	func activateShrine(_ shrine: Shrine?) {
		
		guard let shrine else { return }
		
		guard (gameState.heroDarkEnergy - 10) >= shrine.darkEnergyCost && !gameState.upgradedShrines.contains(shrine)
		else { return }
		
		gameState.heroDarkEnergy -= shrine.darkEnergyCost
		print("dark energy deducted")
		gameState.upgradedShrines.append(shrine)
		print("new shrine has been activated")
		applyShrineEffect(shrine)
		print("new shrine effect has been applied")
	}
	
	/// Check all upgraded shrines and apply it's effect on new run
	func applyActiveShrineEffects() {
		gameState.upgradedShrines.forEach {
			applyShrineEffect($0)
			print("applied \($0.name) effect for a new run")
		}
	}
	
	/// Use this method on the array of shrines to activate at the start of new run
	func applyShrineEffect(_ shrine: Shrine) {
		
		switch shrine.name {
			
		// Common Shrines
			
		case "Small Shrine of Health":
			gameState.hero.baseMaxHP += 5
			gameState.hero.currentHP += 5
			
		case "Small Shrine of Mana":
			gameState.hero.baseMaxMP += 5
			gameState.hero.currentMana += 5
			
		case "Small Shrine of Claw":
			gameState.hero.baseMaxDamage += 1
			
		case "Small Shrine of Paw":
			gameState.hero.baseMinDamage += 1
			
		// Rare Shrines
			
		case "Small Shrine of Alchemist Luck":
			
			if let potion = generatePotionLoot(didFinalBossSummoned: false, of: .common) {
				gameState.hero.inventory[potion, default: 0] += 1
			} else {
				print("No potion has been generated")
			}
			
		case "Small Shrine of Sharpness":
			gameState.hero.baseCritChance += 1
			
		case "Small Shrine of Focus":
			gameState.hero.baseHitChance += 1
			
		case "Small Shrine of Warrior Luck":
			
			if let weapon = generateWeaponLoot(didFinalBossSummoned: false, of: .common) {
				gameState.hero.weapons[weapon, default: 0] += 1
			} else {
				print("No weapon has been generated")
			}
			
		case "Small Shrine of Wing":
			gameState.hero.baseSpellPower += 2
			
		case "Shrine of Health":
			gameState.hero.baseMaxHP += 10
			gameState.hero.currentHP += 10
			
		case "Small Shrine of Guardian Luck":
			
			if let armor = generateArmorLoot(didFinalBossSummoned: false, of: .common) {
				gameState.hero.armors[armor, default: 0] += 1
			} else {
				print("No armor has been generated")
			}
			
		case "Shrine of Mana":
			gameState.hero.baseMaxMP += 10
			gameState.hero.currentMana += 10
			
		case "Shrine of Claw":
			gameState.hero.baseMaxDamage += 2
			
		case "Shrine of Paw":
			gameState.hero.baseMinDamage += 2
			
		case "Shrine of Protection":
			gameState.hero.baseDefence += 1
			
		// Epic Shrines
			
		// TODO: Implement mechanic
		case "Great Shrine of Profession":
			print("Opens a new class to choose at the start of each run")
			
		case "Great Shrine of Health":
			gameState.hero.baseMaxHP += 15
			gameState.hero.currentHP += 15
			
		case "Great Shrine of Mana":
			gameState.hero.baseMaxMP += 15
			gameState.hero.currentMana += 15
			
		case "Shrine of Alchemist Luck":
			
			if let potion = generatePotionLoot(didFinalBossSummoned: false, of: .rare) {
				gameState.hero.inventory[potion, default: 0] += 1
			} else {
				print("No potion has been generated")
			}
			
		case "Shrine of Sharpness":
			gameState.hero.baseCritChance += 2
		
		case "Shrine of Focus":
			gameState.hero.baseHitChance += 2
			
		case "Shrine of Warrior Luck":
			
			if let weapon = generateWeaponLoot(didFinalBossSummoned: false, of: .rare) {
				gameState.hero.weapons[weapon, default: 0] += 1
			} else {
				print("No weapon has been generated")
			}
			
		case "Shrine of Wing":
			gameState.hero.baseSpellPower += 5
			
		case "Great Shrine of Claw":
			gameState.hero.baseMaxDamage += 3
			
		case "Great Shrine of Paw":
			gameState.hero.baseMinDamage += 3
		
		case "Shrine of Guardian Luck":
			
			if let armor = generateArmorLoot(didFinalBossSummoned: false, of: .rare) {
				gameState.hero.armors[armor, default: 0] += 1
			} else {
				print("No armor has been generated")
			}
			
		case "Great Shrine of Protection":
			gameState.hero.baseDefence += 2
			
		// Legendary Shrines
		
		case "Shrine of Mystery":
			gameState.mysteryShrineBeenActivated = true
		
		case "Shrine of Shadow Greed":
			gameState.shadowGreedShrineBeenActivated = true
			
		case "Great Shrine of Stamina":
			gameState.hero.baseMaxEP += 1
			gameState.hero.currentEnergy += 1
		
		// TODO: Implement mechanic
		case "Great Shrine of Talant":
			print("Unlockes one new ability for each class")
			
		default: print("it's a default case")
		}
		gameState.shrineUpgradeToDisplay = nil
	}
}
