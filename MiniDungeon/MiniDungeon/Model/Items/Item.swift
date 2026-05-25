import Foundation

// MARK: - ItemProtocol

protocol ItemProtocol: Identifiable {
	
	var id: String { get }
//	var id: UUID { get }
	var labelEN: String { get }
	var labelRU: String { get }
	var itemType: ItemType { get }
	var itemLevel: Int { get }
	var itemDescriptionEN: String { get }
	var itemDescriptionRU: String { get }
	var rarity: Rarity { get }
	var price: Int { get }
}

// MARK: - ItemType

enum ItemType: Codable {
	
	case weapon
	case armor
	case potion
	case loot
}

// MARK: - Item

/// Entity to store all information about basic object of the inventory
struct Item: ItemProtocol, Hashable, Codable, Identifiable {
	
//	let id: UUID
//	let id = UUID()
	let id: String
	var labelEN: String
	var labelRU: String
	var itemType: ItemType
	var itemLevel: Int
	var itemDescriptionEN: String
	var itemDescriptionRU: String
	var amount: Int?
	var rarity: Rarity
	var price: Int
	
	init(
		labelEN: String,
		labelRU: String,
		itemType: ItemType,
		itemLevel: Int,
		itemDescriptionEN: String,
		itemDescriptionRU: String,
		rarity: Rarity,
		price: Int
	) {
//		self.id = UUID()
		self.id = "\(labelEN)"
		self.labelEN = labelEN
		self.labelRU = labelRU
		self.itemLevel = itemLevel
		self.itemType = itemType
		self.itemDescriptionEN = itemDescriptionEN
		self.itemDescriptionRU = itemDescriptionRU
		self.rarity = rarity
		self.price = price
	}
}

// MARK: - ItemManager

/// Data Type to hold all possible items of loot and potions
struct ItemManager {
	
	// MARK: - Common Loot
	
	static let commonLoot: [Item] = [
		
		Item(
			labelEN: "Key",
			labelRU: "Ключ",
			itemType: .loot,
			itemLevel: 1,
			itemDescriptionEN: "Can open the Chest",
			itemDescriptionRU: "Может открыть сундук",
			rarity: .common,
			price: 100
		),
		
		Item(
			labelEN: "Broken Trinket",
			labelRU: "Сломанная безделушка",
			itemType: .loot,
			itemLevel: 1,
			itemDescriptionEN: "An old and chip accessory",
			itemDescriptionRU: "Старый и дешевый аксессуар",
			rarity: .common,
			price: 75
		),
		
		Item(
			labelEN: "Cheap gem",
			labelRU: "Низкокачественный драгоценный камень",
			itemType: .loot,
			itemLevel: 1,
			itemDescriptionEN: "Really cheap",
			itemDescriptionRU: "И правда низкого качества",
			rarity: .common,
			price: 75
		),
		
		Item(
			labelEN: "Cracked Jewel",
			labelRU: "Потресканная драгоценность",
			itemType: .loot,
			itemLevel: 1,
			itemDescriptionEN: "Probably was fancy when was new",
			itemDescriptionRU: "Вероятно выглядела изумительно, когда была новой",
			rarity: .common,
			price: 75
		),
		
		Item(
			labelEN: "Darkened Ring",
			labelRU: "Потемневшее кольцо",
			itemType: .loot,
			itemLevel: 1,
			itemDescriptionEN: "You can't see it's original color",
			itemDescriptionRU: "Нельзя узнать его первоначальный цвет",
			rarity: .common,
			price: 75
		),
		
		Item(
			labelEN: "Damaged Necklace",
			labelRU: "Поврежденное ожерелье",
			itemType: .loot,
			itemLevel: 1,
			itemDescriptionEN: "Part of it is missing",
			itemDescriptionRU: "Часть ожерелья отсутствует",
			rarity: .common,
			price: 75
		),
	]
	
	// MARK: - Rare Loot
	
	static let rareLoot: [Item] = [
		
		Item(
			labelEN: "Steel Ring",
			labelRU: "Стальное кольцо",
			itemType: .loot,
			itemLevel: 2,
			itemDescriptionEN: "Just a ring",
			itemDescriptionRU: "Просто кольцо",
			rarity: .rare,
			price: 100
		),
		
		Item(
			labelEN: "Bronze Necklace",
			labelRU: "Бронзовое ожерелье",
			itemType: .loot,
			itemLevel: 2,
			itemDescriptionEN: "An ordinary one",
			itemDescriptionRU: "Самое обычное ожерелье",
			rarity: .rare,
			price: 100
		),
		
		Item(
			labelEN: "Old Ridge",
			labelRU: "Старый гребень",
			itemType: .loot,
			itemLevel: 2,
			itemDescriptionEN: "Still handy if you want to get your hair in order",
			itemDescriptionRU: "Все еще полезен, если нужно привести волосы в порядок",
			rarity: .rare,
			price: 100
		),
		
		Item(
			labelEN: "White Stud",
			labelRU: "Белая запонка",
			itemType: .loot,
			itemLevel: 2,
			itemDescriptionEN: "Someone important was probably wearing it",
			itemDescriptionRU: "Вероятно кто-то важный носил это",
			rarity: .rare,
			price: 100
		),
		
		Item(
			labelEN: "Gray Chain",
			labelRU: "Серая цепь",
			itemType: .loot,
			itemLevel: 2,
			itemDescriptionEN: "Probably was part of some kind of a costume",
			itemDescriptionRU: "Вероятно была частью чьего-то костюма",
			rarity: .rare,
			price: 100
		),
	]
	
	// MARK: - Epic Loot
	
	static let epicLoot: [Item] = [
		
		Item(
			labelEN: "Moon Stone",
			labelRU: "Лунный камень",
			itemType: .loot,
			itemLevel: 3,
			itemDescriptionEN: "A shiny and beautiful gem",
			itemDescriptionRU: "Красивый блестящий драгоценный камень",
			rarity: .epic,
			price: 150
		),
		
		Item(
			labelEN: "Golden Statue",
			labelRU: "Золотая статуя",
			itemType: .loot,
			itemLevel: 3,
			itemDescriptionEN: "Statue of someone important like a king or a lord",
			itemDescriptionRU: "Статуя какого-то известного короля или лорда",
			rarity: .epic,
			price: 150
		),
		
		Item(
			labelEN: "Silver Mirror",
			labelRU: "Серебряное зеркало",
			itemType: .loot,
			itemLevel: 3,
			itemDescriptionEN: "An old but still well made mirror",
			itemDescriptionRU: "Старое, но искусно изготовленное зеркало",
			rarity: .epic,
			price: 150
		),
		
		Item(
			labelEN: "Painted Vase",
			labelRU: "Разукрашенная ваза",
			itemType: .loot,
			itemLevel: 3,
			itemDescriptionEN: "You still can see an epic battle between a dragon and a knight described on it",
			itemDescriptionRU: "Все еще можно увидеть детали эпической битвы между рыцарем и драконом, изображенной в рисунке",
			rarity: .epic,
			price: 150
		),
		
		Item(
			labelEN: "Scarlet Ruby",
			labelRU: "Алый рубин",
			itemType: .loot,
			itemLevel: 3,
			itemDescriptionEN: "Probably ment to be used in one of these well made king's crowns",
			itemDescriptionRU: "Вероятно один из тех, что можно увидеть на короне короля",
			rarity: .epic,
			price: 150
		),
	]
	
	// MARK: - Legendary Loot
	
	static let legendaryLoot: [Item] = [
		
		Item(
			labelEN: "Perfect Diamond",
			labelRU: "Идеальный Алмаз",
			itemType: .loot,
			itemLevel: 4,
			itemDescriptionEN: "A truly perfect gem",
			itemDescriptionRU: "По-настоящему идеальный драгоценный камень",
			rarity: .legendary,
			price: 300
		),
		
		Item(
			labelEN: "Jewel-encrusted Casket",
			labelRU: "Инкрустированная драгоценными камнями шкатулка",
			itemType: .loot,
			itemLevel: 4,
			itemDescriptionEN: "An empty but very expensive chest",
			itemDescriptionRU: "Пустой, но очень дорогой сундучок для драгоценностей",
			rarity: .legendary,
			price: 300
		),
		
		Item(
			labelEN: "Violet Soul Crystal",
			labelRU: "Фиолетовый кристалл души",
			itemType: .loot,
			itemLevel: 4,
			itemDescriptionEN: "As legend tells that kind of crystal can be a storage or a prison for poor's souls",
			itemDescriptionRU: "Согласно легендам этот кристалл может быть хранилищем или тюрьмой для душ несчастных, попавших в ловушку злого гения",
			rarity: .legendary,
			price: 300
		),
		
		Item(
			labelEN: "Ivory Flute covered with gold",
			labelRU: "Флейта из слоновой кости покрытая золотом",
			itemType: .loot,
			itemLevel: 4,
			itemDescriptionEN: "You still can try to made a sound from this thing",
			itemDescriptionRU: "Все еще можно использовать по назначению",
			rarity: .legendary,
			price: 300
		),
		
		Item(
			labelEN: "Giant Silver Cup",
			labelRU: "Гигантский серебряный кубок",
			itemType: .loot,
			itemLevel: 4,
			itemDescriptionEN: "Cup so huge you think only giant's king could drink from it",
			itemDescriptionRU: "Кубок настолько велик что, вероятно, предназначался для предводителя великанов",
			rarity: .legendary,
			price: 300
		),
	]
	
	// MARK: - Common Potions
	
	static let commonPotions: [Item] = [
		
		Item(
			labelEN: "Small Health Restoration Potion",
			labelRU: "Небольное зелье восстановления здоровья",
			itemType: .potion,
			itemLevel: 1,
			itemDescriptionEN: "Heals by 10% of maximum HP",
			itemDescriptionRU: "Исцеляет в размере 10% от максимального уровня здоровья",
			rarity: .common,
			price: 150
		),
		
		Item(
			labelEN: "Small Mana Restoration Potion",
			labelRU: "Небольшое зелье восстановления маны",
			itemType: .potion,
			itemLevel: 1,
			itemDescriptionEN: "Restore mana by 10% of maximum MP",
			itemDescriptionRU: "Восстанавливает ману в размере 10% от максимального уровня",
			rarity: .common,
			price: 150
		),
		
//		Item(
//			label: "Small Energy Restoration Potion",
//			itemType: .potion,
//			itemLevel: 1,
//			itemDescription: "Restores ENERGY by 1",
//			price: 200
//		)
	]
	
	// MARK: - Rare Potions
	
	static let rarePotions: [Item] = [
		
		Item(
			labelEN: "Health Restoration Potion",
			labelRU: "Зелье восстановление здоровья",
			itemType: .potion,
			itemLevel: 2,
			itemDescriptionEN: "Heals by 25% of max HP",
			itemDescriptionRU: "Исцеляет в размере 25% от максимального уровня здоровья",
			rarity: .rare,
			price: 300
		),
		
		Item(
			labelEN: "Mana Restoration Potion",
			labelRU: "Зелье восстановления маны",
			itemType: .potion,
			itemLevel: 2,
			itemDescriptionEN: "Restore mana by 25% of max MP",
			itemDescriptionRU: "Восстанавливает 25% от максимального уровня маны",
			rarity: .rare,
			price: 300
		),
		
		Item(
			labelEN: "Small Health Pool Elixir",
			labelRU: "Небольшой эликсир живучести",
			itemType: .potion,
			itemLevel: 2,
			itemDescriptionEN: "+5 current HP, +5 max HP",
			itemDescriptionRU: "+5 к текущему и максимальному уровню здоровью",
			rarity: .rare,
			price: 300
		),
		
		Item(
			labelEN: "Small Mana Pool Elixir",
			labelRU: "Небольшой эликсир магических сил",
			itemType: .potion,
			itemLevel: 2,
			itemDescriptionEN: "+5 current MP, +5 max MP",
			itemDescriptionRU: "+5 к текущему и максимальному уровню маны",
			rarity: .rare,
			price: 300
		),
		
		Item(
			labelEN: "Small Wolf Tonic",
			labelRU: "Небольшой эликсир волка",
			itemType: .potion,
			itemLevel: 2,
			itemDescriptionEN: "+1 min damage",
			itemDescriptionRU: "+1 к минимальному урону",
			rarity: .rare,
			price: 300
		),
		
		Item(
			labelEN: "Small Bear Tonic",
			labelRU: "Небольшой эликсир медведя",
			itemType: .potion,
			itemLevel: 2,
			itemDescriptionEN: "+1 max damage",
			itemDescriptionRU: "+1 к максимальному урону",
			rarity: .rare,
			price: 300
		),
		
		Item(
			labelEN: "Small Fox Tonic",
			labelRU: "Небольшой эликсир лисы",
			itemType: .potion,
			itemLevel: 2,
			itemDescriptionEN: "+1% crit chance",
			itemDescriptionRU: "+1% к шансу критического эффекта",
			rarity: .rare,
			price: 300
		),
		
		Item(
			labelEN: "Small Owl Tonic",
			labelRU: "Небольшой эликсир совы",
			itemType: .potion,
			itemLevel: 2,
			itemDescriptionEN: "+1 spell power",
			itemDescriptionRU: "+1 к силе заклинаний",
			rarity: .rare,
			price: 300
		),
		
		Item(
			labelEN: "Small Iguana Tonic",
			labelRU: "Небольшой эликсир игуаны",
			itemType: .potion,
			itemLevel: 2,
			itemDescriptionEN: "+1% hit chance",
			itemDescriptionRU: "+1% к шансу попадения по противнику",
			rarity: .rare,
			price: 300
		)
	]
	
	// MARK: - Epic Potions
	
	static let epicPotions: [Item] = [
		
		// A few normal and powerful ones and other should be corrupted to give not only benefits but also negative side effects
		
		Item(
			labelEN: "Huge Health Restoration Potion",
			labelRU: "Большое зелье восстановление здоровья",
			itemType: .potion,
			itemLevel: 3,
			itemDescriptionEN: "Heals by 35% of max health",
			itemDescriptionRU: "Исцеляет в размере 35% от максимального уровня здоровья",
			rarity: .epic,
			price: 500
		),
		
		Item(
			labelEN: "Huge Mana Restoration Potion",
			labelRU: "Большое зелье восстановления маны",
			itemType: .potion,
			itemLevel: 3,
			itemDescriptionEN: "Restores mana by 35% of it's max capacity",
			itemDescriptionRU: "Восстанавливает ману в размере 35% от максимального уровня",
			rarity: .epic,
			price: 500
		),
		
		Item(
			labelEN: "Elixir of Strength",
			labelRU: "Эликсир силы",
			itemType: .potion,
			itemLevel: 3,
			itemDescriptionEN: "+1 min damage, +1 max damage",
			itemDescriptionRU: "+1 к минимальному и максимальному урону",
			rarity: .epic,
			price: 600
		),
		
		Item(
			labelEN: "Huge Elixir of Tortoise",
			labelRU: "Большой эликсир черепахи",
			itemType: .potion,
			itemLevel: 3,
			itemDescriptionEN: "+20 health, -1% hit chance",
			itemDescriptionRU: "+20 к максимальному уровню здоровья, -1% к шансу попадения по противнику",
			rarity: .epic,
			price: 500
		),
		
		Item(
			labelEN: "Huge Elixir of Wisdom",
			labelRU: "Большой эликсир мудрости",
			itemType: .potion,
			itemLevel: 3,
			itemDescriptionEN: "+3 spell power, -1 max damage",
			itemDescriptionRU: "+3 к силе заклинаний, -1 к максимальному урону",
			rarity: .epic,
			price: 500
		),
		
		Item(
			labelEN: "Huge Elixir of Boldness",
			labelRU: "Большой эликсир смелости",
			itemType: .potion,
			itemLevel: 3,
			itemDescriptionEN: "+3% crit chance, -20 health, -20 mana",
			itemDescriptionRU: "+3% к шансу критического эффекта, -20 к максимальному уровню здоровья, -20 к максимальному уровню маны",
			rarity: .epic,
			price: 500
		),
		
		Item(
			labelEN: "Huge Elixir of Accuracy",
			labelRU: "Большой эликсир точности",
			itemType: .potion,
			itemLevel: 3,
			itemDescriptionEN: "+3% hit chance, -1 armor, -1 spell power",
			itemDescriptionRU: "+3% к шансу попадения по противнику, -1 к броне, -1 к силе заклинаний",
			rarity: .epic,
			price: 500
		)
		
	]
	
	// MARK: - Legendary Potions
	
	static let legendaryPotions: [Item] = [
		
		Item(
			labelEN: "Legendary Potion of Energy",
			labelRU: "Легендарное зелье энергии",
			itemType: .potion,
			itemLevel: 4,
			itemDescriptionEN: "+1 ENERGY",
			itemDescriptionRU: "+1 к ОЧКАМ ДЕЙСТВИЯ",
			rarity: .legendary,
			price: 1500
		),
		
		Item(
			labelEN: "Legendary Potion of Strength",
			labelRU: "Легендарное зелье силы",
			itemType: .potion,
			itemLevel: 4,
			itemDescriptionEN: "+2 min damage, +2 max damage, +1% hit chance, +1% crit chance",
			itemDescriptionRU: "+2 к минимальному и максимальному урону, +1% к шансу попадения по противнику, +1% к шансу критического эффекта",
			rarity: .legendary,
			price: 1500
		),
		
		Item(
			labelEN: "Corrupted Elixir of Agility",
			labelRU: "Проклятый эликсир ловкости",
			itemType: .potion,
			itemLevel: 4,
			itemDescriptionEN: "+5% crit chance, -2% hit chance, -30 health, -30 mana",
			itemDescriptionRU: "+5% к шансу критического эффекта, -2% к шансу попадения по противнику, -30 к максимальному уровню здоровья, -30 к максимальному уровню маны",
			rarity: .legendary,
			price: 1500
		),
		
		Item(
			labelEN: "Corrupted Elixir of Wisdom",
			labelRU: "Проклятый эликсир мудрости",
			itemType: .potion,
			itemLevel: 4,
			itemDescriptionEN: "+5 spell power, +30 mana, -2% crit chance, -30 health",
			itemDescriptionRU: "+5 к силе заклинаний, +30 к мане, -2% к шансу критического эффекта, -30 к здоровью",
			rarity: .legendary,
			price: 1500
		),
		
		Item(
			labelEN: "Corrupted Elixir of Behemoth",
			labelRU: "Проклятый эликсир бегемота",
			itemType: .potion,
			itemLevel: 4,
			itemDescriptionEN: "+3 Defence, +50 health, -1% crit chance, -1% hit chance, -30 mana, -3 spell power",
			itemDescriptionRU: "+3 к броне, +50 к максимальному уровню здоровья, -1% к шансу критического эффекта, -1% к шансу попадения по противнику, -30 к максимальному уровню маны, -3 к силе заклинаний",
			rarity: .legendary,
			price: 1500
		),
		
		Item(
			labelEN: "Corrupted Elixir of Focus",
			labelRU: "Проклятый эликсир концентрации",
			itemType: .potion,
			itemLevel: 4,
			itemDescriptionEN: "+5% hit chance, -1% crit chance, -20 health, -1 defence, -20 mana, -1 spell power",
			itemDescriptionRU: "+5% к шансу попадения по противнику, -1% к шансу критического эффекта, -20 к максимальному уровню здоровья, -1 к броне, -20 к максимальному уровню маны, -1 к силе заклинаний",
			rarity: .legendary,
			price: 1500
		),
	]
	
	// MARK: GeneratePotion()
	
	/// Method gets rarity of the potion and generates one accordingly
	static func generatePotion(of rarity: Rarity) -> Item? {
		
		switch rarity {
			
		case .common: return self.commonPotions.randomElement()
		case .rare: return self.rarePotions.randomElement()
		case .epic: return self.epicPotions.randomElement()
		case .legendary: return self.legendaryPotions.randomElement()
		}
	}
	
	// MARK: - GenerateLoot()
	
	/// Method gets rarity of the loot and generates one accordingly
	static func generateLoot(of rarity: Rarity) -> Item? {
		
		switch rarity {
			
		case .common: return self.commonLoot.randomElement()
		case .rare: return self.rareLoot.randomElement()
		case .epic: return self.epicLoot.randomElement()
		case .legendary: return self.legendaryLoot.randomElement()
		}
	}
	
	// MARK: - returnKeyItem()
	
	/// method to pass an exact Key Item to work with
	static func returnKeyItem() -> Item {
		return self.commonLoot[0]
	}
}
