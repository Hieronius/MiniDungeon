import Foundation

// MARK: - LevelBonusManager

/// Data type to store all possible bonuses you can get after the level up
struct LevelBonusManager {
	
	// MARK: commonLevelBonuses
	
	static private let commonLevelBonuses: [LevelBonus] = [
		
		LevelBonus(
			name: "Common HP Bonus",
			description: "+5 max HP"
		),
		LevelBonus(
			name: "Common MP Bonus",
			description: "+5 max MP"
		),
		LevelBonus(
			name: "Common Min Damage Bonus",
			description: "+1 min damage"
		),
		LevelBonus(
			name: "Common Max Damage Bonus",
			description: "+1 max damage"
		),
		LevelBonus(
			name: "Common Spell Power Bonus",
			description: "+1 spell power"
		)
	]
	
	// MARK: rareLevelBonuses
	
	static private let rareLevelBonuses: [LevelBonus] = [
		
		LevelBonus(
			name: "Rare HP Bonus",
			description: "+10 max HP"
		),
		LevelBonus(
			name: "Rare MP Bonus",
			description: "+10 max MP"
		),
		LevelBonus(
			name: "Rare Damage Bonus",
			description: "+1 min and max Damage"
		),
		LevelBonus(
			name: "Rare Defence Bonus",
			description: "+1 Defence"
		),
		LevelBonus(
			name: "Rare Spell Power Bonus",
			description: "+3 Spell Power"
		),
		LevelBonus(
			name: "Rare Crit Chance Bonus",
			description: "+1% Crit Chance"
		),
		LevelBonus(
			name: "Rare Hit Chance Bonus",
			description: "+1% Hit Chance"
		)
		
	]
	
	// MARK: epicLevelBonuses
	
	static private let epicLevelBonuses: [LevelBonus] = [
		
		LevelBonus(
			name: "Epic HP Bonus",
			description: "+15 max HP"
		),
		LevelBonus(
			name: "Epic MP Bonus",
			description: "+15 max MP"
		),
		LevelBonus(
			name: "Epic Damage Bonus",
			description: "+2 min and max Damage"
		),
		LevelBonus(
			name: "Epic Defence Bonus",
			description: "+2 Defence"
		),
		LevelBonus(
			name: "Epic Spell Power Bonus",
			description: "+5 Spell Power"
		),
		LevelBonus(
			name: "Epic Crit Chance Bonus",
			description: "+2% Crit Chance"
		),
		LevelBonus(
			name: "Epic Hit Chance Bonus",
			description: "+2% Hit Chance"
		)
	]
	
	// MARK: legendaryLevelBonuses
	
	static private let legendaryLevelBonuses: [LevelBonus] = [
		
		LevelBonus(
			name: "Legendary HP Bonus",
			description: "+20 max HP"
		),
		LevelBonus(
			name: "Legendary MP Bonus",
			description: "+20 max MP"
		),
		LevelBonus(
			name: "Legendary Damage Bonus",
			description: "+3 min and max Damage"
		),
		LevelBonus(
			name: "Legendary Defence Bonus",
			description: "+3 Defence"
		),
		LevelBonus(
			name: "Legendary Spell Power Bonus",
			description: "+10 Spell Power"
		),
		LevelBonus(
			name: "Legendary Crit Chance Bonus",
			description: "+3% Crit Chance"
		),
		LevelBonus(
			name: "Legendary Hit Chance Bonus",
			description: "+3% Hit Chance"
		),
		LevelBonus(
			name: "Legendary Energy Bonus",
			description: "+1 max Energy"
		)
	]
	
	// MARK: generateLevelBonus
	
	/// Method gets rarity of the level bonus and generates one accordingly
	static func generateLevelBonus(
		of rarity: Rarity
	) -> LevelBonus? {
		
		switch rarity {
			
		case .common: return self.commonLevelBonuses.randomElement()
		case .rare: return self.rareLevelBonuses.randomElement()
		case .epic: return self.epicLevelBonuses.randomElement()
		case .legendary: return self.legendaryLevelBonuses.randomElement()
		}
	}
	
	
}

// MARK: - LevelBonus

struct LevelBonus: Identifiable, Hashable {
	
	var id = UUID()
	var name: String
	var description: String
}
