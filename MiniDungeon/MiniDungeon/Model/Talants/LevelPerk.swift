/*
 
 File to brainstorm every possible perk to get after slaying level boss and 5th/10th/15th/20th/25th lvl major boss
 
 Include all levels of rarity you can get
 You can use any talant and create it's common/rare/epic/legendary version
 
 MARK: - List of Ideas
 
 - add value to block/heal/damage ✅
 - armor pen to attack ✅
 - extra crit value for heal/block ✅
 - reflect damage after block use (overall or for each enemy attack) ✅
 - add block value after it's use as a min-max damage to next attack ✅
 - add heal value after it's use as min-max damage to next attack ✅
 - attacks can heal for 100/50/25% of damage done ✅
 - attacks can restore mana for 100/50/25% of damage done ✅
 - each heal (1 max) per fight can increase max health by 1 ✅
 - each heal (1 max) per first can increase max mana health by 1 ✅
 - attack/heal/block buffs hero for specific stat/bonus ✅
 - attack/heal/block debuffs an enemy for specific stat/bonus ✅
 - chance to return EP after using heal/attack/block ✅
 - extra dark energy after use of some abilities or extracting it from enemy ✅
 - dark energy/gold/exp loot increase via talant ✅
 - chance to stun enemy after attack
 - chance to use double heal/block after its use ✅
 - attack bonus for using a specific type of weapon (sword/spear/axe/mace)
 - defence bonus for using a specific type of armor (cloth/leather/heavy armor)
 - extra space to avoid/parry during Evasion Mini Game
 - repost ability during block
 - Luck stat introduction
 - Poison/Bleeding effect for attacks
 - Extra chance to start fight first ✅
 */

import Foundation

// MARK: - LevelPerk

/// Entity to describe a perk user can choose after completion of each dungeon level
struct LevelPerk: Identifiable, Hashable, Codable {
	
	var id: UUID
	var name: String
	var perkDescription: String
	var rarity: Rarity
	
	init(name: String,
		 perkDescription: String,
		 rarity: Rarity
	) {
		self.id = UUID()
		self.name = name
		self.perkDescription = perkDescription
		self.rarity = rarity
	}
}

struct LevelPerkManager {
	
	// MARK: - Common Perks
	
	static private let commonPerks: [LevelPerk] = [
		
		LevelPerk(
			name: "Common Perk Of Sharpness",
			perkDescription: "+1 min damage, + 1 max damage",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk Of Vitality",
			perkDescription: "+10 HP, +10 MP",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk Of Precision",
			perkDescription: "+1% of crit chance, +1% of hit chance",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Brutality",
			perkDescription: "+2 armor penetration",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Reaction",
			perkDescription: "+5% chance to start fight first",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Savagery",
			perkDescription: "+10% to Attack and Combo Damage",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Protection",
			perkDescription: "+2 block value",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Wisdom",
			perkDescription: "+3 spell power",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Critical Hit",
			perkDescription: "+10% critical effect of attack/heal/block abilities",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Preparation",
			perkDescription: "Adds 50% of current block value as damage to next attack after using block ability",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Ill Word",
			perkDescription: "Adds 25% of heal value to next attack after using heal ability",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Reflection",
			perkDescription: "Reflect 10% of enemy damage while under block ability",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Vampirism",
			perkDescription: "Normal attacks can heal by 5% of damage done",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Spell Stealing",
			perkDescription: "Normal attacks can restore mana by 5% of damage done",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Fortitude",
			perkDescription: "Use of heal ability adds 3 block value to next Block ability",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Resilience",
			perkDescription: "Use of block ability adds 3 spell power to next Heal ability",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Armor Destruction",
			perkDescription: "Use of normal attacks deduct 1 enemy armor per each use",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Energy Surge",
			perkDescription: "Use of attack/block/heal has a 5% chance to get Energy Cost back",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Soul Extraction",
			perkDescription: "Critical attacks extract 5% of it's value as Dark Energy",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Greed",
			perkDescription: "+5% of dark energy, gold loot and experience gain",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Crushing Blow",
			perkDescription: "Normal Attacks have a 5% chance to remove 1 enemy EP for next turn",
			rarity: .common
		),
		
		LevelPerk(
			name: "Common Perk of Swiftness",
			perkDescription: "Attacks, heal and block abilities have a 5% chance to make a double effect after use",
			rarity: .common
		),
		
		
	]
	
	// MARK: - Rare Perks
	
	static private let rarePerks: [LevelPerk] = [
		
		LevelPerk(
			name: "Rare Perk Of Sharpness",
			perkDescription: "+2 min damage, +2 max damage",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk Of Vitality",
			perkDescription: "+20 HP, +20 MP",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk Of Precision",
			perkDescription: "+2% of crit chance, +2% of hit chance",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Brutality",
			perkDescription: "+4 armor penetration",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Reaction",
			perkDescription: "+10% chance to start fight first",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Savagery",
			perkDescription: "+15% to Attack and Combo Damage",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Protection",
			perkDescription: "+4 block value",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Wisdom",
			perkDescription: "+6 spell power",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Critical Hit",
			perkDescription: "+15% critical effect of attack/heal/block abilities",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Preparation",
			perkDescription: "Adds 100% of current block value as damage to next attack after using block ability",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Ill Word",
			perkDescription: "Adds 50% of heal value to next attack after using heal ability",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Reflection",
			perkDescription: "Reflect 15% of enemy damage while under block ability",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Vampirism",
			perkDescription: "Normal attacks can heal by 10% of damage done",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Spell Stealing",
			perkDescription: "Normal attacks can restore mana by 10% of damage done",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Fortitude",
			perkDescription: "Use of heal ability adds 6 block value to next Block ability (once per turn)",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Resilience",
			perkDescription: "Use of block ability adds 6 spell power to next Heal ability (once per turn)",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Armor Destruction",
			perkDescription:"Use of normal attacks deduct 2 enemy armor per each use",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Energy Surge",
			perkDescription: "Use of attack/block/heal has a 10% chance to get Energy Cost back",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Soul Extraction",
			perkDescription: "Critical attacks extract 10% of it's value as Dark Energy",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Greed",
			perkDescription: "+10% of dark energy, gold loot and experience gain",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Crushing Blow",
			perkDescription: "Normal Attacks have a 10% chance to remove 1 enemy EP for next turn",
			rarity: .rare
		),
		
		LevelPerk(
			name: "Rare Perk of Swiftness",
			perkDescription: "Attacks, heal and block abilities have a 10% chance to make a double effect after use",
			rarity: .rare
		),
		
	]
	
	// MARK: - Epic Perks
	
	static private let epicPerks: [LevelPerk] = [
		
		LevelPerk(
			name: "Epic Perk Of Sharpness",
			perkDescription: "+3 min damage, +3 max damage",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk Of Vitality",
			perkDescription: "+40 HP, +40 MP",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk Of Precision",
			perkDescription: "+3% of crit chance, +3% of hit chance",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Brutality",
			perkDescription: "+6 armor penetration",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Reaction",
			perkDescription: "+15% chance to start fight first",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Savagery",
			perkDescription: "+20% to Attack and Combo Damage",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Protection",
			perkDescription: "+6 block value",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Wisdom",
			perkDescription: "+10 spell power",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Critical Hit",
			perkDescription: "+25% critical effect of attack/heal/block abilities",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Preparation",
			perkDescription: "Adds 150% of current block value as damage to next attack after using block ability",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Ill Word",
			perkDescription: "Adds 75% of heal value to next attack after using heal ability",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Reflection",
			perkDescription: "Reflect 25% of enemy damage while under block ability",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Vampirism",
			perkDescription: "Normal attacks can heal by 15% of damage done",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Spell Stealing",
			perkDescription: "Normal attacks can restore mana by 15% of damage done",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Health Grow",
			perkDescription: "Each heal ability adds 1 hp tp max health. 1 unit per fight maximum",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Fortitude",
			perkDescription: "Use of heal ability adds 10 block value to next Block ability (once per turn",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Resilience",
			perkDescription: "Use of block ability adds 10 spell power to next Heal ability (once per turn)",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Armor Destruction",
			perkDescription:"Use of normal attacks deduct 3 enemy armor per each use",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Energy Surge",
			perkDescription: "Use of attack/block/heal has a 15% chance to get Energy Cost back",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Soul Extraction",
			perkDescription: "Critical attacks extract 15% of it's value as Dark Energy",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Greed",
			perkDescription: "+15% of dark energy, gold loot and experience gain",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Crushing Blow",
			perkDescription: "Normal Attacks have a 15% chance to remove 1 enemy EP for next turn",
			rarity: .epic
		),
		
		LevelPerk(
			name: "Epic Perk of Swiftness",
			perkDescription: "Attacks, heal and block abilities have a 15% chance to make a double effect after use",
			rarity: .epic
		),
		
	]
	
	// MARK: - Legendary Perks
	
	
	static private let legendaryPerks: [LevelPerk] = [
		
		LevelPerk(
			name: "Legendary Perk Of Sharpness",
			perkDescription: "+5 min damage, + 5 max damage",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk Of Vitality",
			perkDescription: "+80 HP, +80 MP",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk Of Precision",
			perkDescription: "+4% of crit chance, +4% of hit chance",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Brutality",
			perkDescription: "+10 armor penetration",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Reaction",
			perkDescription: "+25% chance to start fight first",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Savagery",
			perkDescription: "+30% to Attack and Combo Damage",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Protection",
			perkDescription: "+10 block value",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Wisdom",
			perkDescription: "+15 spell power",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Critical Hit",
			perkDescription: "+40% critical effect of attack/heal/block abilities",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Preparation",
			perkDescription: "Adds 200% of current block value as damage to next attack after using block ability",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Ill Word",
			perkDescription: "Adds 100% of heal value to next attack after using heal ability",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Reflection",
			perkDescription: "Reflect 40% of enemy damage while under block ability",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Vampirism",
			perkDescription: "Normal attacks can heal by 20% of damage done",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Spell Stealing",
			perkDescription: "Normal attacks can restore mana by 20% of damage done",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Blood Bath",
			perkDescription: "Each enemy kill adds 1 hp tp max health. 1 unit per enemy maximum",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Fortitude",
			perkDescription: "Use of heal ability adds 15 block value to next Block ability (once per turn)",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Resilience",
			perkDescription: "Use of block ability adds 15 spell power to next Heal ability (once per turn)",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Armor Destruction",
			perkDescription:"Use of normal attacks deduct 5 enemy armor per each use",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Energy Surge",
			perkDescription: "Use of attack/block/heal has a 25% chance to get Energy Cost back",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Soul Extraction",
			perkDescription: "Critical attacks extract 25% of it's value as Dark Energy",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Greed",
			perkDescription: "+25% of dark energy, gold loot and experience gain",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Crushing Blow",
			perkDescription: "Normal Attacks have a 25% chance to remove 1 enemy EP for next turn",
			rarity: .legendary
		),
		
		LevelPerk(
			name: "Legendary Perk of Swiftness",
			perkDescription: "Attacks, heal and block abilities have a 25% chance to make a double effect after use",
			rarity: .legendary
		),
	]
}

extension LevelPerkManager {
	
	// MARK: generateLevelPerk
	
	/// Method gets rarity of the level bonus and generates one accordingly
	static func generateLevelPerk(
		of rarity: Rarity
	) -> LevelPerk? {
		
		switch rarity {
			
		case .common: return self.commonPerks.randomElement()
		case .rare: return self.rarePerks.randomElement()
		case .epic: return self.epicPerks.randomElement()
		case .legendary: return self.legendaryPerks.randomElement()
		}
	}
}

