import Foundation

/*
 MARK: Bonuses to add
 - spell power while on cd or for a few turns
 - max hp/mana while on cd or for a few turns
 - crit/hit chance while on cd or for a few turns
 
 */

// MARK: - FlaskLevelBonus

struct FlaskLevelBonus: Identifiable, Hashable, Codable {
	
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
struct FlaskLevelBonusManager {
	
	// MARK: commonLevelBonuses
	
	static private let commonLevelBonuses: [FlaskLevelBonus] = [
		
		FlaskLevelBonus(
			name: "Common Healing Bonus",
			bonusDescription: "+5% healing value"
		),
		
		FlaskLevelBonus(
			name: "Common Damage Bonus",
			bonusDescription: "+5% damage value"
		),
		
		FlaskLevelBonus(
			name: "Common CD Reduction Bonus",
			bonusDescription: "-1 turn to reset flask CD"
		),
		
		FlaskLevelBonus(
			name: "Common Charge Back Bonus",
			bonusDescription: "+5% chance to get charge back after use"
		),
		
		FlaskLevelBonus(
			name: "Common CD Reset Bonus",
			bonusDescription: "+5% chance to get flask CD reset"
		),
		
	]
	
	static private let rareLevelBonuses: [FlaskLevelBonus] = [
		
		FlaskLevelBonus(
			name: "Rare Healing Bonus",
			bonusDescription: "+10% healing value"
		),
		
		FlaskLevelBonus(
			name: "Rare Damage Bonus",
			bonusDescription: "+10% damage value"
		),
		
		FlaskLevelBonus(
			name: "Rare CD Reduction Bonus",
			bonusDescription: "-2 turns to reset flask CD"
		),
		
		FlaskLevelBonus(
			name: "Rare Charge Back Bonus",
			bonusDescription: "+10% to get flask charge back after use"
		),
		
		FlaskLevelBonus(
			name: "Rare CD Reset Bonus",
			bonusDescription: "+10% to get flask CD reset after use"
		),
		
		FlaskLevelBonus(
			name: "Rare Damage Buff Bonus",
			bonusDescription: "+1 min and max damage while flask on CD"
		),
		
		FlaskLevelBonus(
			name: "Rare Armor Buff Bonus",
			bonusDescription: "+1 armor while flask on CD"
		),
		
		FlaskLevelBonus(
			name: "Rare Damage Debuff Bonus",
			bonusDescription: "-1 min and max damage to the target after use"
		),
		
		FlaskLevelBonus(
			name: "Rare Armor Debuff Bonus",
			bonusDescription: "-1 armor to the target after use"
		)
		
	]
	
	static private let epicLevelBonuses: [FlaskLevelBonus] = [
		
		FlaskLevelBonus(
			name: "Epic Healing Bonus",
			bonusDescription: "+15% healing value"
		),
		
		FlaskLevelBonus(
			name: "Epic Damage Bonus",
			bonusDescription: "+15% damage value"
		),
		
		FlaskLevelBonus(
			name: "Epic CD Reduction Bonus",
			bonusDescription: "-4 turns to reset flask CD"
		),
		
		FlaskLevelBonus(
			name: "Epic Charge Back Bonus",
			bonusDescription: "+15% to get flask charge back after use"
		),
		
		FlaskLevelBonus(
			name: "Epic CD Reset Bonus",
			bonusDescription: "+15% to get flask CD reset after use"
		),
		
		FlaskLevelBonus(
			name: "Epic Damage Buff Bonus",
			bonusDescription: "+2 min and max damage while flask on CD"
		),
		
		FlaskLevelBonus(
			name: "Epic Armor Buff Bonus",
			bonusDescription: "+2 armor while flask on CD"
		),
		
		FlaskLevelBonus(
			name: "Epic Damage Debuff Bonus",
			bonusDescription: "-2 min and max damage to the enemy after use"
		),
		
		FlaskLevelBonus(
			name: "Epic Armor Debuff",
			bonusDescription: "-2 armor to the enemy after use"
		),
		
		FlaskLevelBonus(
			name: "Epic Flask Charge Bonus",
			bonusDescription: "+1 max charges capacity"
		)
		
	]
	
	static private let legendaryLevelBonuses: [FlaskLevelBonus] = [
		
		FlaskLevelBonus(
			name: "Legendary Healing Bonus",
			bonusDescription: "+20% healing value"
		),
		
		FlaskLevelBonus(
			name: "Legendary Damage Bonus",
			bonusDescription: "+20% damage value"
		),
		
		FlaskLevelBonus(
			name: "Legendary CD Reduction Bonus",
			bonusDescription: "-6 turns to reset Flask CD"
		),
		
		FlaskLevelBonus(
			name: "Legendary Charge Back Bonus",
			bonusDescription: "+20% to get charge back after use"
		),
		
		FlaskLevelBonus(
			name: "Legendary CD Reset Bonus",
			bonusDescription: "+20% to reset flask CD after use"
		),
		
		FlaskLevelBonus(
			name: "Legendary Damage Buff Bonus",
			bonusDescription: "+3 min and max damage while flask on CD"
		),
		
		FlaskLevelBonus(
			name: "Legendary Armor Buff Bonus",
			bonusDescription: "+3 armor while flask on CD"
		),
		
		FlaskLevelBonus(
			name: "Legendary Damage Debuff Bonus",
			bonusDescription: "-3 min and max damage to the enemy after use"
		),
		
		FlaskLevelBonus(
			name: "Legendary Armor Debuff Bonus",
			bonusDescription: "-3 armor to the enemy after use"
		),
		
		FlaskLevelBonus(
			name: "Legendary Flask Charge Bonus",
			bonusDescription: "+2 max flask charges capacity"
		),
		
		// TODO: Add when the game will be done to avoid making it too complicated
		
//		FlaskLevelBonus(
//			name: "Legendary Abilities Buff Bonus",
//			bonusDescription: "Get extra bonus for each basic and combo abilities after use during the fight"
//		)
		
	]
	
	// MARK: generateFlaskLevelBonus
	
	/// Method gets rarity of the level bonus and generates one accordingly
	static func generateLevelBonus(
		of rarity: Rarity
	) -> FlaskLevelBonus? {
		
		switch rarity {
			
		case .common: return self.commonLevelBonuses.randomElement()
		case .rare: return self.rareLevelBonuses.randomElement()
		case .epic: return self.epicLevelBonuses.randomElement()
		case .legendary: return self.legendaryLevelBonuses.randomElement()
		}
	}
	
}
