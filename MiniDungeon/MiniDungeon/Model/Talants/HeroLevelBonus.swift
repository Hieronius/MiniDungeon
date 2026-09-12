import Foundation

// MARK: - HeroLevelBonus

/// Entity to describe a bonus hero can choose after each level up
struct HeroLevelBonus: Identifiable, Hashable, Codable {
	
	var id: UUID
	var nameEN: String
	var nameRU: String
	var bonusDescriptionEN: String
	var bonusDescriptionRU: String
	var rarity: Rarity
	
	init(nameEN: String,
		 nameRU: String,
		 bonusDescriptionEN: String,
		 bonusDescriptionRU: String,
		 rarity: Rarity
	) {
		self.id = UUID()
		self.nameEN = nameEN
		self.nameRU = nameRU
		self.bonusDescriptionEN = bonusDescriptionEN
		self.bonusDescriptionRU = bonusDescriptionRU
		self.rarity = rarity
	}
}

// MARK: - LevelBonusManager

/// Data type to store all possible bonuses you can get after the level up
struct HeroLevelBonusManager {
	
	// MARK: commonLevelBonuses
	
	static private let commonLevelBonuses: [HeroLevelBonus] = [
		
		HeroLevelBonus(
			nameEN: "Common HP Bonus",
			nameRU: "Обычный Бонус Здоровья",
			bonusDescriptionEN: "+5 max HP",
			bonusDescriptionRU: "+5 к максимальному уровню здоровья",
			rarity: .common
		),
		HeroLevelBonus(
			nameEN: "Common MP Bonus",
			nameRU: "Обычный Бонус Маны",
			bonusDescriptionEN: "+5 max MP",
			bonusDescriptionRU: "+5 к максимальному уровню маны",
			rarity: .common
		),
		HeroLevelBonus(
			nameEN: "Common Min Damage Bonus",
			nameRU: "Обычный Бонус Урона",
			bonusDescriptionEN: "+1 min damage",
			bonusDescriptionRU: "+1 к минимальному урону",
			rarity: .common
		),
		HeroLevelBonus(
			nameEN: "Common Max Damage Bonus",
			nameRU: "Обычный Бонус Повреждений",
			bonusDescriptionEN: "+1 max damage",
			bonusDescriptionRU: "+1 к максимальному урону",
			rarity: .common
		),
		HeroLevelBonus(
			nameEN: "Common Spell Power Bonus",
			nameRU: "Обычный Бонус Силы Заклинаний",
			bonusDescriptionEN: "+1 spell power",
			bonusDescriptionRU: "+1 к силе заклинаний",
			rarity: .common
		)
	]
	
	// MARK: rareLevelBonuses
	
	static private let rareLevelBonuses: [HeroLevelBonus] = [
		
		HeroLevelBonus(
			nameEN: "Rare HP Bonus",
			nameRU: "Редкий Бонус Здоровья",
			bonusDescriptionEN: "+10 max HP",
			bonusDescriptionRU: "+10 к максимальному уровню здоровья",
			rarity: .rare
		),
		HeroLevelBonus(
			nameEN: "Rare MP Bonus",
			nameRU: "Редкий Бонус Маны",
			bonusDescriptionEN: "+10 max MP",
			bonusDescriptionRU: "+10 к максимальному уроню маны",
			rarity: .rare
		),
		HeroLevelBonus(
			nameEN: "Rare Damage Bonus",
			nameRU: "Редкий Бонус Урона",
			bonusDescriptionEN: "+1 min and max Damage",
			bonusDescriptionRU: "+1 к минимальному и максимальному урону",
			rarity: .rare
		),
		HeroLevelBonus(
			nameEN: "Rare Defence Bonus",
			nameRU: "Редкий Бонус Защиты",
			bonusDescriptionEN: "+1 Defence",
			bonusDescriptionRU: "+1 к защите",
			rarity: .rare
		),
		HeroLevelBonus(
			nameEN: "Rare Spell Power Bonus",
			nameRU: "Редкий Бонус Силы Заклинаний",
			bonusDescriptionEN: "+3 Spell Power",
			bonusDescriptionRU: "+3 к силе заклинаний",
			rarity: .rare
		),
		HeroLevelBonus(
			nameEN: "Rare Crit Chance Bonus",
			nameRU: "Редкий Бонус Критических Ударов",
			bonusDescriptionEN: "+1% Crit Chance",
			bonusDescriptionRU: "+1% к шансу критического удара",
			rarity: .rare
		),
		HeroLevelBonus(
			nameEN: "Rare Hit Chance Bonus",
			nameRU: "Редкий Бонус Меткости",
			bonusDescriptionEN: "+1% Hit Chance",
			bonusDescriptionRU: "+1% к шансу попадения по противнику",
			rarity: .rare
		)
		
	]
	
	// MARK: epicLevelBonuses
	
	static private let epicLevelBonuses: [HeroLevelBonus] = [
		
		HeroLevelBonus(
			nameEN: "Epic HP Bonus",
			nameRU: "Эпический Бонус Здоровья",
			bonusDescriptionEN: "+15 max HP",
			bonusDescriptionRU: "+15 к максимальному уровню здоровья",
			rarity: .epic
		),
		HeroLevelBonus(
			nameEN: "Epic MP Bonus",
			nameRU: "Эпический Бонус Маны",
			bonusDescriptionEN: "+15 max MP",
			bonusDescriptionRU: "+15 к максимальному уровню маны",
			rarity: .epic
		),
		HeroLevelBonus(
			nameEN: "Epic Damage Bonus",
			nameRU: "Эпический Бонус Урона",
			bonusDescriptionEN: "+2 min and max Damage",
			bonusDescriptionRU: "+2 к минимальному и максимальному урону",
			rarity: .epic
		),
		HeroLevelBonus(
			nameEN: "Epic Defence Bonus",
			nameRU: "Эпический Бонус Защиты",
			bonusDescriptionEN: "+2 Defence",
			bonusDescriptionRU: "+2 к защите",
			rarity: .epic
		),
		HeroLevelBonus(
			nameEN: "Epic Spell Power Bonus",
			nameRU: "Эпический Бонус Силы Заклинаний",
			bonusDescriptionEN: "+5 Spell Power",
			bonusDescriptionRU: "+5 к силе заклинаний",
			rarity: .epic
		),
		HeroLevelBonus(
			nameEN: "Epic Crit Chance Bonus",
			nameRU: "Эпический Бонус Критического Удара",
			bonusDescriptionEN: "+2% Crit Chance",
			bonusDescriptionRU: "+2% к шансу критического удара",
			rarity: .epic
		),
		HeroLevelBonus(
			nameEN: "Epic Hit Chance Bonus",
			nameRU: "Эпический Бонус Точности",
			bonusDescriptionEN: "+2% Hit Chance",
			bonusDescriptionRU: "+2% к шансу попадения по противнику",
			rarity: .epic
		)
	]
	
	// MARK: legendaryLevelBonuses
	
	static private let legendaryLevelBonuses: [HeroLevelBonus] = [
		
		HeroLevelBonus(
			nameEN: "Legendary HP Bonus",
			nameRU: "Легендарный Бонус Здоровья",
			bonusDescriptionEN: "+20 max HP",
			bonusDescriptionRU: "+20 к максимальному уровню здоровья",
			rarity: .legendary
		),
		HeroLevelBonus(
			nameEN: "Legendary MP Bonus",
			nameRU: "Легендарный Бонус Маны",
			bonusDescriptionEN: "+20 max MP",
			bonusDescriptionRU: "+20 к максимальному уровню маны",
			rarity: .legendary
		),
		HeroLevelBonus(
			nameEN: "Legendary Damage Bonus",
			nameRU: "Легендарный Бонус Урона",
			bonusDescriptionEN: "+3 min and max Damage",
			bonusDescriptionRU: "+3 к минимальному и максимальному урону",
			rarity: .legendary
		),
		HeroLevelBonus(
			nameEN: "Legendary Defence Bonus",
			nameRU: "Легендарный Бонус Защиты",
			bonusDescriptionEN: "+3 Defence",
			bonusDescriptionRU: "+3 к защите",
			rarity: .legendary
		),
		HeroLevelBonus(
			nameEN: "Legendary Spell Power Bonus",
			nameRU: "Легендарный Бонус Силы Заклинаний",
			bonusDescriptionEN: "+10 Spell Power",
			bonusDescriptionRU: "+10 к силе закланий",
			rarity: .legendary
		),
		HeroLevelBonus(
			nameEN: "Legendary Crit Chance Bonus",
			nameRU: "Легендарный Бонус Критического Удара",
			bonusDescriptionEN: "+3% Crit Chance",
			bonusDescriptionRU: "+3% к шансу критического удара",
			rarity: .legendary
		),
		HeroLevelBonus(
			nameEN: "Legendary Hit Chance Bonus",
			nameRU: "Легендарный Бонус Точности",
			bonusDescriptionEN: "+3% Hit Chance",
			bonusDescriptionRU: "+3% к шансу попадения по противнику",
			rarity: .legendary
		),
		HeroLevelBonus(
			nameEN: "Legendary Energy Bonus",
			nameRU: "Легендарный Бонус Выносливости",
			bonusDescriptionEN: "+1 max Energy",
			bonusDescriptionRU: "+1 к МАКСИМАЛЬНОМУ УРОВНЮ ОЧКОВ ДЕЙСТВИЯ",
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
