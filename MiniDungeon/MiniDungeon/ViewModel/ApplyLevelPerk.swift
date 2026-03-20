import Foundation

extension MainViewModel {
	
	/// Method to apply newly acquired LevelPerk
	func applyLevelPerk(_ perk: LevelPerk?) {
		
		guard let perk = perk else { return }
		
		switch perk.name {
			
			// Common
			
		case "Common Perk Of Sharpness":
			
			gameState.hero.baseMinDamage += 1
			gameState.hero.baseMaxDamage += 1
			
		case "Common Perk Of Vitality":
			
			gameState.hero.baseMaxHP += 10
			gameState.hero.currentHP += 10
			gameState.hero.baseMaxMP += 10
			gameState.hero.currentMana += 10
			
		case "Common Perk Of Precision":
			
			gameState.hero.baseCritChance += 1
			gameState.hero.baseHitChance += 1
			
		case "Common Perk of Brutality":
			
			gameState.hero.baseArmorPenetration += 2
			
		case "Common Perk of Reaction":
			
			gameState.hero.baseChanceStartTurnFirst += 5
			
		case "Common Perk of Savagery":
			
			gameState.hero.baseAttackDamageModifier += 0.1
			gameState.hero.baseComboDamageModifier += 0.1
			
			/*
			 
			 LevelPerk(name: "Common Perk of Protection", perkDescription: "+2 block value"),
			 
			 LevelPerk(name: "Common Perk of Wisdom", perkDescription: "+3 spell power"),
			 
			 LevelPerk(name: "Common Perk of Critical Hit", perkDescription: "+10% critical effect of attack/heal/block abilities"),
			 
			 LevelPerk(name: "Common Perk of Preparation", perkDescription: "Adds 50% of current block value as damage to next attack after using block ability"),
			 
			 LevelPerk(name: "Common Perk of Ill Word", perkDescription: "Adds 25% of heal value to next attack after using heal ability"),
			 
			 LevelPerk(name: "Common Perk of Retaliation", perkDescription: "Reflect 10% of enemy damage while under block ability"),
			 
			 LevelPerk(name: "Common Perk of Vampirism", perkDescription: "Normal attacks can heal by 5% of damage done"),
			 
			 LevelPerk(name: "Common Perk of Spell Stealing", perkDescription: "Normal attacks can restore mana by 5% of damage done"),
			 
			 LevelPerk(name: "Common Perk of Fortitude", perkDescription: "Use of heal ability adds 3 block value to next Block ability"),
			 
			 LevelPerk(name: "Common Perk of Resilience", perkDescription: "Use of block ability adds 3 spell power to next Heal ability"),
			 
			 LevelPerk(name: "Common Perk of Armor Destruction", perkDescription: "Use of normal attacks deduct 1 enemy armor per each use"),
			 
			 LevelPerk(name: "Common Perk of Energy Surge", perkDescription: "Use of attack/block/heal has a 5% chance to get Energy Cost back"),
			 
			 LevelPerk(name: "Common Perk of Soul Extraction", perkDescription: "Critical attacks extract 5% of it's value as Dark Energy"),
			 
			 LevelPerk(name: "Common Perk of Greed", perkDescription: "+5% of dark energy, gold loot and experience gain"),
			 
			 LevelPerk(name: "Common Perk of Crushing Blow", perkDescription: "Normal Attacks have a 5% chance to remove 1 enemy EP for next turn"),
			 
			 LevelPerk(name: "Common Perk of Swiftness", perkDescription: "Attacks, heal and block abilities have a 5% chance to make a double effect after use"),
			 */
			
			
			
			
			
			
			
			
			
			// Rare
			
			
			
			
			
			
			
			// Epic
			
			
			
			
			
			
			
			// Legendary
		}
		
		
	}
}
