import Foundation

extension MainViewModel {
	
	// MARK: - applyLevelBonus
	
	func applyLevelBonus(_ bonus: LevelBonus?) {
		
		guard let bonus = bonus else { return }
		
		switch bonus.name {
			
		// Common
			
		case "Flat HP Bonus": gameState.hero.baseMaxHP += 5
		case "Flat MP Bonus": gameState.hero.baseMaxMP += 5
		case "Flat Min Damage Bonus": gameState.hero.baseMinDamage += 1
		case "Flat Max Damage Bonus": gameState.hero.baseMaxDamage += 1
		case "Flat Spell Power Bonus": gameState.hero.baseSpellPower += 1
			
		// Rare
			
		case "Great Hit Chance Bonus": gameState.hero.baseHitChance += 1
		case "Great Crit Chance Bonus": gameState.hero.baseCritChance += 1
		case "Great Spell Power Bonus": gameState.hero.baseSpellPower += 1
		case "Great Defence Bonus": gameState.hero.baseDefence += 1
		case "Great Damage Bonus":
			gameState.hero.baseMinDamage += 1
			gameState.hero.baseMaxDamage += 1
		case "Great MP Bonus": gameState.hero.baseMaxMP += 10
		case "Great HP Bonus": gameState.hero.baseMaxHP += 10
			
		// Epic
		
		case "Big Hit Chance Bonus": gameState.hero.baseHitChance += 2
		case "Big Crit Chance Bonus": gameState.hero.baseCritChance += 2
		case "Big Spell Power Bonus": gameState.hero.baseSpellPower += 2
		case "Big Defence Bonus": gameState.hero.baseDefence += 2
		case "Big Damage Bonus":
			gameState.hero.baseMinDamage += 2
			gameState.hero.baseMaxDamage += 2
		case "Big MP Bonus": gameState.hero.baseMaxMP += 15
		case "Big HP Bonus": gameState.hero.baseMaxHP += 15
			
		// Legendary
			
		case "Perfect Energy Bonus": gameState.hero.baseMaxMP += 1
		case "Perfect Hit Chance Bonus": gameState.hero.baseHitChance += 3
		case "Perfect Crit Chance Bonus": gameState.hero.baseCritChance += 3
		case "Perfect Spell Power Bonus": gameState.hero.baseSpellPower += 3
		case "Perfect Defence Bonus": gameState.hero.baseDefence += 3
		case "Perfect Damage Bonus":
			gameState.hero.baseMinDamage += 3
			gameState.hero.baseMaxDamage += 3
		case "Perfect MP Bonus": gameState.hero.baseMaxMP += 20
		case "Perfect HP Bonus": gameState.hero.baseMaxHP += 20
			
		default: fatalError("Something went wrong")
			
		}
	}
}
