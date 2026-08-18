import Foundation

// MARK: - Shrine

/// Entity to represent the building in the town which you can activate to get extra bonuses
struct Shrine: Identifiable, Hashable, Codable {
	
//	var id: UUID
	var id: String
	var nameEN: String
	var nameRU: String
	var shrineDescriptionEN: String
	var shrineDescriptionRU: String
	var darkEnergyCost: Int
	var beenUpgraded = false
	
	init(id: String,
		nameEN: String,
		 nameRU: String,
		 shrineDescriptionEN: String,
		 shrineDescriptionRU: String,
		 darkEnergyCost: Int
	) {
//		self.id = UUID()
		self.id = id
		self.nameEN = nameEN
		self.nameRU = nameRU
		self.shrineDescriptionEN = shrineDescriptionEN
		self.shrineDescriptionRU = shrineDescriptionRU
		self.darkEnergyCost = darkEnergyCost
	}
}

/// Entity to store information about all possible shrines you can activate at the town
struct ShrineManager {
	
	// MARK: - Common Shrines
	
	static let commonShrines: [Shrine] = [
		
		Shrine(
			id: "smallShrineOfHealth",
			nameEN: "Small Shrine of Health",
			nameRU: "Небольшой Алтарь Здоровья",
			shrineDescriptionEN: "+5 max health for each run",
			shrineDescriptionRU: "+5 очков к максимальному уровню здоровья навсегда",
			darkEnergyCost: 20
		),
		
		Shrine(
			id: "smallShrineOfMana",
			nameEN: "Small Shrine of Mana",
			nameRU: "Небольшой Алтарь Маны",
			shrineDescriptionEN: "+5 max mana for each run",
			shrineDescriptionRU: "+5 очков к максимальному уровню маны навсегда",
			darkEnergyCost: 20
		),
		
		Shrine(
			id: "smallShrineOfClaw",
			nameEN: "Small Shrine of Claw",
			nameRU: "Небольшой Алтарь Когтя",
			shrineDescriptionEN: "+1 max damage for each run",
			shrineDescriptionRU: "+1 к максимальному урону навсегда",
			darkEnergyCost: 30
		),
		
		Shrine(
			id: "smallShrineOfPaw",
			nameEN: "Small Shrine of Paw",
			nameRU: "Небольшой Алтарь Лапы",
			shrineDescriptionEN: "+1 min damage for each run",
			shrineDescriptionRU: "+1 к минимальному урону навсегда",
			darkEnergyCost: 30
		)
	]
	
	// MARK: - Rare Shrines
	
	static let rareShrines: [Shrine] = [
		
		Shrine(
			id: "smallShrineOfAlchemist",
			nameEN: "Small Shrine of Alchemist Luck",
			nameRU: "Небольшой Алтарь Удачи Алхимика",
			shrineDescriptionEN: "A chance to get random common potion at the start of each run",
			shrineDescriptionRU: "Небольшой шанс получить случайное зелье обычного качества на старте каждого нового забега",
			darkEnergyCost: 50
		),
		
		Shrine(
			id: "smallShrineOfSharpness",
			nameEN: "Small Shrine of Sharpness",
			nameRU: "Небольшой Алтарь Остроты",
			shrineDescriptionEN: "+1% crit chance for each run",
			shrineDescriptionRU: "+1% шанса критического удара навсегда",
			darkEnergyCost: 50
		),
		
		Shrine(
			id: "smallShrineOfFocus",
			nameEN: "Small Shrine of Focus",
			nameRU: "Небольшой Алтарь Фокуса",
			shrineDescriptionEN: "+1% hit chance for each run",
			shrineDescriptionRU: "+1% к шансу попадения по противника навсегда",
			darkEnergyCost: 50
		),
		
		Shrine(
			id: "smallShrineOfWarrior",
			nameEN: "Small Shrine of Warrior Luck",
			nameRU: "Небольшой Алтарь Удачи Воина",
			shrineDescriptionEN: "A chance to get random common weapon at the start of each run",
			shrineDescriptionRU: "Небольшой шанс получить случайное оружие обычного качества на старте каждого забега",
			darkEnergyCost: 50
		),
		
		Shrine(
			id: "smallShrineOfWing",
			nameEN: "Small Shrine of Wing",
			nameRU: "Небольшой Алтарь Крыла",
			shrineDescriptionEN: "+2 spell power for each run",
			shrineDescriptionRU: "+2 очка к силе заклинаний навсегда",
			darkEnergyCost: 50
		),
		
		Shrine(
			id: "shrineOfHealth",
			nameEN: "Shrine of Health",
			nameRU: "Алтарь Здоровья",
			shrineDescriptionEN: "+10 max health for each run",
			shrineDescriptionRU: "+10 очков к максимальному уровню здоровья навсегда",
			darkEnergyCost: 50
		),
		
		Shrine(
			id: "smallShrineOfGuardian",
			nameEN: "Small Shrine of Guardian Luck",
			nameRU: "Небольшой Алтарь Удачи Защитника",
			shrineDescriptionEN: "A chance to get random common armor at the start of each run",
			shrineDescriptionRU: "Небольшой шанс получить случайную броню обычного качества в начале каждого забега",
			darkEnergyCost: 50
		),
		
		Shrine(
			id: "shrineOfMana",
			nameEN: "Shrine of Mana",
			nameRU: "Алтарь Маны",
			shrineDescriptionEN: "+10 max mana for each run",
			shrineDescriptionRU: "+10 очков к максимальному уровню маны навсегда",
			darkEnergyCost: 50
		),
		
		Shrine(
			id: "shrineOfClaw",
			nameEN: "Shrine of Claw",
			nameRU: "Алтарь Когтя",
			shrineDescriptionEN: "+2 max damage for each run",
			shrineDescriptionRU: "+2 к максимальному урону навсегда",
			darkEnergyCost: 70
		),
		
		Shrine(
			id: "shrineOfPaw",
			nameEN: "Shrine of Paw",
			nameRU: "Алтарь Лапы",
			shrineDescriptionEN: "+2 min damage for each run",
			shrineDescriptionRU: "+2 к минимальному урону навсегда",
			darkEnergyCost: 70
		),
		
		Shrine(
			id: "shrineOfProtection",
			nameEN: "Shrine of Protection",
			nameRU: "Алтарь Защиты",
			shrineDescriptionEN: "+1 defence for each run",
			shrineDescriptionRU: "+1 к защите навсегда",
			darkEnergyCost: 70
		)
	]
	
	// MARK: - Epic Shrines
	
	static let epicShrines: [Shrine] = [
		
//		Shrine(
//			name: "Great Shrine of Profession",
//			description: "Opens a new class to choose at the start of each run", darkEnergyCost: 50
//		),
		
		Shrine(
			id: "greatShrineOfHealth",
			nameEN: "Great Shrine of Health",
			nameRU: "Большой Алтарь Здоровья",
			shrineDescriptionEN: "+15 max health for each run",
			shrineDescriptionRU: "+15 к максимальному уровню здоровья навсегда",
			darkEnergyCost: 100
		),
		
		Shrine(
			id: "greatShrineOfMana",
			nameEN: "Great Shrine of Mana",
			nameRU: "Большой Алтарь Маны",
			shrineDescriptionEN: "+15 max mana for each run",
			shrineDescriptionRU: "+15 к максимальному уровню маны навсегда",
			darkEnergyCost: 100
		),
		
		Shrine(
			id: "shrineOfAlchemist",
			nameEN: "Shrine of Alchemist Luck",
			nameRU: "Алтарь Удачи Алхимика",
			shrineDescriptionEN: "A chance to get rare potion at the start of each run",
			shrineDescriptionRU: "Небольшой шанс получить зелье редкого качества на старте каждого забега",
			darkEnergyCost: 120
		),
		
		Shrine(
			id: "shrineOfSharpness",
			nameEN: "Shrine of Sharpness",
			nameRU: "Алтарь Остроты",
			shrineDescriptionEN: "+2% crit chance for each run",
			shrineDescriptionRU: "+2% к шансу критического удара навсегда",
			darkEnergyCost: 120
		),
		
		Shrine(
			id: "shrineOfFocus",
			nameEN: "Shrine of Focus",
			nameRU: "Алтарь Фокуса",
			shrineDescriptionEN: "+2% hit chance for each run",
			shrineDescriptionRU: "+2% к шансу попадения по противнику навсегда",
			darkEnergyCost: 120
		),
		
		Shrine(
			id: "shrineOfWarrior",
			nameEN: "Shrine of Warrior Luck",
			nameRU: "Алтарь Удачи Воина",
			shrineDescriptionEN: "A chance to get rare weapon at the start of each run",
			shrineDescriptionRU: "Небольшой шанс получить оружие редкого качества в начале каждого забега",
			darkEnergyCost: 120
		),
		
		Shrine(
			id: "shrineOfWing",
			nameEN: "Shrine of Wing",
			nameRU: "Алтарь Крыла",
			shrineDescriptionEN: "+5 spell power for each run",
			shrineDescriptionRU: "+5 к силе заклинаний навсегда",
			darkEnergyCost: 120
		),
		
		Shrine(
			id: "greatShrineOfClaw",
			nameEN: "Great Shrine of Claw",
			nameRU: "Большой Алтарь Когтя",
			shrineDescriptionEN: "+3 max damage for each run",
			shrineDescriptionRU: "+3 к максимальному урону навсегда",
			darkEnergyCost: 140
		),
		
		Shrine(
			id: "greatShrineOfPaw",
			nameEN: "Great Shrine of Paw",
			nameRU: "Большой Алтарь Лапы",
			shrineDescriptionEN: "+3 min damage for each run",
			shrineDescriptionRU: "+3 к минимальному урону навсегда",
			darkEnergyCost: 140
		),
		
		Shrine(
			id: "shrineOfGuardian",
			nameEN: "Shrine of Guardian Luck",
			nameRU: "Большой Алтарь Удачи Защитника",
			shrineDescriptionEN: "A chance to get rare armor at the start of each run",
			shrineDescriptionRU: "Небольшой шанс получить броню редкого качества в начале каждого забега",
			darkEnergyCost: 120
		),
		
		Shrine(
			id: "greatShrineOfProtection",
			nameEN: "Great Shrine of Protection",
			nameRU: "Большой Алтарь Защиты",
			shrineDescriptionEN: "+2 defence for each run",
			shrineDescriptionRU: "+2 к броне навсегда",
			darkEnergyCost: 150
		),
	]
	
	// MARK: - Legendary Shrines
	
	static let legendaryShrines: [Shrine] = [
		
//		Shrine(
//			name: "Shrine of Mystery",
//			shrineDescription: "Removes Dark Energy Cost from any movements", darkEnergyCost: 100
//		),
		
		Shrine(
			id: "shrineOfShadowGreed",
			nameEN: "Shrine of Shadow Greed",
			nameRU: "Алтарь Темной Жадности",
			shrineDescriptionEN: "+25% of Dark Energy after killing an enemy",
			shrineDescriptionRU: "+25% к количеству Темной Энергии в добыче после каждого убийства противника",
			darkEnergyCost: 250
		),
		
		Shrine(
			id: "greatShrineOfStamina",
			nameEN: "Great Shrine of Stamina",
			nameRU: "Большой Алтарь Выносливости",
			shrineDescriptionEN: "+1 ENERGY for each run",
			shrineDescriptionRU: "+1 очко к МАКСИМАЛЬНОМУ КОЛИЧЕСТВУ ОЧКОВ ДЕЙСТВИЯ",
			darkEnergyCost: 250
		),
		
//		Shrine(
//			name: "Great Shrine of Talant",
//			description: "Unlockes one new ability for each class", darkEnergyCost: 150
//		),
	]
}
