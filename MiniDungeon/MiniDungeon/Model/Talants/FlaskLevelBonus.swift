import Foundation

/*
 MARK: Bonuses to add
 - spell power while on cd or for a few turns
 - max hp/mana while on cd or for a few turns
 - crit/hit chance while on cd or for a few turns
 
 */

// MARK: - FlaskLevelBonus

/// Entity to represent an effect player can choose after each flask level up
struct FlaskLevelBonus: Identifiable, Hashable, Codable {
	
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
struct FlaskLevelBonusManager {
	
	// MARK: commonLevelBonuses
	
	static private let commonLevelBonuses: [FlaskLevelBonus] = [
		
		FlaskLevelBonus(
			nameEN: "Common Healing Bonus",
			nameRU: "Обычный Бонус Лечения",
			bonusDescriptionEN: "+5% healing value",
			bonusDescriptionRU: "+5% к силе эффекта лечения",
			rarity: .common
		),
		
		FlaskLevelBonus(
			nameEN: "Common Damage Bonus",
			nameRU: "Обычный Бонус Урона",
			bonusDescriptionEN: "+5% damage value",
			bonusDescriptionRU: "+5% к силе эффекта нанесения урона",
			rarity: .common
		),

		FlaskLevelBonus(
			nameEN: "Common CoolDown Reduction Bonus",
			nameRU: "Обычный Бонус Восстановления",
			bonusDescriptionEN: "-1 turn to reset flask CoolDown",
			bonusDescriptionRU: "-1 ход до восставления способностей фляги",
			rarity: .common
		),
		
		FlaskLevelBonus(
			nameEN: "Common Charge Back Bonus",
			nameRU: "Обычный Бонус Перезарядки",
			bonusDescriptionEN: "+5% chance to get charge back after use",
			bonusDescriptionRU: "+5% к шансу вернуть заряд после использования фляги",
			rarity: .common
		),
		
		FlaskLevelBonus(
			nameEN: "Common CoolDown Reset Bonus",
			nameRU: "Обычный Бонус Обновления",
			bonusDescriptionEN: "+5% chance to get flask CD reset",
			bonusDescriptionRU: "+5% к шансу обнулить время восстановления способностей фляги после использования",
			rarity: .common
		),
		
	]
	
	static private let rareLevelBonuses: [FlaskLevelBonus] = [
		
		FlaskLevelBonus(
			nameEN: "Rare Healing Bonus",
			nameRU: "Редкий Бонус Лечения",
			bonusDescriptionEN: "+10% healing value",
			bonusDescriptionRU: "+10% к силе эффекта лечения",
			rarity: .rare
		),
		
		FlaskLevelBonus(
			nameEN: "Rare Damage Bonus",
			nameRU: "Редкий Бонус Урона",
			bonusDescriptionEN: "+10% damage value",
			bonusDescriptionRU: "+10% к силе эффекта нанесения урона",
			rarity: .rare
		),
		
		FlaskLevelBonus(
			nameEN: "Rare CoolDown Reduction Bonus",
			nameRU: "Редкий Бонус Восстановления",
			bonusDescriptionEN: "-2 turns to reset flask CD",
			bonusDescriptionRU: "-2 хода до восставления способностей фляги",
			rarity: .rare
		),
		
		FlaskLevelBonus(
			nameEN: "Rare Charge Back Bonus",
			nameRU: "Редкий Бонус Перезарядки",
			bonusDescriptionEN: "+10% to get flask charge back after use",
			bonusDescriptionRU: "+10: к шансу вернуть заряд после использования фляги",
			rarity: .rare
		),
		
		FlaskLevelBonus(
			nameEN: "Rare CoolDown Reset Bonus",
			nameRU: "Редкий Бонус Обновления",
			bonusDescriptionEN: "+10% to get flask CoolDown reset after use",
			bonusDescriptionRU: "+10% к шансу обнулить время восстановления способнстей после использования фляги",
			rarity: .rare
		),
		
		FlaskLevelBonus(
			nameEN: "Rare Damage Buff Bonus",
			nameRU: "Редкий Бонус Усиления Урона",
			bonusDescriptionEN: "+1 min and max damage while flask on CD",
			bonusDescriptionRU: "+1 к минимальному и максимальному урону, когда способности фляги недоступны",
			rarity: .rare
		),
		
		FlaskLevelBonus(
			nameEN: "Rare Armor Buff Bonus",
			nameRU: "Редкий Бонус Усиления Брони",
			bonusDescriptionEN: "+1 armor while flask on CD",
			bonusDescriptionRU: "+1 к броне, когда способности фляги недоступны",
			rarity: .rare
		),
		
		FlaskLevelBonus(
			nameEN: "Rare Damage Debuff Bonus",
			nameRU: "Редкий Бонус Ослабления Урона",
			bonusDescriptionEN: "-1 min and max damage to the enemy after use",
			bonusDescriptionRU: "-1 к минимальному и максимальному урону противника после нанесения урона с помощью фляги",
			rarity: .rare
		),
		
		FlaskLevelBonus(
			nameEN: "Rare Armor Debuff Bonus",
			nameRU: "Редкий Бонус Ослабления Брони",
			bonusDescriptionEN: "-1 armor to the target after use",
			bonusDescriptionRU: "-1 к броне противника после нанесения урона с помощью фляги",
			rarity: .rare
		)
		
	]
	
	static private let epicLevelBonuses: [FlaskLevelBonus] = [
		
		FlaskLevelBonus(
			nameEN: "Epic Healing Bonus",
			nameRU: "Эпический Бонус Лечения",
			bonusDescriptionEN: "+15% healing value",
			bonusDescriptionRU: "+15% к силе эффекта лечения",
			rarity: .epic
		),
		
		FlaskLevelBonus(
			nameEN: "Epic Damage Bonus",
			nameRU: "Эпический Бонус Урона",
			bonusDescriptionEN: "+15% damage value",
			bonusDescriptionRU: "+15% к силе эффекта нанесения урона",
			rarity: .epic
		),
		
		FlaskLevelBonus(
			nameEN: "Epic CoolDown Reduction Bonus",
			nameRU: "Эпический Бонус Восстановления",
			bonusDescriptionEN: "-4 turns to reset flask CD",
			bonusDescriptionRU: "-4 хода до восстановления способностей фляги",
			rarity: .epic
		),
		
		FlaskLevelBonus(
			nameEN: "Epic Charge Back Bonus",
			nameRU: "Эпический Бонус Перезарядки",
			bonusDescriptionEN: "+15% to get flask charge back after use",
			bonusDescriptionRU: "+15% к шансу вернуть заряд после использования фляги",
			rarity: .epic
		),
		
		FlaskLevelBonus(
			nameEN: "Epic CoolDown Reset Bonus",
			nameRU: "Эпический Бонус Обнуления",
			bonusDescriptionEN: "+15% to get flask CD reset after use",
			bonusDescriptionRU: "+15% к шансу обнулить время восстановления способностей фляги после использования",
			rarity: .epic
		),
		
		FlaskLevelBonus(
			nameEN: "Epic Damage Buff Bonus",
			nameRU: "Эпический Бонус Усиления Урона",
			bonusDescriptionEN: "+2 min and max damage while flask on CoolDown",
			bonusDescriptionRU: "+2 к минимальному и максимальному урону, когда способности фляги недоступны",
			rarity: .epic
		),
		
		FlaskLevelBonus(
			nameEN: "Epic Armor Buff Bonus",
			nameRU: "Эпический Бонус Усиления Брони",
			bonusDescriptionEN: "+2 armor while flask on CoolDown",
			bonusDescriptionRU: "+2 к броне, когда способности фляги недоступны",
			rarity: .epic
		),
		
		FlaskLevelBonus(
			nameEN: "Epic Damage Debuff Bonus",
			nameRU: "Эпический Бонус Ослабления Урона",
			bonusDescriptionEN: "-2 min and max damage to the enemy after use",
			bonusDescriptionRU: "-2 к минимальному и максимальному урону противника после нанесения урона с помощью фляги",
			rarity: .epic
		),
		
		FlaskLevelBonus(
			nameEN: "Epic Armor Debuff",
			nameRU: "Эпический Бонус Ослабления Брони",
			bonusDescriptionEN: "-2 armor to the enemy after use",
			bonusDescriptionRU: "-2 к броне противника после нанесения урона с помощью фляги",
			rarity: .epic
		),
		
		FlaskLevelBonus(
			nameEN: "Epic Flask Charge Bonus",
			nameRU: "Эпический Бонус Возврата Заряда",
			bonusDescriptionEN: "+1 max charges capacity",
			bonusDescriptionRU: "+1 к максимальному количеству зарядов фляги",
			rarity: .epic
		)
		
	]
	
	static private let legendaryLevelBonuses: [FlaskLevelBonus] = [
		
		FlaskLevelBonus(
			nameEN: "Legendary Healing Bonus",
			nameRU: "Легендарный Бонус Лечения",
			bonusDescriptionEN: "+20% healing value",
			bonusDescriptionRU: "+20% к силе эффекта лечения",
			rarity: .legendary
		),
		
		FlaskLevelBonus(
			nameEN: "Legendary Damage Bonus",
			nameRU: "Легендарный Бонус Урона",
			bonusDescriptionEN: "+20% damage value",
			bonusDescriptionRU: "+20% к эффекту нанесения урона",
			rarity: .legendary
		),
		
		FlaskLevelBonus(
			nameEN: "Legendary CoolDown Reduction Bonus",
			nameRU: "Легендарный Бонус Восстановления",
			bonusDescriptionEN: "-6 turns to reset Flask CoolDown",
			bonusDescriptionRU: "-6 ходов до восстановления способностей фляги",
			rarity: .legendary
		),
		
		FlaskLevelBonus(
			nameEN: "Legendary Charge Back Bonus",
			nameRU: "Легендарный Бонус Перезарядки",
			bonusDescriptionEN: "+20% to get charge back after use",
			bonusDescriptionRU: "+20% к шансу вернуть заряд фляги после использования",
			rarity: .legendary
		),
		
		FlaskLevelBonus(
			nameEN: "Legendary CoolDown Reset Bonus",
			nameRU: "Легендарный Бонус Восстановления",
			bonusDescriptionEN: "+20% to reset flask CD after use",
			bonusDescriptionRU: "+20% к шансу обнулить время восстановления способностей фляги после использования",
			rarity: .legendary
		),
		
		FlaskLevelBonus(
			nameEN: "Legendary Damage Buff Bonus",
			nameRU: "Легендарный Бонус Усиления Урона",
			bonusDescriptionEN: "+3 min and max damage while flask on CD",
			bonusDescriptionRU: "+3 к минимальному и максимальному урону, когда способности фляги недоступны",
			rarity: .legendary
		),
		
		FlaskLevelBonus(
			nameEN: "Legendary Armor Buff Bonus",
			nameRU: "Легендарный Бонус Усиления Брони",
			bonusDescriptionEN: "+3 armor while flask on CD",
			bonusDescriptionRU: "+3 к броне, когда способности фляги недоступны",
			rarity: .legendary
		),
		
		FlaskLevelBonus(
			nameEN: "Legendary Damage Debuff Bonus",
			nameRU: "Легендарный Бонус Ослабления Урона",
			bonusDescriptionEN: "-3 min and max damage to the enemy after use",
			bonusDescriptionRU: "-3 к минимальному и максимальному урону противника после нанесения урона с помощью фляги",
			rarity: .legendary
		),
		
		FlaskLevelBonus(
			nameEN: "Legendary Armor Debuff Bonus",
			nameRU: "Легендарный Бонус Ослабления Брони",
			bonusDescriptionEN: "-3 armor to the enemy after use",
			bonusDescriptionRU: "-3 к броне противника после нанесения урона с помощью фляги",
			rarity: .legendary
		),
		
		FlaskLevelBonus(
			nameEN: "Legendary Flask Charge Bonus",
			nameRU: "Легендарный Бонус Перезарядки",
			bonusDescriptionEN: "+2 max flask charges capacity",
			bonusDescriptionRU: "+2 к максимальному количеству зарядов фляги",
			rarity: .legendary
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
