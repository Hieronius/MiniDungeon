import Foundation

struct LevelBonusManager {
	
	static private let commonLevelBonuses: [LevelBonus] = [
		
		LevelBonus(name: "Flat HP Bonus", description: "+5 max HP"),
		LevelBonus(name: "Flat MP Bonus", description: "+5 max MP")
	]
	
	static private let rareLevelBonuses: [LevelBonus] = [
		
		LevelBonus(name: "Great HP Bonus", description: "+10 max HP"),
		LevelBonus(name: "Great MP Bonus", description: "+10 max MP"),
		LevelBonus(name: "Great Damage Bonus", description: "+1 min and max Damage"),
		LevelBonus(name: "Great Defence Bonus", description: "+1 Defence"),
		LevelBonus(name: "Great Spell Power Bonus", description: "+1 Spell Power"),
		LevelBonus(name: "Great Crit Chance Bonus", description: "+1% Crit Chance"),
		LevelBonus(name: "Great Hit Chance Bonus", description: "+1% Hit Chance")
		
	]
	
	static private let epicLevelBonuses: [LevelBonus] = [
		
		LevelBonus(name: "Big HP Bonus", description: "+15 max HP"),
		LevelBonus(name: "Big MP Bonus", description: "+15 max MP"),
		LevelBonus(name: "Big Damage Bonus", description: "+2 min and max Damage"),
		LevelBonus(name: "Big Defence Bonus", description: "+2 Defence"),
		LevelBonus(name: "Big Spell Power Bonus", description: "+2 Spell Power"),
		LevelBonus(name: "Big Crit Chance Bonus", description: "+2% Crit Chance"),
		LevelBonus(name: "Big Hit Chance Bonus", description: "+2% Hit Chance")
	]
	
	static private let legendaryLevelBonuses: [LevelBonus] = [
		
		LevelBonus(name: "Perfect HP Bonus", description: "+20 max HP"),
		LevelBonus(name: "Perfect MP Bonus", description: "+20 max MP"),
		LevelBonus(name: "Perfect Damage Bonus", description: "+3 min and max Damage"),
		LevelBonus(name: "Perfect Defence Bonus", description: "+3 Defence"),
		LevelBonus(name: "Perfect Spell Power Bonus", description: "+3 Spell Power"),
		LevelBonus(name: "Perfect Crit Chance Bonus", description: "+3% Crit Chance"),
		LevelBonus(name: "Perfect Hit Chance Bonus", description: "+3% Hit Chance"),
		LevelBonus(name: "Perfect Energy Bonus", description: "+1 max Energy")
	]
	
	/// Method gets rarity of the level bonus and generates one accordingly
	static func generateLevelBonus(of rarity: Rarity) -> LevelBonus? {
		
		switch rarity {
			
		case .common: return self.commonLevelBonuses.randomElement()
		case .rare: return self.rareLevelBonuses.randomElement()
		case .epic: return self.epicLevelBonuses.randomElement()
		case .legendary: return self.legendaryLevelBonuses.randomElement()
		}
	}
	
	
}

struct LevelBonus: Identifiable, Hashable {
	
	var id = UUID()
	var name: String
	var description: String
}
