import Foundation

/// Entity to store information about all possible shrines you can activate at the town
struct ShrineManager {
	
	// MARK: - Common Shrines
	
	static let commonShrines: [Shrine] = [
		
		Shrine(
			name: "Small Shrine of Health",
			shrineDescription: "+5 max health for each run", darkEnergyCost: 10
		),
		
		Shrine(
			name: "Small Shrine of Mana",
			shrineDescription: "+5 max mana for each run", darkEnergyCost: 10
		),
		
		Shrine(
			name: "Small Shrine of Claw",
			shrineDescription: "+1 max damage for each run", darkEnergyCost: 15
		),
		
		Shrine(
			name: "Small Shrine of Paw",
			shrineDescription: "+1 min damage for each run", darkEnergyCost: 15
		)
	]
	
	// MARK: - Rare Shrines
	
	static let rareShrines: [Shrine] = [
		
		Shrine(
			name: "Small Shrine of Alchemist Luck",
			shrineDescription: "A chance to get random common potion at the start of each run", darkEnergyCost: 25
		),
		
		Shrine(
			name: "Small Shrine of Sharpness",
			shrineDescription: "+1% crit chance for each run", darkEnergyCost: 25
		),
		
		Shrine(
			name: "Small Shrine of Focus",
			shrineDescription: "+1% hit chance for each run", darkEnergyCost: 25
		),
		
		Shrine(
			name: "Small Shrine of Warrior Luck",
			shrineDescription: "A chance to get random common weapon at the start of each run", darkEnergyCost: 25
		),
		
		Shrine(
			name: "Small Shrine of Wing",
			shrineDescription: "+2 spell power for each run", darkEnergyCost: 25
		),
		
		Shrine(
			name: "Shrine of Health",
			shrineDescription: "+10 max health for each run", darkEnergyCost: 25
		),
		
		Shrine(
			name: "Small Shrine of Guardian Luck",
			shrineDescription: "A chance to get random common armor at the start of each run", darkEnergyCost: 25
		),
		
		Shrine(
			name: "Shrine of Mana",
			shrineDescription: "+10 max mana for each run", darkEnergyCost: 25
		),
		
		Shrine(
			name: "Shrine of Claw",
			shrineDescription: "+2 max damage for each run", darkEnergyCost: 35
		),
		
		Shrine(
			name: "Shrine of Paw",
			shrineDescription: "+2 min damage for each run", darkEnergyCost: 35
		),
		
		Shrine(
			name: "Shrine of Protection",
			shrineDescription: "+1 defence for each run", darkEnergyCost: 35
		)
	]
	
	// MARK: - Epic Shrines
	
	static let epicShrines: [Shrine] = [
		
//		Shrine(
//			name: "Great Shrine of Profession",
//			description: "Opens a new class to choose at the start of each run", darkEnergyCost: 50
//		),
		
		Shrine(
			name: "Great Shrine of Health",
			shrineDescription: "+15 max health for each run", darkEnergyCost: 50
		),
		
		Shrine(
			name: "Great Shrine of Mana",
			shrineDescription: "+15 max mana for each run", darkEnergyCost: 50
		),
		
		Shrine(
			name: "Shrine of Alchemist Luck",
			shrineDescription: "A chance to get rare potion at the start of each run", darkEnergyCost: 60
		),
		
		Shrine(
			name: "Shrine of Sharpness",
			shrineDescription: "+2% crit chance for each run", darkEnergyCost: 60
		),
		
		Shrine(
			name: "Shrine of Focus",
			shrineDescription: "+2% hit chance for each run", darkEnergyCost: 60
		),
		
		Shrine(
			name: "Shrine of Warrior Luck",
			shrineDescription: "A chance to get rare weapon at the start of each run", darkEnergyCost: 60
		),
		
		Shrine(
			name: "Shrine of Wing",
			shrineDescription: "+5 spell power for each run", darkEnergyCost: 60
		),
		
		Shrine(
			name: "Great Shrine of Claw",
			shrineDescription: "+3 max damage for each run", darkEnergyCost: 70
		),
		
		Shrine(
			name: "Great Shrine of Paw",
			shrineDescription: "+3 min damage for each run", darkEnergyCost: 70
		),
		
		Shrine(
			name: "Shrine of Guardian Luck",
			shrineDescription: "A chance to get rare armor at the start of each run", darkEnergyCost: 60
		),
		
		Shrine(
			name: "Great Shrine of Protection",
			shrineDescription: "+2 defence for each run", darkEnergyCost: 75
		),
	]
	
	// MARK: - Legendary Shrines
	
	static let legendaryShrines: [Shrine] = [
		
		Shrine(
			name: "Shrine of Mystery",
			shrineDescription: "Removes Dark Energy Cost from any movements", darkEnergyCost: 100
		),
		
		Shrine(
			name: "Shrine of Shadow Greed",
			shrineDescription: "+25% of Dark Energy after killing an enemy", darkEnergyCost: 110
		),
		
		Shrine(
			name: "Great Shrine of Stamina",
			shrineDescription: "+1 ENERGY for each run", darkEnergyCost: 125
		),
		
//		Shrine(
//			name: "Great Shrine of Talant",
//			description: "Unlockes one new ability for each class", darkEnergyCost: 150
//		),
	]
}

// MARK: - Shrine

/// Entity to represent the building in the town which you can activate to get extra bonuses
struct Shrine: Identifiable, Hashable, Codable {
	
	var id: UUID
	var name: String
	var shrineDescription: String
	var darkEnergyCost: Int
	var beenUpgraded = false
	
	init(name: String,
		 shrineDescription: String,
		 darkEnergyCost: Int
	) {
		self.id = UUID()
		self.name = name
		self.shrineDescription = shrineDescription
		self.darkEnergyCost = darkEnergyCost
	}
}
