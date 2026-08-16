import Foundation

// MARK: - Weapon

struct Weapon: ItemProtocol, Hashable, Codable, Identifiable {
	
//	let id: UUID
//	let id = UUID()
	let id: String
	var labelEN: String
	var labelRU: String
	var itemType: ItemType
	var itemLevel: Int
	var itemDescriptionEN: String
	var itemDescriptionRU: String
	var minDamage: Int
	var maxDamage: Int
	var hitChance: Int
	var critChance: Int
	var rarity: Rarity
	var price: Int
	
	init(labelEN: String,
		 labelRU: String,
		 itemLevel: Int,
		 itemType: ItemType,
		 itemDescriptionEN: String,
		 itemDescriptionRU: String,
		 minDamage: Int,
		 maxDamage: Int,
		 hitChance: Int,
		 critChance: Int,
		 rarity: Rarity,
		 price: Int)
	{
//		self.id = UUID()
		self.id = "\(labelEN)"
		self.labelEN = labelEN
		self.labelRU = labelRU
		self.itemLevel = itemLevel
		self.itemType = itemType
		self.itemDescriptionEN = itemDescriptionEN
		self.itemDescriptionRU = itemDescriptionRU
		self.minDamage = minDamage
		self.maxDamage = maxDamage
		self.hitChance = hitChance
		self.critChance = critChance
		self.rarity = rarity
		self.price = price
	}
}

struct WeaponManager {
	
	// MARK: - Common Weapons
	
	static let commonWeapons: [Weapon] = [
		
		Weapon(labelEN: "Knife",
			   labelRU: "Нож",
			   itemLevel: 1,
			   itemType: .weapon,
			   itemDescriptionEN: "+1 min damage, +2 max damage",
			   itemDescriptionRU: "+1 к минимальному урону, +2 к максимальному урону",
			   minDamage: 1,
			   maxDamage: 2,
			   hitChance: 0,
			   critChance: 0,
			   rarity: .common,
			   price: 100),
		
		Weapon(
			labelEN: "Wooden Sword",
			labelRU: "Деревянный меч",
			itemLevel: 1,
			itemType: .weapon,
			itemDescriptionEN: "+1 max damage",
			itemDescriptionRU: "+1 к максимальному урону",
			minDamage: 0,
			maxDamage: 1,
			hitChance: 0,
			critChance: 0,
			rarity: .common,
			price: 50
		),
		
		Weapon(
			labelEN: "Broken Spear",
			labelRU: "Сломанное копье",
			itemLevel: 1,
			itemType: .weapon,
			itemDescriptionEN: "+1 min damage",
			itemDescriptionRU: "+1 к минимальному урону",
			minDamage: 1,
			maxDamage: 0,
			hitChance: 0,
			critChance: 0,
			rarity: .common,
			price: 50
		),
		
		Weapon(
			labelEN: "Blunted Axe",
			labelRU: "Тупой топор",
			itemLevel: 1,
			itemType: .weapon,
			itemDescriptionEN: "+1 min damage, +1 max damage",
			itemDescriptionRU: "+1 к минимальному урону, +1 к максимальному урону",
			minDamage: 1,
			maxDamage: 1,
			hitChance: 0,
			critChance: 0,
			rarity: .common,
			price: 75
		),
		
		Weapon(
			labelEN: "Damaged Mace",
			labelRU: "Поврежденная булава",
			itemLevel: 1,
			itemType: .weapon,
			itemDescriptionEN: "+1 max damage, +1 hit chance",
			itemDescriptionRU: "+1 к максимальному урону, +1 к шансу попасть по противнику",
			minDamage: 0,
			maxDamage: 1,
			hitChance: 1,
			critChance: 0,
			rarity: .common,
			price: 75
		),
		
		Weapon(
			labelEN: "Old two-handed sword",
			labelRU: "Старый двуручный меч",
			itemLevel: 1,
			itemType: .weapon,
			itemDescriptionEN: "+2 max damage",
			itemDescriptionRU: "+2 к максимальному урону",
			minDamage: 0,
			maxDamage: 2,
			hitChance: 0,
			critChance: 0,
			rarity: .common,
			price: 75
		)
	]
	
	// MARK: - Rare Weapons
	
	static let rareWeapons: [Weapon] = [
		
		Weapon(
			labelEN: "Bronze Axe",
			labelRU: "Бронзовый топор",
			itemLevel: 2,
			itemType: .weapon,
			itemDescriptionEN: "+2 min damage, +4 max damage, +1% hit chance, +1% crit chance",
			itemDescriptionRU: "+2 к минимальному урону, +4 к максимальному урону, +1% к шансу попасть по противнику, +1% к шансу критического эффекта",
			minDamage: 2,
			maxDamage: 4,
			hitChance: 1,
			critChance: 1,
			rarity: .rare,
			price: 200
		),
		
		Weapon(
			labelEN: "Sword",
			labelRU: "Меч",
			itemLevel: 2,
			itemType: .weapon,
			itemDescriptionEN: "+2 min damage, +3 max damage",
			itemDescriptionRU: "+2 к минимальному урону, +3 к максимальному урону",
			minDamage: 2,
			maxDamage: 3,
			hitChance: 0,
			critChance: 0,
			rarity: .rare,
			price: 125
		),
		
		Weapon(
			labelEN: "Spear",
			labelRU: "Копье",
			itemLevel: 2,
			itemType: .weapon,
			itemDescriptionEN: "+2 min damage, +1 max damage",
			itemDescriptionRU: "+2 к минимальному урону, +1 к максимальному урону",
			minDamage: 2,
			maxDamage: 1,
			hitChance: 0,
			critChance: 0,
			rarity: .rare,
			price: 125
		),
		
		Weapon(
			labelEN: "Mace",
			labelRU: "Палица",
			itemLevel: 2,
			itemType: .weapon,
			itemDescriptionEN: "+2 min damage, +2 max damage",
			itemDescriptionRU: "+2 к минимальному урону, +2 к максимальному урону",
			minDamage: 2,
			maxDamage: 2,
			hitChance: 0,
			critChance: 0,
			rarity: .rare,
			price: 125
		),
		
		Weapon(
			labelEN: "Dagger",
			labelRU: "Кинжал",
			itemLevel: 2,
			itemType: .weapon,
			itemDescriptionEN: "+1 min damage, +3 max damage, +1 crit chance",
			itemDescriptionRU: "+1 к минимальному урону, +3 к максимальному урону, +1 к шансу критического эффекта",
			minDamage: 1,
			maxDamage: 3,
			hitChance: 0,
			critChance: 1,
			rarity: .rare,
			price: 125
		),
		
		Weapon(
			labelEN: "Two Handed Sword",
			labelRU: "Двуручный меч",
			itemLevel: 2,
			itemType: .weapon,
			itemDescriptionEN: "+4 max damage",
			itemDescriptionRU: "+4 к максимальному урону",
			minDamage: 0,
			maxDamage: 4,
			hitChance: 0,
			critChance: 0,
			rarity: .rare,
			price: 125
		)
	]
	
	// MARK: - Epic Weapons
	
	static let epicWeapons: [Weapon] = [
		
		Weapon(
			labelEN: "Corrupted Two-Hand Sword",
			labelRU: "Проклятый двуручный меч",
			itemLevel: 3,
			itemType: .weapon,
			itemDescriptionEN: "+10 max damage, -2 min damage, -1% crit chance, -5% hit chance",
			itemDescriptionRU: "+10 к максимальному урону, -2 к минимальному урону, -1% к шансу критического эффекта, -5% к шансу попадения по противнику",
			minDamage: -2,
			maxDamage: 10,
			hitChance: -5,
			critChance: -1,
			rarity: .epic,
			price: 250
		),
		
		Weapon(
			labelEN: "Corrupted Sword",
			labelRU: "Проклятый меч",
			itemLevel: 3,
			itemType: .weapon,
			itemDescriptionEN: "+5 min damage, +5 max damage, -1% crit chance, -2% hit chance",
			itemDescriptionRU: "+5 к минимальному урону, +5 к максимальному урону, -1% к шансу критического эффекта, -2% к шансу попадения по противнику",
			minDamage: 5,
			maxDamage: 5,
			hitChance: -2,
			critChance: -1,
			rarity: .epic,
			price: 250
		),
		
		Weapon(
			labelEN: "Great Spear",
			labelRU: "Отличное копье",
			itemLevel: 3,
			itemType: .weapon,
			itemDescriptionEN: "+1 min damage, +6 max damage, +1% crit chance",
			itemDescriptionRU: "+1 к минимальному урону, +6 к максимальному урону, +1% к шансу критического эффекта",
			minDamage: 1,
			maxDamage: 6,
			hitChance: 0,
			critChance: 0,
			rarity: .epic,
			price: 250
		),
		
		Weapon(
			labelEN: "Great Axe",
			labelRU: "Отличный топор",
			itemLevel: 3,
			itemType: .weapon,
			itemDescriptionEN: "+3 min damage, +5 max damage",
			itemDescriptionRU: "+3 к минимальному урону, +5 к максимальному урону",
			minDamage: 3,
			maxDamage: 5,
			hitChance: 0,
			critChance: 0,
			rarity: .epic,
			price: 250
		),
		
		Weapon(
			labelEN: "Morning Star",
			labelRU: "Утренняя звезда",
			itemLevel: 3,
			itemType: .weapon,
			itemDescriptionEN: "+3 min damage, +6 max damage, +2% hit chance, +2% crit chance",
			itemDescriptionRU: "+3 к минимальному урону, +3 к максимальному урону, +2% к шансу попасть по противнику, +2% к шансу критического эффекта",
			minDamage: 3,
			maxDamage: 6,
			hitChance: 2,
			critChance: 2,
			rarity: .epic,
			price: 300
		),
		
		Weapon(
			labelEN: "Steel Sword",
			labelRU: "Железный меч",
			itemLevel: 3,
			itemType: .weapon,
			itemDescriptionEN: "+5 minDamage, +10 maxDamage, +3% hitChance, +3% critChance",
			itemDescriptionRU: "+5 к минимальному урону, +10 к максимальному урону, +3% к шансу попасть по противнику, +3% к шансу критического эффекта",
			minDamage: 5,
			maxDamage: 10,
			hitChance: 3,
			critChance: 3,
			rarity: .epic,
			price: 400
		),
	]
	
	// MARK: - LegendaryWeapons
	
	static let legendaryWeapons: [Weapon] = [
		
		Weapon(
			labelEN: "Silver Spear",
			labelRU: "Серебряное копье",
			itemLevel: 4,
			itemType: .weapon,
			itemDescriptionEN: "+5 min damage, +6 max damage, +10% hit chance, -2% crit chance. An incrediably light spear left by someone with very good taste and agile fighting style",
			itemDescriptionRU: "+5 к минимальному урону, +6 к максимальному урону, +10% к шансу попадения по противнику, -2% к шансу критического эффекта. Невероятно легкое копье оставленное воином с особенным вкусом и стилем боя",
			minDamage: 5,
			maxDamage: 6,
			hitChance: 10,
			critChance: -2,
			rarity: .legendary,
			price: 450
		),
		
		Weapon(
			labelEN: "Bloody Axe",
			labelRU: "Кровавый топор",
			itemLevel: 4,
			itemType: .weapon,
			itemDescriptionEN: "+6 min damage, +10 max damage, +5% crit chance, -2% hit chance. Very sharp axe with blood marks on it's edge and halt",
			itemDescriptionRU: "+6 к минимальному урону, +10 к максимальному урону, +5% к шансу критического эффекта, -2% к шансу попасть по противнику. Очень острый топор с кровавыми метками на лезвии и рукояти",
			minDamage: 6,
			maxDamage: 10,
			hitChance: -2,
			critChance: 5,
			rarity: .legendary,
			price: 450
		),
		
		Weapon(
			labelEN: "Giant Mace",
			labelRU: "Гигантская палица",
			itemLevel: 4,
			itemType: .weapon,
			itemDescriptionEN: "+15 max damage, -2 min damage, -5% hit chance, -5% crit chance. Someone with a powerful grip fall in battle and left this huge mace being unmovable for years",
			itemDescriptionRU: "+15 к максимальному урону, -2 к минимальному урону, -5% к шансу попасть по противнику, -5% к шансу критического эффекта. Прошлый владелец с невероятной силой оставил эту булаву нетронутой годами",
			minDamage: -2,
			maxDamage: 15,
			hitChance: -5,
			critChance: -5,
			rarity: .legendary,
			price: 450
		),
		
		Weapon(
			labelEN: "Frostmourne",
			labelRU: "Ледяная Скорбь",
			itemLevel: 4,
			itemType: .weapon,
			itemDescriptionEN: "+8 min Damage, +16 max Damage, +5% hit chance, +5% crit chance, -100% humanity. At last! Power my father never dreamed of!",
			itemDescriptionRU: "+8 к минимальному урону, +16 к максимальному урону, +5% к шансу попасть по противнику, +5% к шансу критического эффекта, -100 к человечности. Наконец-то! Сила, которая и не снилась моему отцу!",
			minDamage: 8,
			maxDamage: 16,
			hitChance: 5,
			critChance: 5,
			rarity: .legendary,
			price: 500
		)
	]
	
	// MARK: generateWeapon
	
	/// Method gets rarity of the weapon and generates one accordingly
	static func generateWeapon(of rarity: Rarity) -> Weapon? {
		
		switch rarity {
			
		case .common: return self.commonWeapons.randomElement()
		case .rare: return self.rareWeapons.randomElement()
		case .epic: return self.epicWeapons.randomElement()
		case .legendary: return self.legendaryWeapons.randomElement()
		}
	}
}
