import Foundation

// MARK: - HeroLevelBonus

/// Entity to describe a bonus hero can choose after each level up
struct HeroLevelBonus: Identifiable, Hashable, Codable {
	
	var id: UUID
	var name: String
	var bonusDescription: String
	var rarity: Rarity
	
	init(name: String,
		 bonusDescription: String,
		 rarity: Rarity
	) {
		self.id = UUID()
		self.name = name
		self.bonusDescription = bonusDescription
		self.rarity = rarity
	}
}

// MARK: - LevelBonusManager

/// Data type to store all possible bonuses you can get after the level up
struct HeroLevelBonusManager {
	
	// MARK: commonLevelBonuses
	
	static private let commonLevelBonuses: [HeroLevelBonus] = [
		
		HeroLevelBonus(
			name: "Common HP Bonus",
			bonusDescription: "+5 max HP",
			rarity: .common
		),
		HeroLevelBonus(
			name: "Common MP Bonus",
			bonusDescription: "+5 max MP",
			rarity: .common
		),
		HeroLevelBonus(
			name: "Common Min Damage Bonus",
			bonusDescription: "+1 min damage",
			rarity: .common
		),
		HeroLevelBonus(
			name: "Common Max Damage Bonus",
			bonusDescription: "+1 max damage",
			rarity: .common
		),
		HeroLevelBonus(
			name: "Common Spell Power Bonus",
			bonusDescription: "+1 spell power",
			rarity: .common
		)
	]
	
	// MARK: rareLevelBonuses
	
	static private let rareLevelBonuses: [HeroLevelBonus] = [
		
		HeroLevelBonus(
			name: "Rare HP Bonus",
			bonusDescription: "+10 max HP",
			rarity: .rare
		),
		HeroLevelBonus(
			name: "Rare MP Bonus",
			bonusDescription: "+10 max MP",
			rarity: .rare
		),
		HeroLevelBonus(
			name: "Rare Damage Bonus",
			bonusDescription: "+1 min and max Damage",
			rarity: .rare
		),
		HeroLevelBonus(
			name: "Rare Defence Bonus",
			bonusDescription: "+1 Defence",
			rarity: .rare
		),
		HeroLevelBonus(
			name: "Rare Spell Power Bonus",
			bonusDescription: "+3 Spell Power",
			rarity: .rare
		),
		HeroLevelBonus(
			name: "Rare Crit Chance Bonus",
			bonusDescription: "+1% Crit Chance",
			rarity: .rare
		),
		HeroLevelBonus(
			name: "Rare Hit Chance Bonus",
			bonusDescription: "+1% Hit Chance",
			rarity: .rare
		)
		
	]
	
	// MARK: epicLevelBonuses
	
	static private let epicLevelBonuses: [HeroLevelBonus] = [
		
		HeroLevelBonus(
			name: "Epic HP Bonus",
			bonusDescription: "+15 max HP",
			rarity: .epic
		),
		HeroLevelBonus(
			name: "Epic MP Bonus",
			bonusDescription: "+15 max MP",
			rarity: .epic
		),
		HeroLevelBonus(
			name: "Epic Damage Bonus",
			bonusDescription: "+2 min and max Damage",
			rarity: .epic
		),
		HeroLevelBonus(
			name: "Epic Defence Bonus",
			bonusDescription: "+2 Defence",
			rarity: .epic
		),
		HeroLevelBonus(
			name: "Epic Spell Power Bonus",
			bonusDescription: "+5 Spell Power",
			rarity: .epic
		),
		HeroLevelBonus(
			name: "Epic Crit Chance Bonus",
			bonusDescription: "+2% Crit Chance",
			rarity: .epic
		),
		HeroLevelBonus(
			name: "Epic Hit Chance Bonus",
			bonusDescription: "+2% Hit Chance",
			rarity: .epic
		)
	]
	
	// MARK: legendaryLevelBonuses
	
	static private let legendaryLevelBonuses: [HeroLevelBonus] = [
		
		HeroLevelBonus(
			name: "Legendary HP Bonus",
			bonusDescription: "+20 max HP",
			rarity: .legendary
		),
		HeroLevelBonus(
			name: "Legendary MP Bonus",
			bonusDescription: "+20 max MP",
			rarity: .legendary
		),
		HeroLevelBonus(
			name: "Legendary Damage Bonus",
			bonusDescription: "+3 min and max Damage",
			rarity: .legendary
		),
		HeroLevelBonus(
			name: "Legendary Defence Bonus",
			bonusDescription: "+3 Defence",
			rarity: .legendary
		),
		HeroLevelBonus(
			name: "Legendary Spell Power Bonus",
			bonusDescription: "+10 Spell Power",
			rarity: .legendary
		),
		HeroLevelBonus(
			name: "Legendary Crit Chance Bonus",
			bonusDescription: "+3% Crit Chance",
			rarity: .legendary
		),
		HeroLevelBonus(
			name: "Legendary Hit Chance Bonus",
			bonusDescription: "+3% Hit Chance",
			rarity: .legendary
		),
		HeroLevelBonus(
			name: "Legendary Energy Bonus",
			bonusDescription: "+1 max Energy",
			rarity: .legendary
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
