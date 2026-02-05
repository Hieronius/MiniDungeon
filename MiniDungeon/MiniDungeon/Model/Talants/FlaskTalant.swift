/*
 MARK: Talants Ideas i like:
 - Present a special capacity of the flask during the fight like 0/100
 - When you deal damage, heal or block you will get an amount of the effect added up to this capacity
 - When flask will be filled you can use a special move, for example to restore a charge or cd or to empower next ability
 - Or to get more dark energy from the fight outcome
 
 
 1. Base Talant. Flask able to collect up to 100 combat impact (heal/block/damage done/damage received) -> return energy or EP
 2. Minor improvements like +5% healing value, +5% damage value, -1 turn cd, +1 max capacity
 3. Advanced Talant. Flask able to collect up to 200 energy. Now can return even more energy or EP + 10% heal/damage accordingly to battle mode
 4. Minor improvements like +5% healing value, +5% damage value, -1 turn cd, +1 max capacity
 5. Final talant. Flask able to collect up to 300 energy. Returns more dark energy or EP + 10% heal/damage value + empower new ability
 6. Minor improvements like +5% healing value, +5% damage value, -1 turn cd, +1 max capacity
 7. Extra Bonus Talant -> Now flask can use dark energy to empower abilities once per turn. Like 25 energy or 10% of current capacity.
 8. A special talant which allows to keep some of the impact collected by flask move from one fight to another
 
 */

import Foundation

// MARK: - FlaskTalant

/// Entity to represent flask talant you can get after visiting the town
struct FlaskTalant: Identifiable, Hashable, Codable {
	
//	var id: UUID
	var id: String
	var name: String
	var flaskTalantDescription: String
	var darkEnergyLevelToUpgrade: Int
	var beenUpgraded = false
	
	init(id: String,
		name: String,
		 flaskTalantDescription: String,
		 darkEnergyLevelToUpgrade: Int
	) {
//		self.id = UUID()
		self.id = id
		self.name = name
		self.flaskTalantDescription = flaskTalantDescription
		self.darkEnergyLevelToUpgrade = darkEnergyLevelToUpgrade
	}
}

struct FlaskTalantManager {
	
	static let minorTalants: [FlaskTalant] = [
		
		// Base talant to gain ability to collect combat impact from 0 to 100 and return some dark energy or EP
		FlaskTalant(
			id: "soulCollector",
			name: "Soul Collector",
			flaskTalantDescription: "Flask gains ability to collect damage done, damage received, healing done, block value after skill use. When it reach 50, gain some dark energy or 1 extra EP",
			darkEnergyLevelToUpgrade: 0
		),
		
		FlaskTalant(
			id: "minorTalantOfRecovery",
			name: "Minor Talant of Recovery",
			flaskTalantDescription: "+5% of flask healing value",
			darkEnergyLevelToUpgrade: 100
		),
		
		FlaskTalant(
			id: "minorTalantOfSharpness",
			name: "Minor Talant of Sharness",
			flaskTalantDescription: "+5% of flask damage value",
			darkEnergyLevelToUpgrade: 200
		),
		
		FlaskTalant(
			id: "minorTalantOfSwiftness",
			name: "Minor Talant of Swiftness",
			flaskTalantDescription: "-1 turn to flask CD reset",
			darkEnergyLevelToUpgrade: 300
		),
		
		FlaskTalant(
			id: "minorTalantOfSoulCollection",
			name: "Minor Talant of Soul Collection",
			flaskTalantDescription: "+1 flask charge capacity",
			darkEnergyLevelToUpgrade: 400
		)
	]
	
	static let mediumTalants: [FlaskTalant] = [
		
		FlaskTalant(
			id: "soulExtractor",
			name: "Soul Extractor",
			flaskTalantDescription: "Flask gains ability to collect damage done, damage received, healing done, block value after skill use. When it reach 100, gain some dark energy or 1 extra EP + 10% healing of max HP/10% damage of target max HP",
			darkEnergyLevelToUpgrade: 500
		),
		
		FlaskTalant(
			id: "mediumTalantOfRecovery",
			name: "Medium Talant of Recovery",
			flaskTalantDescription: "+5% of flask healing value",
			darkEnergyLevelToUpgrade: 600
		),
		
		FlaskTalant(
			id: "mediumTalantOfSharpness",
			name: "Medium Talant of Sharness",
			flaskTalantDescription: "+5% of flask damage value",
			darkEnergyLevelToUpgrade: 700
		),
		
		FlaskTalant(
			id: "mediumTalantOfSwitness",
			name: "Medium Talant of Swiftness",
			flaskTalantDescription: "-1 turn to flask CD reset",
			darkEnergyLevelToUpgrade: 800
		),
		
		FlaskTalant(
			id: "mediumTalantOfSoulExtraction",
			name: "Medium Talant of Soul Extraction",
			flaskTalantDescription: "+1 flask charge capacity",
			darkEnergyLevelToUpgrade: 900
		)
	]
	
	static let hugeTalants: [FlaskTalant] = [
		
		FlaskTalant(
			id: "soulEater",
			name: "Soul Eater",
			flaskTalantDescription: "Flask gains ability to collect damage done, damage received, healing done, block value after skill use. When it reach 150, gain some dark energy or 1 extra EP + 10% healing of max HP/10% damage of target max HP + to empower next ability",
			darkEnergyLevelToUpgrade: 1000
		),
		
		FlaskTalant(
			id: "hugeTalantOfRecovery",
			name: "Huge Talant of Recovery",
			flaskTalantDescription: "+5% of flask healing value",
			darkEnergyLevelToUpgrade: 1100
		),
		
		FlaskTalant(
			id: "hugeTalantOfSharpness",
			name: "Huge Talant of Sharness",
			flaskTalantDescription: "+5% of flask damage value",
			darkEnergyLevelToUpgrade: 1200
		),
		
		FlaskTalant(
			id: "hugeTalantOfSwiftness",
			name: "Huge Talant of Swiftness",
			flaskTalantDescription: "-1 turn to flask CD reset",
			darkEnergyLevelToUpgrade: 1300
		),
		
		FlaskTalant(
			id: "hugeTalantOfSoulDevouring",
			name: "Huge Talant of Soul Devouring",
			flaskTalantDescription: "+1 flask charge capacity",
			darkEnergyLevelToUpgrade: 1400
		)
	]
	
	static let greatTalants: [FlaskTalant] = [
		
		FlaskTalant(
			id: "greatTalantOfEmpowering",
			name: "Great Talant of Empowering",
			flaskTalantDescription: "Flask gains ability to use some of existing shadow energy to empower one of hero abilities",
			darkEnergyLevelToUpgrade: 2000
		)
	]
}
