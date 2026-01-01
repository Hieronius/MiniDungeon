import Foundation

// MARK: - LevelBonus

struct LevelBonus: Identifiable, Hashable, Codable {
	
	var id: UUID
	var name: String
	var bonusDescription: String
	
	init(name: String,
		 bonusDescription: String
	) {
		self.id = UUID()
		self.name = name
		self.bonusDescription = bonusDescription
	}
}

// MARK: - LevelBonusManager

/// Data type to store all possible bonuses you can get after the level up
struct LevelBonusManager {
	
	// MARK: commonLevelBonuses
	
	static private let commonLevelBonuses: [LevelBonus] = [
		
		LevelBonus(
			name: "Common HP Bonus",
			bonusDescription: "+5 max HP"
		),
		LevelBonus(
			name: "Common MP Bonus",
			bonusDescription: "+5 max MP"
		),
		LevelBonus(
			name: "Common Min Damage Bonus",
			bonusDescription: "+1 min damage"
		),
		LevelBonus(
			name: "Common Max Damage Bonus",
			bonusDescription: "+1 max damage"
		),
		LevelBonus(
			name: "Common Spell Power Bonus",
			bonusDescription: "+1 spell power"
		)
	]
	
	// MARK: rareLevelBonuses
	
	static private let rareLevelBonuses: [LevelBonus] = [
		
		LevelBonus(
			name: "Rare HP Bonus",
			bonusDescription: "+10 max HP"
		),
		LevelBonus(
			name: "Rare MP Bonus",
			bonusDescription: "+10 max MP"
		),
		LevelBonus(
			name: "Rare Damage Bonus",
			bonusDescription: "+1 min and max Damage"
		),
		LevelBonus(
			name: "Rare Defence Bonus",
			bonusDescription: "+1 Defence"
		),
		LevelBonus(
			name: "Rare Spell Power Bonus",
			bonusDescription: "+3 Spell Power"
		),
		LevelBonus(
			name: "Rare Crit Chance Bonus",
			bonusDescription: "+1% Crit Chance"
		),
		LevelBonus(
			name: "Rare Hit Chance Bonus",
			bonusDescription: "+1% Hit Chance"
		)
		
	]
	
	// MARK: epicLevelBonuses
	
	static private let epicLevelBonuses: [LevelBonus] = [
		
		LevelBonus(
			name: "Epic HP Bonus",
			bonusDescription: "+15 max HP"
		),
		LevelBonus(
			name: "Epic MP Bonus",
			bonusDescription: "+15 max MP"
		),
		LevelBonus(
			name: "Epic Damage Bonus",
			bonusDescription: "+2 min and max Damage"
		),
		LevelBonus(
			name: "Epic Defence Bonus",
			bonusDescription: "+2 Defence"
		),
		LevelBonus(
			name: "Epic Spell Power Bonus",
			bonusDescription: "+5 Spell Power"
		),
		LevelBonus(
			name: "Epic Crit Chance Bonus",
			bonusDescription: "+2% Crit Chance"
		),
		LevelBonus(
			name: "Epic Hit Chance Bonus",
			bonusDescription: "+2% Hit Chance"
		)
	]
	
	// MARK: legendaryLevelBonuses
	
	static private let legendaryLevelBonuses: [LevelBonus] = [
		
		LevelBonus(
			name: "Legendary HP Bonus",
			bonusDescription: "+20 max HP"
		),
		LevelBonus(
			name: "Legendary MP Bonus",
			bonusDescription: "+20 max MP"
		),
		LevelBonus(
			name: "Legendary Damage Bonus",
			bonusDescription: "+3 min and max Damage"
		),
		LevelBonus(
			name: "Legendary Defence Bonus",
			bonusDescription: "+3 Defence"
		),
		LevelBonus(
			name: "Legendary Spell Power Bonus",
			bonusDescription: "+10 Spell Power"
		),
		LevelBonus(
			name: "Legendary Crit Chance Bonus",
			bonusDescription: "+3% Crit Chance"
		),
		LevelBonus(
			name: "Legendary Hit Chance Bonus",
			bonusDescription: "+3% Hit Chance"
		),
		LevelBonus(
			name: "Legendary Energy Bonus",
			bonusDescription: "+1 max Energy"
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
