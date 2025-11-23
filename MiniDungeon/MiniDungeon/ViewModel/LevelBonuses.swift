import Foundation

extension MainViewModel {
	
	// MARK: - applyLevelBonus
	
	/// Method to apply bonus of choice when hero get a new level
	func applyLevelBonus(_ bonus: LevelBonus?) {
		
		guard let bonus = bonus else { return }
		
		switch bonus.name {
			
		// Common
			
		case "Common HP Bonus": gameState.hero.baseMaxHP += 5
		case "Common MP Bonus": gameState.hero.baseMaxMP += 5
		case "Common Min Damage Bonus": gameState.hero.baseMinDamage += 1
		case "Common Max Damage Bonus": gameState.hero.baseMaxDamage += 1
		case "Common Spell Power Bonus": gameState.hero.baseSpellPower += 1
			
		// Rare
			
		case "Rare Hit Chance Bonus": gameState.hero.baseHitChance += 1
		case "Rare Crit Chance Bonus": gameState.hero.baseCritChance += 1
		case "Rare Spell Power Bonus": gameState.hero.baseSpellPower += 3
		case "Rare Defence Bonus": gameState.hero.baseDefence += 1
		case "Rare Damage Bonus":
			gameState.hero.baseMinDamage += 1
			gameState.hero.baseMaxDamage += 1
		case "Rare MP Bonus": gameState.hero.baseMaxMP += 10
		case "Rare HP Bonus": gameState.hero.baseMaxHP += 10
			
		// Epic
		
		case "Epic Hit Chance Bonus": gameState.hero.baseHitChance += 2
		case "Epic Crit Chance Bonus": gameState.hero.baseCritChance += 2
		case "Epic Spell Power Bonus": gameState.hero.baseSpellPower += 5
		case "Epic Defence Bonus": gameState.hero.baseDefence += 2
		case "Epic Damage Bonus":
			gameState.hero.baseMinDamage += 2
			gameState.hero.baseMaxDamage += 2
		case "Epic MP Bonus": gameState.hero.baseMaxMP += 15
		case "Epic HP Bonus": gameState.hero.baseMaxHP += 15
			
		// Legendary
			
		case "Legendary Energy Bonus": gameState.hero.baseMaxEP += 1
		case "Legendary Hit Chance Bonus": gameState.hero.baseHitChance += 3
		case "Legendary Crit Chance Bonus": gameState.hero.baseCritChance += 3
		case "Legendary Spell Power Bonus": gameState.hero.baseSpellPower += 10
		case "Legendary Defence Bonus": gameState.hero.baseDefence += 3
		case "Legendary Damage Bonus":
			gameState.hero.baseMinDamage += 3
			gameState.hero.baseMaxDamage += 3
		case "Legendary MP Bonus": gameState.hero.baseMaxMP += 20
		case "Legendary HP Bonus": gameState.hero.baseMaxHP += 20
			
		default: fatalError("Something went wrong")
			
		}
		gameState.levelBonusToDisplay = nil
		gameState.levelBonusesToChoose = []
		gameState.hero.levelUP()
		goToDungeon()
	}
}
