import Foundation

// MARK: - HeroLevelBonus

struct HeroLevelBonus: Identifiable, Hashable, Codable {
	
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
struct HeroLevelBonusManager {
	
	// MARK: commonLevelBonuses
	
	static private let commonLevelBonuses: [HeroLevelBonus] = [
		
		HeroLevelBonus(
			name: "Common HP Bonus",
			bonusDescription: "+5 max HP"
		),
		HeroLevelBonus(
			name: "Common MP Bonus",
			bonusDescription: "+5 max MP"
		),
		HeroLevelBonus(
			name: "Common Min Damage Bonus",
			bonusDescription: "+1 min damage"
		),
		HeroLevelBonus(
			name: "Common Max Damage Bonus",
			bonusDescription: "+1 max damage"
		),
		HeroLevelBonus(
			name: "Common Spell Power Bonus",
			bonusDescription: "+1 spell power"
		)
	]
	
	// MARK: rareLevelBonuses
	
	static private let rareLevelBonuses: [HeroLevelBonus] = [
		
		HeroLevelBonus(
			name: "Rare HP Bonus",
			bonusDescription: "+10 max HP"
		),
		HeroLevelBonus(
			name: "Rare MP Bonus",
			bonusDescription: "+10 max MP"
		),
		HeroLevelBonus(
			name: "Rare Damage Bonus",
			bonusDescription: "+1 min and max Damage"
		),
		HeroLevelBonus(
			name: "Rare Defence Bonus",
			bonusDescription: "+1 Defence"
		),
		HeroLevelBonus(
			name: "Rare Spell Power Bonus",
			bonusDescription: "+3 Spell Power"
		),
		HeroLevelBonus(
			name: "Rare Crit Chance Bonus",
			bonusDescription: "+1% Crit Chance"
		),
		HeroLevelBonus(
			name: "Rare Hit Chance Bonus",
			bonusDescription: "+1% Hit Chance"
		)
		
	]
	
	// MARK: epicLevelBonuses
	
	static private let epicLevelBonuses: [HeroLevelBonus] = [
		
		HeroLevelBonus(
			name: "Epic HP Bonus",
			bonusDescription: "+15 max HP"
		),
		HeroLevelBonus(
			name: "Epic MP Bonus",
			bonusDescription: "+15 max MP"
		),
		HeroLevelBonus(
			name: "Epic Damage Bonus",
			bonusDescription: "+2 min and max Damage"
		),
		HeroLevelBonus(
			name: "Epic Defence Bonus",
			bonusDescription: "+2 Defence"
		),
		HeroLevelBonus(
			name: "Epic Spell Power Bonus",
			bonusDescription: "+5 Spell Power"
		),
		HeroLevelBonus(
			name: "Epic Crit Chance Bonus",
			bonusDescription: "+2% Crit Chance"
		),
		HeroLevelBonus(
			name: "Epic Hit Chance Bonus",
			bonusDescription: "+2% Hit Chance"
		)
	]
	
	// MARK: legendaryLevelBonuses
	
	static private let legendaryLevelBonuses: [HeroLevelBonus] = [
		
		HeroLevelBonus(
			name: "Legendary HP Bonus",
			bonusDescription: "+20 max HP"
		),
		HeroLevelBonus(
			name: "Legendary MP Bonus",
			bonusDescription: "+20 max MP"
		),
		HeroLevelBonus(
			name: "Legendary Damage Bonus",
			bonusDescription: "+3 min and max Damage"
		),
		HeroLevelBonus(
			name: "Legendary Defence Bonus",
			bonusDescription: "+3 Defence"
		),
		HeroLevelBonus(
			name: "Legendary Spell Power Bonus",
			bonusDescription: "+10 Spell Power"
		),
		HeroLevelBonus(
			name: "Legendary Crit Chance Bonus",
			bonusDescription: "+3% Crit Chance"
		),
		HeroLevelBonus(
			name: "Legendary Hit Chance Bonus",
			bonusDescription: "+3% Hit Chance"
		),
		HeroLevelBonus(
			name: "Legendary Energy Bonus",
			bonusDescription: "+1 max Energy"
		)
	]
	
	// MARK: generateHeroLevelBonus
	
	/// Method gets rarity of the level bonus and generates one accordingly
	static func generateLevelBonus(
		of rarity: Rarity
	) -> HeroLevelBonus? {
		
		switch rarity {
			
		case .common: return self.commonLevelBonuses.randomElement()
		case .rare: return self.rareLevelBonuses.randomElement()
		case .epic: return self.epicLevelBonuses.randomElement()
		case .legendary: return self.legendaryLevelBonuses.randomElement()
		}
	}
	
	
}
