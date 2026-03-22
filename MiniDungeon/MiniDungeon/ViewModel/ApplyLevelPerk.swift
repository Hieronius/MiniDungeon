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
			
			
		case "Common Perk of Protection":
			
			gameState.minBlockValue += 2
			gameState.maxBlockValue += 2
			
			
		case "Common Perk of Wisdom":
			
			gameState.hero.baseSpellPower += 3
			
		case "Common Perk of Critical Hit":
			
			gameState.hero.baseCritEffectModifier += 0.1
			
		case "Common Perk of Preparation":
			
			gameState.isPrepPerkActive = true
			gameState.prepPerkEffectModifier += 0.5
			
		case "Common Perk of Ill Word":
			
			gameState.isIllWordPerkActive = true
			gameState.illWordPerkEffectModifier += 0.25
			
		case "Common Perk of Reflection":
			
			gameState.isReflectionPerkActive = true
			gameState.reflectionPerkEffectModifier += 0.1
			
		case "Common Perk of Vampirism":
			
			// MARK: YOU ARE HERE TO IMPLEMENT
			
			/*
			 
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
