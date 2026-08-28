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
	var nameEN: String
	var nameRU: String
	var flaskTalantDescriptionEN: String
	var flaskTalantDescriptionRU: String
	var darkEnergyLevelToUpgrade: Int
	var beenUpgraded = false
	
	init(id: String,
		 nameEN: String,
		 nameRU: String,
		 flaskTalantDescriptionEN: String,
		 flaskTalantDescriptionRU: String,
		 darkEnergyLevelToUpgrade: Int
	) {
//		self.id = UUID()
		self.id = id
		self.nameEN = nameEN
		self.nameRU = nameRU
		self.flaskTalantDescriptionEN = flaskTalantDescriptionEN
		self.flaskTalantDescriptionRU = flaskTalantDescriptionRU
		self.darkEnergyLevelToUpgrade = darkEnergyLevelToUpgrade
	}
}

struct FlaskTalantManager {
	
	static let minorTalants: [FlaskTalant] = [
		
		// Base talant to gain ability to collect combat impact from 0 to 100 and return some dark energy or EP
		FlaskTalant(
			id: "soulCollector",
			nameEN: "Soul Collector",
			nameRU: "Собиратель Душ",
			flaskTalantDescriptionEN: "Flask gains ability to collect damage done, damage received, healing done, block value after skill use. When it reach 50, gain some dark energy or 1 extra EP",
			flaskTalantDescriptionRU: "Фляга получает способность собирать эффекты нанесения, получения урона, величины силы блока и лечения во время боя. После достижения показателя 50 единиц, позволяет высвободить эффект в виде небольшого количества темной энергии или 1 очка действия",
			darkEnergyLevelToUpgrade: 0
		),
		
		FlaskTalant(
			id: "minorTalantOfRecovery",
			nameEN: "Minor Talant of Recovery",
			nameRU: "Небольшой Талант Восстановления",
			flaskTalantDescriptionEN: "+5% of flask healing value",
			flaskTalantDescriptionRU: "+5% к эффекту лечения",
			darkEnergyLevelToUpgrade: 100
		),
		
		FlaskTalant(
			id: "minorTalantOfSharpness",
			nameEN: "Minor Talant of Sharness",
			nameRU: "Небольшой Талант Остроты",
			flaskTalantDescriptionEN: "+5% of flask damage value",
			flaskTalantDescriptionRU: "+5% к силе эффекта нанесения урона",
			darkEnergyLevelToUpgrade: 200
		),
		
		FlaskTalant(
			id: "minorTalantOfSwiftness",
			nameEN: "Minor Talant of Swiftness",
			nameRU: "Небольшой Талант Стремительности",
			flaskTalantDescriptionEN: "-1 turn to flask CoolDown reset",
			flaskTalantDescriptionRU: "-1 ход до восстановления способностей фляги",
			darkEnergyLevelToUpgrade: 300
		),
		
		FlaskTalant(
			id: "minorTalantOfSoulCollection",
			nameEN: "Minor Talant of Soul Collection",
			nameRU: "Небольшой Талант Вместилища Душ",
			flaskTalantDescriptionEN: "+1 flask charge capacity",
			flaskTalantDescriptionRU: "+1 к максимальному количеству зарядов фляги",
			darkEnergyLevelToUpgrade: 400
		)
	]
	
	static let mediumTalants: [FlaskTalant] = [
		
		FlaskTalant(
			id: "soulExtractor",
			nameEN: "Soul Extractor",
			nameRU: "Извлекатель Душ",
			flaskTalantDescriptionEN: "Flask gains ability to collect damage done, damage received, healing done, block value after skill use. When it reach 100, gain some dark energy or 1 extra EP + 10% healing of max HP/10% damage of target max HP",
			flaskTalantDescriptionRU: "Фляга получает способность собирать эффекты нанесения, получения урона, величины силы блока и лечения во время боя. После достижения показателя 100 единиц, позволяет высвободить эффект в виде небольшого количества темной энергии или 1 очка действия а также восстановить 10% от максимального здоровья героя или нанести 10% от максимального здоровья противника в качестве урона",
			darkEnergyLevelToUpgrade: 500
		),
		
		FlaskTalant(
			id: "mediumTalantOfRecovery",
			nameEN: "Medium Talant of Recovery",
			nameRU: "Средний Талант Восстановления",
			flaskTalantDescriptionEN: "+5% of flask healing value",
			flaskTalantDescriptionRU: "+5% к силе эффекта лечения",
			darkEnergyLevelToUpgrade: 600
		),
		
		FlaskTalant(
			id: "mediumTalantOfSharpness",
			nameEN: "Medium Talant of Sharness",
			nameRU: "Средний Талант Остроты",
			flaskTalantDescriptionEN: "+5% of flask damage value",
			flaskTalantDescriptionRU: "+5% к силе эффекта нанесения урона",
			darkEnergyLevelToUpgrade: 700
		),
		
		FlaskTalant(
			id: "mediumTalantOfSwitness",
			nameEN: "Medium Talant of Swiftness",
			nameRU: "Средний Талант Стремительности",
			flaskTalantDescriptionEN: "-1 turn to flask CD reset",
			flaskTalantDescriptionRU: "-1 ход до восстановления способностей фляги",
			darkEnergyLevelToUpgrade: 800
		),
		
		FlaskTalant(
			id: "mediumTalantOfSoulExtraction",
			nameEN: "Medium Talant of Soul Extraction",
			nameRU: "Средний Талант Извлечения Душ",
			flaskTalantDescriptionEN: "+1 flask charge capacity",
			flaskTalantDescriptionRU: "+1 к максимальному количеству зарядов фляги",
			darkEnergyLevelToUpgrade: 900
		)
	]
	
	static let hugeTalants: [FlaskTalant] = [
		
		FlaskTalant(
			id: "soulEater",
			nameEN: "Soul Eater",
			nameRU: "Пожиратель Душ",
			flaskTalantDescriptionEN: "Flask gains ability to collect damage done, damage received, healing done, block value after skill use. When it reach 150, gain some dark energy or 1 extra EP + 10% healing of max HP/10% damage of target max HP + to empower next ability",
			flaskTalantDescriptionRU: "Фляга получает способность собирать эффекты нанесения, получения урона, величины силы блока и лечения во время боя. После достижения показателя 100 единиц, позволяет высвободить эффект в виде небольшого количества темной энергии или 1 очка действия а также восстановить 10% от максимального здоровья героя или нанести 10% от максимального здоровья противника в качестве урона. Также позволяет усилить следующую способность нанесения урона, лечения или блока.",
			darkEnergyLevelToUpgrade: 1000
		),
		
		FlaskTalant(
			id: "hugeTalantOfRecovery",
			nameEN: "Huge Talant of Recovery",
			nameRU: "Большой Талант Восстановления",
			flaskTalantDescriptionEN: "+5% of flask healing value",
			flaskTalantDescriptionRU: "+5% к силе эффекта лечения",
			darkEnergyLevelToUpgrade: 1100
		),
		
		FlaskTalant(
			id: "hugeTalantOfSharpness",
			nameEN: "Huge Talant of Sharness",
			nameRU: "Большой Талант Остроты",
			flaskTalantDescriptionEN: "+5% of flask damage value",
			flaskTalantDescriptionRU: "+5% к силе эффекта нанесения урона",
			darkEnergyLevelToUpgrade: 1200
		),
		
		FlaskTalant(
			id: "hugeTalantOfSwiftness",
			nameEN: "Huge Talant of Swiftness",
			nameRU: "Большой Талант Стремительности",
			flaskTalantDescriptionEN: "-1 turn to flask CD reset",
			flaskTalantDescriptionRU: "-1 ход до восстановления способностей фляги",
			darkEnergyLevelToUpgrade: 1300
		),
		
		FlaskTalant(
			id: "hugeTalantOfSoulDevouring",
			nameEN: "Huge Talant of Soul Devouring",
			nameRU: "Большой Талант Пожирателя Душ",
			flaskTalantDescriptionEN: "+1 flask charge capacity",
			flaskTalantDescriptionRU: "+1 к максимальному количеству зарядов фляги",
			darkEnergyLevelToUpgrade: 1400
		)
	]
	
	static let greatTalants: [FlaskTalant] = [
		
		FlaskTalant(
			id: "greatTalantOfEmpowering",
			nameEN: "Great Talant of Empowering",
			nameRU: "Великий Талант Мощи",
			flaskTalantDescriptionEN: "Flask gains ability to use some of existing shadow energy to empower one of hero abilities",
			flaskTalantDescriptionRU: "Фляга получает способность использовать часть имеющейся темной энергии для усиления способностей героя",
			darkEnergyLevelToUpgrade: 2000
		)
	]
}
