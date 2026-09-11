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
	var nameEN: String
	var nameRU: String
	var perkDescriptionEN: String
	var perkDescriptionRU: String
	var rarity: Rarity
	
	init(nameEN: String,
		 nameRU: String,
		 perkDescriptionEN: String,
		 perkDescriptionRU: String,
		 rarity: Rarity
	) {
		self.id = UUID()
		self.nameEN = nameEN
		self.nameRU = nameRU
		self.perkDescriptionEN = perkDescriptionEN
		self.perkDescriptionRU = perkDescriptionRU
		self.rarity = rarity
	}
}

struct LevelPerkManager {
	
	// MARK: - Common Perks
	
	static private let commonPerks: [LevelPerk] = [
		
		LevelPerk(
			nameEN: "Common Perk Of Sharpness",
			nameRU: "Обычный Перк Остроты",
			perkDescriptionEN: "+1 min damage, + 1 max damage",
			perkDescriptionRU: "+1 к минимальному и максимальному урону",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk Of Vitality",
			nameRU: "Обычный Перк Жизненных Сил",
			perkDescriptionEN: "+10 HP, +10 MP",
			perkDescriptionRU: "+10 к максимальному уровню здоровья и маны",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk Of Precision",
			nameRU: "Обычный Перк Точности",
			perkDescriptionEN: "+1% of crit chance, +1% of hit chance",
			perkDescriptionRU: "+1% к шансу критического удара и шансу попадения по противнику",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Brutality",
			nameRU: "Обычный Перк Жесткости",
			perkDescriptionEN: "+2 armor penetration",
			perkDescriptionRU: "+2 к эффекту пробивания брони",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Reaction",
			nameRU: "Обычный Перк Реакции",
			perkDescriptionEN: "+5% chance to start fight first",
			perkDescriptionRU: "+5% к шансу ходить первым во время боя",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Savagery",
			nameRU: "Обычный Перк Буйства",
			perkDescriptionEN: "+10% to Attack and Combo Damage",
			perkDescriptionRU: "+10% к силе атаки и эффекту комбо ударов",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Protection",
			nameRU: "Обычный Перк Защиты",
			perkDescriptionEN: "+2 block value",
			perkDescriptionRU: "+2 к эффекту блока",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Wisdom",
			nameRU: "Обычный Перк Мудрости",
			perkDescriptionEN: "+3 spell power",
			perkDescriptionRU: "+3 к силе заклинаний",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Critical Hit",
			nameRU: "Обычный Перк Критических Ударов",
			perkDescriptionEN: "+10% critical effect of attack/heal/block abilities",
			perkDescriptionRU: "+10% к критическим эффектам атаки/лечения/блока",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Preparation",
			nameRU: "Обычный Перк Подготовки",
			perkDescriptionEN: "Adds 50% of current block value as damage to next attack after using block ability",
			perkDescriptionRU: "50% эффекта способности блок усилит следующую обычную атаку",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Ill Word",
			nameRU: "Обычный Перк Злости",
			perkDescriptionEN: "Adds 25% of heal value to next attack after using heal ability",
			perkDescriptionRU: "25% эффекта способности лечение усилит следующую обычную атаку",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Reflection",
			nameRU: "Обычный Перк Отражения",
			perkDescriptionEN: "Reflect 10% of enemy damage while under block ability",
			perkDescriptionRU: "Во время действия способности блок противник получит в ответ 10% от силы своей атаки",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Vampirism",
			nameRU: "Обычный Перк Вампиризма",
			perkDescriptionEN: "Normal attacks can heal by 5% of damage done",
			perkDescriptionRU: "Обычные атаки теперь лечат в размере 5% от нанесенного урона",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Spell Stealing",
			nameRU: "Обычный Перк Похищения Маны",
			perkDescriptionEN: "Normal attacks can restore mana by 5% of damage done",
			perkDescriptionRU: "Обычные атаки теперь восстанавливают ману в размере 5% от нанесенного урона",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Fortitude",
			nameRU: "Обычный Перк Стойкости",
			perkDescriptionEN: "Use of heal ability adds 3 block value to next Block ability",
			perkDescriptionRU: "Использование способности лечение теперь добавляет 3 единицы к силе следующей способности блок",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Resilience",
			nameRU: "Обычный Перк Устойчивости",
			perkDescriptionEN: "Use of block ability adds 3 spell power to next Heal ability",
			perkDescriptionRU: "Использование способности блок теперь добавляет 3 силы заклинаний к эффекту следущей способности лечение",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Armor Destruction",
			nameRU: "Обычный Перк Разрушения Брони",
			perkDescriptionEN: "Use of normal attacks deduct 1 enemy armor per each use",
			perkDescriptionRU: "Обычные атаки теперь снижают броню противника на 1 после каждого успешного попадения",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Energy Surge",
			nameRU: "Обычный Перк Всплеска Энергии",
			perkDescriptionEN: "Use of attack/block/heal has a 5% chance to get Energy Cost back",
			perkDescriptionRU: "Использование способностей блок/лечение/атаки теперь имеет 5% шанс вернуть очко действие",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Soul Extraction",
			nameRU: "Обычный Перк Извлечения Души",
			perkDescriptionEN: "Critical attacks extract 5% of it's value as Dark Energy",
			perkDescriptionRU: "Критические удары теперь извлекают темную энергию в размере 5% от нанесенного урона",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Greed",
			nameRU: "Обычный Перк Жадности",
			perkDescriptionEN: "+5% of dark energy, gold loot and experience gain",
			perkDescriptionRU: "+5% к любым источникам темной энергии, золота и опыта",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Crushing Blow",
			nameRU: "Обычный Перк Сокрушающих Ударов",
			perkDescriptionEN: "Normal Attacks have a 5% chance to remove 1 enemy EP for next turn",
			perkDescriptionRU: "Обычные атаки теперь имеют 5% шанс снять одно очко действия противника во время следующего хода",
			rarity: .common
		),
		
		LevelPerk(
			nameEN: "Common Perk of Swiftness",
			nameRU: "Обычный Перк Стремительности",
			perkDescriptionEN: "Attacks, heal and block abilities have a 5% chance to make a double effect after use",
			perkDescriptionRU: "Обычные атаки, лечение и блок теперь имеют 5% шанс на двойной эффект после использования",
			rarity: .common
		),
		
		
	]
	
	// MARK: - Rare Perks
	
	static private let rarePerks: [LevelPerk] = [
		
		LevelPerk(
			nameEN: "Rare Perk Of Sharpness",
			nameRU: "Редкий Перк Остроты",
			perkDescriptionEN: "+2 min damage, +2 max damage",
			perkDescriptionRU: "+2 к минимальному и максимальному урону",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk Of Vitality",
			nameRU: "Редкий Перк Жизненных сил",
			perkDescriptionEN: "+20 HP, +20 MP",
			perkDescriptionRU: "+20 к максимальному уровню здоровья и маны",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk Of Precision",
			nameRU: "Редкий Перк Точности",
			perkDescriptionEN: "+2% of crit chance, +2% of hit chance",
			perkDescriptionRU: "+2% к шансу критического удара и шансу попадения по противнику",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Brutality",
			nameRU: "Редкий Перк Жесткости",
			perkDescriptionEN: "+4 armor penetration",
			perkDescriptionRU: "+4 к эффекту пробивания брони",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Reaction",
			nameRU: "Редкий Перк Реакции",
			perkDescriptionEN: "+10% chance to start fight first",
			perkDescriptionRU: "+10% к шансу начать бой первым",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Savagery",
			nameRU: "Редкий Перк Буйства",
			perkDescriptionEN: "+15% to Attack and Combo Damage",
			perkDescriptionRU: "+15% к урону обычных атак и комбо атаки",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Protection",
			nameRU: "Редкий Перк Защиты",
			perkDescriptionEN: "+4 block value",
			perkDescriptionRU: "+4 к эффекту блока",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Wisdom",
			nameRU: "Редкий Перк Мудрости",
			perkDescriptionEN: "+6 spell power",
			perkDescriptionRU: "+6 к силе заклинаний",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Critical Hit",
			nameRU: "Редкий Перк Критических Ударов",
			perkDescriptionEN: "+15% critical effect of attack/heal/block abilities",
			perkDescriptionRU: "+15% к критическому эффекту атак/лечения/блока",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Preparation",
			nameRU: "Редкий Перк Подготовки",
			perkDescriptionEN: "Adds 100% of current block value as damage to next attack after using block ability",
			perkDescriptionRU: "После использования способности 'блок' следующая обычная атака будет сильнее на 100% значение блока",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Ill Word",
			nameRU: "Редкий Перк Злости",
			perkDescriptionEN: "Adds 50% of heal value to next attack after using heal ability",
			perkDescriptionRU: "После использования способности 'лечение' следующая атака будет сильнее на 50% эффекта лечения",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Reflection",
			nameRU: "Редкий Перк Отражения",
			perkDescriptionEN: "Reflect 15% of enemy damage while under block ability",
			perkDescriptionRU: "Отразит 15% урона противника, если активен эффекта споосбности 'блок' ",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Vampirism",
			nameRU: "Редкий Перк Вампиризма",
			perkDescriptionEN: "Normal attacks can heal by 10% of damage done",
			perkDescriptionRU: "Обычные атаки теперь исцеляют в размере 10% от нанесенного урона",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Spell Stealing",
			nameRU: "Редкий Перк Кражи Маны",
			perkDescriptionEN: "Normal attacks can restore mana by 10% of damage done",
			perkDescriptionRU: "Обычные атаки теперь восстанавливают ману в размере 10% от нанесенного урона",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Fortitude",
			nameRU: "Редкий Перк Стойкости",
			perkDescriptionEN: "Use of heal ability adds 6 block value to next Block ability (once per turn)",
			perkDescriptionRU: "Использование способности 'лечение' добавляет 6 очков к следующему эффекту способности 'блок' (один раз за ход)",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Resilience",
			nameRU: "Редкий Перк Устойчивости",
			perkDescriptionEN: "Use of block ability adds 6 spell power to next Heal ability (once per turn)",
			perkDescriptionRU: "Использование способности 'блок' добавляет 6 очков к силе следующего эффекта способности 'лечение' (один раз за ход)",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Armor Destruction",
			nameRU: "Редкий Перк Разрушения Брони",
			perkDescriptionEN:"Use of normal attacks deduct 2 enemy armor per each successful hit",
			perkDescriptionRU: "Обычные атаки теперь снижают броню противника на 2 после каждого попадения",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Energy Surge",
			nameRU: "Редкий Перк Всплеска Энергии",
			perkDescriptionEN: "Use of attack/block/heal has a 10% chance to get Energy Cost back",
			perkDescriptionRU: "Использование способностей 'атака/лечение/блок/ теперь имеет 10% шанс вернуть затраченное очко действия",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Soul Extraction",
			nameRU: "Редкий Перк Извлечения Душ",
			perkDescriptionEN: "Critical attacks extract 10% of it's value as Dark Energy",
			perkDescriptionRU: "Критические атаки теперь извлекают темную энергию из цели в размере 10% от нанесенного урона",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Greed",
			nameRU: "Редкий Перк Жадности",
			perkDescriptionEN: "+10% of dark energy, gold loot and experience gain",
			perkDescriptionRU: "+10% к темной энергии, опыту и золоту со всех возможных источников",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Crushing Blow",
			nameRU: "Редкий Перк Сокрушающих Ударов",
			perkDescriptionEN: "Normal Attacks have a 10% chance to remove 1 enemy EP for next turn",
			perkDescriptionRU: "Обычные атаки теперь имеют 10% шанс снять 1 очко действия противника во время его следующего хода",
			rarity: .rare
		),
		
		LevelPerk(
			nameEN: "Rare Perk of Swiftness",
			nameRU: "Редкий Перк Стремительности",
			perkDescriptionEN: "Attacks, heal and block abilities have a 10% chance to make a double effect after use",
			perkDescriptionRU: "Обычные атаки, блок и лечение теперь имеют 10% шанс на двойной эффект при использовании",
			rarity: .rare
		),
		
	]
	
	// MARK: - Epic Perks
	
	static private let epicPerks: [LevelPerk] = [
		
		LevelPerk(
			nameEN: "Epic Perk Of Sharpness",
			nameRU: "Эпический Перк Остроты",
			perkDescriptionEN: "+3 min damage, +3 max damage",
			perkDescriptionRU: "+3 к минимальному и максимальному урону",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk Of Vitality",
			nameRU: "Эпический Перк Жизненных сил",
			perkDescriptionEN: "+40 HP, +40 MP",
			perkDescriptionRU: "+40 к максимальному уровню здоровья и маны",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk Of Precision",
			nameRU: "Эпический Перк Точности",
			perkDescriptionEN: "+3% of crit chance, +3% of hit chance",
			perkDescriptionRU: "+3% к шансу критического эффекта и шансу попадения по противнику",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Brutality",
			nameRU: "Эпический Перк Жесткости",
			perkDescriptionEN: "+6 armor penetration",
			perkDescriptionRU: "+6 к эффекту пробивания брони",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Reaction",
			nameRU: "Эпический Перк Реакции",
			perkDescriptionEN: "+15% chance to start fight first",
			perkDescriptionRU: "+15% к шансу начать бой первым",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Savagery",
			nameRU: "Эпический Перк Буйства",
			perkDescriptionEN: "+20% to Attack and Combo Damage",
			perkDescriptionRU: "+20% к эффекту обычных и комбо атак",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Protection",
			nameRU: "Эпический Перк Защиты",
			perkDescriptionEN: "+6 block value",
			perkDescriptionRU: "+6 к эффекту способности 'блок' ",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Wisdom",
			nameRU: "Эпический Перк Мудрости",
			perkDescriptionEN: "+10 spell power",
			perkDescriptionRU: "+10 к силе заклинаний",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Critical Hit",
			nameRU: "Эпический Перк Мудрости",
			perkDescriptionEN: "+25% critical effect of attack/heal/block abilities",
			perkDescriptionRU: "+25% к критическому эффекту способностей атаки/лечения/блока",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Preparation",
			nameRU: "Эпический Перк Подготовки",
			perkDescriptionEN: "Adds 150% of current block value as damage to next attack after using block ability",
			perkDescriptionRU: "После использования способнсти 'блок' добавляет 150% значения эффекта блокировки к следующей обычной атаке",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Ill Word",
			nameRU: "Эпический Перк Злости",
			perkDescriptionEN: "Adds 75% of heal value to next attack after using heal ability",
			perkDescriptionRU: "После использования способности 'лечение' добавляет 75% значения эффекта лечения к следующей обычной атаке",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Reflection",
			nameRU: "Эпический Перк Отражения",
			perkDescriptionEN: "Reflect 25% of enemy damage while under block ability",
			perkDescriptionRU: "Теперь отражает 25% от урона противника во время действия эффекта способности 'блок' ",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Vampirism",
			nameRU: "Эпический Перк Вампиризма",
			perkDescriptionEN: "Normal attacks can heal by 15% of damage done",
			perkDescriptionRU: "Обычные атаки теперь исцеляют в размере 15% от нанесенного урона",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Spell Stealing",
			nameRU: "Эпический Перк Кражи Маны",
			perkDescriptionEN: "Normal attacks can restore mana by 15% of damage done",
			perkDescriptionRU: "Обычные атаки теперь восполняют ману в размере 15% от нанесенного урона",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Health Grow",
			nameRU: "Эпический Перк Жизненного Потенциала",
			perkDescriptionEN: "Each heal ability adds 1 hp tp max health. 1 unit per fight maximum",
			perkDescriptionRU: "Использование способности 'лечение' теперь увеличивает максимальный показатель здоровья на 1 (Не больше 1 единицы за бой)",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Fortitude",
			nameRU: "Эпический Перк Стойкости",
			perkDescriptionEN: "Use of heal ability adds 10 block value to next Block ability (once per turn)",
			perkDescriptionRU: "Использование способности 'лечение' теперь добавляет 10 очков к эффекту следующей способности 'блок' (один раз за ход)",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Resilience",
			nameRU: "Эпический Перк Устойчивости",
			perkDescriptionEN: "Use of block ability adds 10 spell power to next Heal ability (once per turn)",
			perkDescriptionRU: "Использование способности 'блок' добавляет 10 к силе заклинаний следующей способности 'лечение' (один раз за ход)",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Armor Destruction",
			nameRU: "Эпический Перк Разрушения Брони",
			perkDescriptionEN: "Use of normal attacks deduct 3 enemy armor per each use",
			perkDescriptionRU: "Каждое успешное попадение обычными атаки снижает броню противника на 3",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Energy Surge",
			nameRU: "Эпический Перк Всплеска Энергии",
			perkDescriptionEN: "Use of attack/block/heal has a 15% chance to get Energy Cost back",
			perkDescriptionRU: "Использование обычных атак, лечения или блока теперь имеет 15% шанс вернуть затраченное очко действия",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Soul Extraction",
			nameRU: "Эпический Перк Извлечения Душ",
			perkDescriptionEN: "Critical attacks extract 15% of it's value as Dark Energy",
			perkDescriptionRU: "Критические атаки теперь извлекают темную энергию из цели в размере 15% от нанесенного урона",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Greed",
			nameRU: "Эпический Перк Жадности",
			perkDescriptionEN: "+15% of dark energy, gold loot and experience gain",
			perkDescriptionRU: "+15% к полученной темной энергии, золоту и опыту из всех источников",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Crushing Blow",
			nameRU: "Эпический Перк Сокрушающих Ударов",
			perkDescriptionEN: "Normal Attacks have a 15% chance to remove 1 enemy EP for next turn",
			perkDescriptionRU: "Обычные атаки теперь имеют 15% шанс снять одно очко действия противника во время следующего хода при каждом успешном попадении",
			rarity: .epic
		),
		
		LevelPerk(
			nameEN: "Epic Perk of Swiftness",
			nameRU: "Эпический Перк Стремительности",
			perkDescriptionEN: "Attacks, heal and block abilities have a 15% chance to make a double effect after use",
			perkDescriptionRU: "Обычные атаки, лечение и блок теперь имеют 15% шанс на двоной эффект при использовании",
			rarity: .epic
		),
		
	]
	
	// MARK: - Legendary Perks
	
	
	static private let legendaryPerks: [LevelPerk] = [
		
		LevelPerk(
			nameEN: "Legendary Perk Of Sharpness",
			nameRU: "Легендарный Перк Остроты",
			perkDescriptionEN: "+5 min damage, +5 max damage",
			perkDescriptionRU: "+5 к минимальному и максимальному урону",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk Of Vitality",
			nameRU: "Легендарный Перк Жизненных Сил",
			perkDescriptionEN: "+80 HP, +80 MP",
			perkDescriptionRU: "+80 к максимальному уровню здоровья и маны",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk Of Precision",
			nameRU: "Легендарный Перк Точности",
			perkDescriptionEN: "+4% of crit chance, +4% of hit chance",
			perkDescriptionRU: "+4% к шансу нанесения критического эффекта и шансу попадения по противнику",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Brutality",
			nameRU: "Легендарный Перк Жесткости",
			perkDescriptionEN: "+10 armor penetration",
			perkDescriptionRU: "+10 к эффекту пробивания брони",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Reaction",
			nameRU: "Легендарный Перк Реакции",
			perkDescriptionEN: "+25% chance to start fight first",
			perkDescriptionRU: "+25% шанс начать бой первым",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Savagery",
			nameRU: "Легендарный Перк Буйства",
			perkDescriptionEN: "+30% to Attack and Combo Damage",
			perkDescriptionRU: "+30% к урону обычных и комбо атак",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Protection",
			nameRU: "Легендарный Перк Защиты",
			perkDescriptionEN: "+10 block value",
			perkDescriptionRU: "+10 к эффекту способности 'блок' ",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Wisdom",
			nameRU: "Легендарный Перк Мудрости",
			perkDescriptionEN: "+15 spell power",
			perkDescriptionRU: "+15 к силе заклинаний",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Critical Hit",
			nameRU: "Легендарный Перк Критического Удара",
			perkDescriptionEN: "+40% critical effect of attack/heal/block abilities",
			perkDescriptionRU: "+40% к значению критического эффекта обычных атак, лечения и блока",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Preparation",
			nameRU: "Легендарный Перк Подготовки",
			perkDescriptionEN: "Adds 200% of current block value as damage to next attack after using block ability",
			perkDescriptionRU: "После использования способности 'блок' добавляет 200% эффекта блокировки к следующей обычной атаке",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Ill Word",
			nameRU: "Легендарный Перк Злости",
			perkDescriptionEN: "Adds 100% of heal value to next attack after using heal ability",
			perkDescriptionRU: "После использования способности 'лечение' добавляет 100% эффекта исцеления к следующей обычной атаке",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Reflection",
			nameRU: "Легендарный Перк Отражения",
			perkDescriptionEN: "Reflect 40% of enemy damage while under block ability",
			perkDescriptionRU: "Отражает 40% урона противника во время действия эффекта способности 'блок' ",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Vampirism",
			nameRU: "Легендарный Перк Вампиризма",
			perkDescriptionEN: "Normal attacks can heal by 20% of damage done",
			perkDescriptionRU: "Обычные атаки теперь исцеляют в размере 20% от нанесенного урона",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Spell Stealing",
			nameRU: "Легендарный Перк Кражи Маны",
			perkDescriptionEN: "Normal attacks can restore mana by 20% of damage done",
			perkDescriptionRU: "Обычные атаки теперь восстанавливают ману в размере 20% от нанесенного урона",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Blood Bath",
			nameRU: "Легендарный Перк Кровавой Бани",
			perkDescriptionEN: "Each enemy kill adds 1 hp tp max health. 1 unit per enemy maximum",
			perkDescriptionRU: "Каждое убийство противника увеличивает максимальный уровень здоровья на 1",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Fortitude",
			nameRU: "Легендарный Перк Стойкости",
			perkDescriptionEN: "Use of heal ability adds 15 block value to next Block ability (once per turn)",
			perkDescriptionRU: "Использование способности 'лечение' добавляет 15 очков к значению следующей способности 'блок' (один раз за ход)",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Resilience",
			nameRU: "Легендарный Перк Устойчивости",
			perkDescriptionEN: "Use of block ability adds 15 spell power to next Heal ability (once per turn)",
			perkDescriptionRU: "Использование способности 'блок' добавляет 15 к силе заклинаний для следующей способности 'лечение' (один раз за ход)",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Armor Destruction",
			nameRU: "Легендарный Перк Разрешния Брони",
			perkDescriptionEN: "Use of normal attacks deduct 5 enemy armor per each use",
			perkDescriptionRU: "Каждое успешное попадение по противнику с помощью обычной атаки снижает уровень брони цели на 5",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Energy Surge",
			nameRU: "Легендарный Перк Всплеска Энергии",
			perkDescriptionEN: "Use of attack/block/heal has a 25% chance to get Energy Cost back",
			perkDescriptionRU: "Использование обычных атак, блока или лечения теперь имеет 25% шанс вернуть затраченное очко действия",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Soul Extraction",
			nameRU: "Легендарный Перк Извлечения Душ",
			perkDescriptionEN: "Critical attacks extract 25% of it's value as Dark Energy",
			perkDescriptionRU: "Критические удары извлекают темную энергию из цели в размере 25% от нанесенного урона",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Greed",
			nameRU: "Легендарный Перк Жадности",
			perkDescriptionEN: "+25% of dark energy, gold loot and experience gain",
			perkDescriptionRU: "+25% к полученной темной энергии, золоту и опыту со всех источников",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Crushing Blow",
			nameRU: "Легендарный Перк Сокрушающих Ударов",
			perkDescriptionEN: "Normal Attacks have a 25% chance to remove 1 enemy EP for next turn",
			perkDescriptionRU: "Обычные атаки теперь имеют 25% шанс снять 1 очко действия противника в его следующий ход",
			rarity: .legendary
		),
		
		LevelPerk(
			nameEN: "Legendary Perk of Swiftness",
			nameRU: "Легендарный Перк Стремительности",
			perkDescriptionEN: "Attacks, heal and block abilities have a 25% chance to make a double effect after use",
			perkDescriptionRU: "Атаки, лечение и блок теперь имеют 25% шанс на двойной эффект",
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

