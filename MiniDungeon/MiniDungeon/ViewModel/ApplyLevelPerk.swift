import Foundation

extension MainViewModel {
	
	// MARK: - applyLevelPerk
	
	/// Method to apply newly acquired LevelPerk
	func applyLevelPerk(_ perk: LevelPerk?) {
		
		guard let perk = perk else { return }
		
		switch perk.name {
			
			// MARK: - Common Perks
			
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
			
			gameState.isVampirismPerkActive = true
			gameState.vampirismEffectModifier += 0.05
			
		case "Common Perk of Spell Stealing":
			
			gameState.isSpellStealingPerkActive = true
			gameState.spellStealingEffectModifier += 0.05
			
		case "Common Perk of Fortitude":
			
			gameState.isFortitudePerkActive = true
			gameState.fortitudeEffectModifier += 3
			
		case "Common Perk of Resilience":
			
			gameState.isResiliencePerkActive = true
			gameState.resilienceEffectModifier += 3
			
		case "Common Perk of Armor Destruction":
			
			gameState.isArmorDestructionPerkActive = true
			gameState.armorDestructionEffectModifier += 1
			
		case "Common Perk of Energy Surge":
			
			gameState.isEnergySurgePerkActive = true
			gameState.energySurgeEffectModifier += 5
			
		case "Common Perk of Soul Extraction":
			
			gameState.isSoulExtractionPerkActive = true
			gameState.soulExtractionEffectModifier += 0.05
			
		case "Common Perk of Greed":
			
			gameState.isGreedPerkActive = true
			gameState.greedPerkEffectModifier += 0.05
			
		case "Common Perk of Crushing Blow":
			
			gameState.isCrushingBlowPerkActive = true
			gameState.crushingBlowEffectModifier += 5
			
		case "Common Perk of Swiftness":
			
			gameState.isSwiftnessPerkActive = true
			gameState.swiftnessPerkEffectModifier += 5
			
			// MARK: - Rare Perks
			
		case "Rare Perk Of Sharpness":
			
			gameState.hero.baseMinDamage += 2
			gameState.hero.baseMaxDamage += 2
			
		case "Rare Perk Of Vitality":
			
			gameState.hero.baseMaxHP += 20
			gameState.hero.baseMaxMP += 20
			
		case "Rare Perk Of Precision":
			
			gameState.hero.baseCritChance += 2
			gameState.hero.baseHitChance += 2
			
		case "Rare Perk of Brutality":
			
			gameState.hero.baseArmorPenetration += 4
			
		case "Rare Perk of Reaction":
			
			gameState.hero.baseChanceStartTurnFirst += 10
			
		case "Rare Perk of Savagery":
			
			gameState.hero.baseAttackDamageModifier += 0.15
			gameState.hero.baseComboDamageModifier += 0.15
			
		case "Rare Perk of Protection":
			
			gameState.minBlockValue += 4
			gameState.maxBlockValue += 4
			
		case "Rare Perk of Wisdom":
			
			gameState.hero.baseSpellPower += 6
			
		case "Rare Perk of Critical Hit":
			
			gameState.hero.baseCritEffectModifier += 0.15
			
		case "Rare Perk of Preparation":
			
			gameState.isPrepPerkActive = true
			gameState.prepPerkEffectModifier += 1.0
			
		case "Rare Perk of Ill Word":
			
			gameState.isIllWordPerkActive = true
			gameState.illWordPerkEffectModifier += 0.5
			
		case "Rare Perk of Reflection":
			
			gameState.isReflectionPerkActive = true
			gameState.reflectionPerkEffectModifier += 0.15
			
		case "Rare Perk of Vampirism":
			
			gameState.isVampirismPerkActive = true
			gameState.vampirismEffectModifier += 0.1
			
		case "Rare Perk of Spell Stealing":
			
			gameState.isSpellStealingPerkActive = true
			gameState.spellStealingEffectModifier += 0.1
			
		case "Rare Perk of Fortitude":
			
			gameState.isFortitudePerkActive = true
			gameState.fortitudeEffectModifier += 6
			
		case "Rare Perk of Resilience":
			
			gameState.isResiliencePerkActive = true
			gameState.resilienceEffectModifier += 6
			
		case "Rare Perk of Armor Destruction":
			
			gameState.isArmorDestructionPerkActive = true
			gameState.armorDestructionEffectModifier += 2
			
		case "Rare Perk of Energy Surge":
			
			gameState.isEnergySurgePerkActive = true
			gameState.energySurgeEffectModifier += 10
			
		case "Rare Perk of Soul Extraction":
			
			gameState.isSoulExtractionPerkActive = true
			gameState.soulExtractionEffectModifier += 0.1
			
		case "Rare Perk of Greed":
			
			gameState.isGreedPerkActive = true
			gameState.greedPerkEffectModifier += 0.1
			
		case "Rare Perk of Crushing Blow":
			
			gameState.isCrushingBlowPerkActive = true
			gameState.crushingBlowEffectModifier += 10
			
		case "Rare Perk of Swiftness":
			
			gameState.isSwiftnessPerkActive = true
			gameState.swiftnessPerkEffectModifier += 10
			
			// MARK: - Epic Perks
			
		case "Epic Perk Of Sharpness":
			
			gameState.hero.baseMinDamage += 3
			gameState.hero.baseMaxDamage += 3
			
		case "Epic Perk Of Vitality":
			
			gameState.hero.baseMaxHP += 40
			gameState.hero.baseMaxMP += 40
			
		case "Epic Perk Of Precision":
			
			gameState.hero.baseCritChance += 3
			gameState.hero.baseHitChance += 3
			
		case "Epic Perk of Brutality":
			
			gameState.hero.baseArmorPenetration += 6
			
		case "Epic Perk of Reaction":
			
			gameState.hero.baseChanceStartTurnFirst += 15
			
		case "Epic Perk of Savagery":
			
			gameState.hero.baseAttackDamageModifier += 0.2
			gameState.hero.baseComboDamageModifier += 0.2
			
		case "Epic Perk of Protection":
			
			gameState.minBlockValue += 6
			gameState.maxBlockValue += 6
			
		case "Epic Perk of Wisdom":
			
			gameState.hero.baseSpellPower += 10
			
		case "Epic Perk of Critical Hit":
			
			gameState.hero.baseCritEffectModifier += 0.25
			
		case "Epic Perk of Preparation":
			
			gameState.isPrepPerkActive = true
			gameState.prepPerkEffectModifier += 1.5
			
		case "Epic Perk of Ill Word":
			
			gameState.isIllWordPerkActive = true
			gameState.illWordPerkEffectModifier += 0.75
			
		case "Epic Perk of Reflection":
			
			gameState.isReflectionPerkActive = true
			gameState.reflectionPerkEffectModifier += 0.25
			
		case "Epic Perk of Vampirism":
			
			gameState.isVampirismPerkActive = true
			gameState.vampirismEffectModifier += 0.15
			
		case "Epic Perk of Spell Stealing":
			
			gameState.isSpellStealingPerkActive = true
			gameState.spellStealingEffectModifier += 0.15
			
		case "Epic Perk of Health Grow":
			
			gameState.isHealthGrowPerkActive = true
			gameState.healthGrowEffectModifier += 1
			
		case "Epic Perk of Fortitude":
			
			gameState.isFortitudePerkActive = true
			gameState.fortitudeEffectModifier += 10
			
		case "Epic Perk of Resilience":
			
			gameState.isResiliencePerkActive = true
			gameState.resilienceEffectModifier += 10
			
		case "Epic Perk of Armor Destruction":
			
			gameState.isArmorDestructionPerkActive = true
			gameState.armorDestructionEffectModifier += 3
			
		case "Epic Perk of Energy Surge":
			
			gameState.isEnergySurgePerkActive = true
			gameState.energySurgeEffectModifier += 15
			
		case "Epic Perk of Soul Extraction":
			
			gameState.isSoulExtractionPerkActive = true
			gameState.soulExtractionEffectModifier += 0.15
			
		case "Epic Perk of Greed":
			
			gameState.isGreedPerkActive = true
			gameState.greedPerkEffectModifier += 0.15
			
		case "Epic Perk of Crushing Blow":
			
			gameState.isCrushingBlowPerkActive = true
			gameState.crushingBlowEffectModifier += 15
			
		case "Epic Perk of Swiftness":
			
			gameState.isSwiftnessPerkActive = true
			gameState.swiftnessPerkEffectModifier += 15
			
			// MARK: - Legendary Perks
			
		case "Legendary Perk Of Sharpness":
			
			gameState.hero.baseMinDamage += 5
			gameState.hero.baseMaxDamage += 5
			
		case "Legendary Perk Of Vitality":
			
			gameState.hero.baseMaxHP += 80
			gameState.hero.baseMaxMP += 80
			
		case "Legendary Perk Of Precision":
			
			gameState.hero.baseCritChance += 4
			gameState.hero.baseHitChance += 4
			
		case "Legendary Perk of Brutality":
			
			gameState.hero.baseArmorPenetration += 10
			
		case "Legendary Perk of Reaction":
			
			gameState.hero.baseChanceStartTurnFirst += 25
			
		case "Legendary Perk of Savagery":
			
			gameState.hero.baseAttackDamageModifier += 0.3
			gameState.hero.baseComboDamageModifier += 0.3
			
		case "Legendary Perk of Protection":
			
			gameState.minBlockValue += 10
			gameState.maxBlockValue += 10
			
		case "Legendary Perk of Wisdom":
			
			gameState.hero.baseSpellPower += 15
			
		case "Legendary Perk of Critical Hit":
			
			gameState.hero.baseCritEffectModifier += 0.4
			
		case "Legendary Perk of Preparation":
			
			gameState.isPrepPerkActive = true
			gameState.prepPerkEffectModifier += 2.0
			
		case "Legendary Perk of Ill Word":
			
			gameState.isIllWordPerkActive = true
			gameState.illWordPerkEffectModifier += 1.0
			
		case "Legendary Perk of Reflection":
			
			gameState.isReflectionPerkActive = true
			gameState.reflectionPerkEffectModifier += 0.4
			
		case "Legendary Perk of Vampirism":
			
			gameState.isVampirismPerkActive = true
			gameState.vampirismEffectModifier += 0.2
			
		case "Legendary Perk of Spell Stealing":
			
			gameState.isSpellStealingPerkActive = true
			gameState.spellStealingEffectModifier += 0.2
			
		case "Legendary Perk of Blood Bath":
			
			gameState.isBloodBathPerkActive = true
			gameState.bloodBathPerkEffectModifier += 1
			
		case "Legendary Perk of Fortitude":
			
			gameState.isFortitudePerkActive = true
			gameState.fortitudeEffectModifier += 15
			
		case "Legendary Perk of Resilience":
			
			gameState.isResiliencePerkActive = true
			gameState.resilienceEffectModifier += 15
			
		case "Legendary Perk of Armor Destruction":
			
			gameState.isArmorDestructionPerkActive = true
			gameState.armorDestructionEffectModifier += 5
			
		case "Legendary Perk of Energy Surge":
			
			gameState.isEnergySurgePerkActive = true
			gameState.energySurgeEffectModifier += 25
			
		case "Legendary Perk of Soul Extraction":
			
			gameState.isSoulExtractionPerkActive = true
			gameState.soulExtractionEffectModifier += 0.25
			
		case "Legendary Perk of Greed":
			
			gameState.isGreedPerkActive = true
			gameState.greedPerkEffectModifier += 0.25
			
		case "Legendary Perk of Crushing Blow":
			
			gameState.isCrushingBlowPerkActive = true
			gameState.crushingBlowEffectModifier += 25
			
		case "Legendary Perk of Swiftness":
			
			gameState.isSwiftnessPerkActive = true
			gameState.swiftnessPerkEffectModifier += 25
			
		default:
			print("Something went wrong with perk selection")
			
		}
		
		gameState.selectedLevelPerks.append(perk)
		gameState.levelPerkToDisplay = nil
		gameState.levelPerksToChoose = []
		generateMerchantLoot()
		goToMerchant()
	}
}
