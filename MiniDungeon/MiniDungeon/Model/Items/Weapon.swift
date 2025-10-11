import Foundation

struct WeaponManager {
	
	// MARK: - Common Weapons
	
	static let commonWeapons: [Weapon] = [
		
		Weapon(label: "Knife",
			   itemLevel: 1,
			   itemType: .weapon,
			   description: "+1 min damage, +2 max damage",
			   minDamage: 0,
			   maxDamage: 1,
			   hitChance: 0,
			   critChance: 0,
			   price: 100),
		
		Weapon(
			label: "Wooden Sword",
			itemLevel: 1,
			itemType: .weapon,
			description: "+1 max damage",
			minDamage: 0,
			maxDamage: 1,
			hitChance: 0,
			critChance: 0,
			price: 50
		),
		
		Weapon(
			label: "Broken Spear",
			itemLevel: 1,
			itemType: .weapon,
			description: "+1 min damage",
			minDamage: 1,
			maxDamage: 0,
			hitChance: 0,
			critChance: 0,
			price: 50
		),
		
		Weapon(
			label: "Blunted Axe",
			itemLevel: 1,
			itemType: .weapon,
			description: "+1 min damage, +1 max damage",
			minDamage: 1,
			maxDamage: 1,
			hitChance: 0,
			critChance: 0,
			price: 75
		),
		
		Weapon(
			label: "Damaged Mace",
			itemLevel: 1,
			itemType: .weapon,
			description: "+1 max damage, +1 hit chance",
			minDamage: 0,
			maxDamage: 1,
			hitChance: 1,
			critChance: 0,
			price: 75
		),
		
		Weapon(
			label: "Old two-handed sword",
			itemLevel: 1,
			itemType: .weapon,
			description: "+2 max damage",
			minDamage: 0,
			maxDamage: 2,
			hitChance: 0,
			critChance: 0,
			price: 75
		)
	]
	
	// MARK: - Rare Weapons
	
	static let rareWeapons: [Weapon] = [
		
		Weapon(label: "Bronze Axe",
			   itemLevel: 2,
			   itemType: .weapon,
			   description: "+2 min damage, +4 max damage, +1% hit chance, +1% crit chance",
			   minDamage: 2,
			   maxDamage: 4,
			   hitChance: 1,
			   critChance: 1,
			   price: 200),
		
		Weapon(
			label: "Sword",
			itemLevel: 2,
			itemType: .weapon,
			description: "+2 min damage, +3 max damage",
			minDamage: 2,
			maxDamage: 3,
			hitChance: 0,
			critChance: 0,
			price: 125
		),
		
		Weapon(
			label: "Spear",
			itemLevel: 2,
			itemType: .weapon,
			description: "+2 min damage, +1 max damage",
			minDamage: 2,
			maxDamage: 1,
			hitChance: 0,
			critChance: 0,
			price: 125
		),
		
		Weapon(
			label: "Mace",
			itemLevel: 2,
			itemType: .weapon,
			description: "+2 min damage, +2 max damage",
			minDamage: 2,
			maxDamage: 2,
			hitChance: 0,
			critChance: 0,
			price: 125
		),
		
		Weapon(
			label: "Dagger",
			itemLevel: 2,
			itemType: .weapon,
			description: "+1 min damage, +3 max damage, +1 crit chance",
			minDamage: 1,
			maxDamage: 3,
			hitChance: 0,
			critChance: 1,
			price: 125
		),
		
		Weapon(
			label: "Two Handed Sword",
			itemLevel: 2,
			itemType: .weapon,
			description: "+4 max damage",
			minDamage: 0,
			maxDamage: 4,
			hitChance: 0,
			critChance: 0,
			price: 125
		)
	]
	
	// MARK: - Epic Weapons
	
	static let epicWeapons: [Weapon] = [
		
		Weapon(
			label: "Corrupted Two-Hand Sword",
			itemLevel: 3,
			itemType: .weapon,
			description: "+10 max damage, -2 min damage, -1% crit chance, -5% hit chance",
			minDamage: -2,
			maxDamage: 10,
			hitChance: -5,
			critChance: -1,
			price: 250
		),
		
		Weapon(
			label: "Corrupted Sword",
			itemLevel: 3,
			itemType: .weapon,
			description: "+5 min damage, +5 max damage, -1% crit chance, -2% hit chance",
			minDamage: 5,
			maxDamage: 5,
			hitChance: -2,
			critChance: -1,
			price: 250
		),
		
		Weapon(
			label: "Great Spear",
			itemLevel: 3,
			itemType: .weapon,
			description: "+1 min damage, + 6 max damage, + 1% crit chance",
			minDamage: 1,
			maxDamage: 6,
			hitChance: 0,
			critChance: 0,
			price: 250
		),
		
		Weapon(
			label: "Great Axe",
			itemLevel: 3,
			itemType: .weapon,
			description: "+3 min damage, +5 max damage",
			minDamage: 3,
			maxDamage: 5,
			hitChance: 0,
			critChance: 0,
			price: 250
		),
		
		Weapon(
			label: "Morning Star",
			itemLevel: 3,
			itemType: .weapon,
			description: "+3 min damage, +6 max damage, +2% hit chance, +2% crit chance",
			minDamage: 3,
			maxDamage: 6,
			hitChance: 2,
			critChance: 2,
			price: 300
		),
		
		Weapon(
			label: "Steel Sword",
			itemLevel: 3,
			itemType: .weapon,
			description: "+5 minDamage, +10 maxDamage, +3% hitChance, +3% critChance",
			minDamage: 5,
			maxDamage: 10,
			hitChance: 3,
			critChance: 3,
			price: 400
		),
	]
	
	// MARK: - LegendaryWeapons
	
	static let legendaryWeapons: [Weapon] = [
		
		Weapon(
			label: "Silver Spear",
			itemLevel: 4,
			itemType: .weapon,
			description: "+5 min damage, +6 max damage, +10% hit chance, -2% crit chance. An incrediably light and agile spear left by someone with very good taste and agile fighting style",
			minDamage: 5,
			maxDamage: 6,
			hitChance: 10,
			critChance: -2,
			price: 450
		),
		
		Weapon(
			label: "Bloody Axe",
			itemLevel: 4,
			itemType: .weapon,
			description: "+6 min damage, +10 max damage, +5% crit chance, -2% hit chance. Very sharp axe with blood marks on it's edge and halt. Are they only from it's target or from the owner it's self?",
			minDamage: 6,
			maxDamage: 10,
			hitChance: -2,
			critChance: 5,
			price: 450
		),
		
		Weapon(
			label: "Giant Mace",
			itemLevel: 4,
			itemType: .weapon,
			description: "+15 max damage, -2 min damage, -5% hit chance, -5% crit chance. Someone with a powerful grip fall in battle and left this huge mace being unmovable for years",
			minDamage: -2,
			maxDamage: 15,
			hitChance: -5,
			critChance: -5,
			price: 450
		),
		
		Weapon(label: "Frostmourne",
			   itemLevel: 4,
			   itemType: .weapon,
			   description: "+8 minDamage, +16 maxDamage, +5% hit chance, +5% crit chance. I will be twice the king my father was!",
			   minDamage: 8,
			   maxDamage: 16,
			   hitChance: 5,
			   critChance: 5,
			   price: 500)
	]
	
	// MARK: GenerateWeapon()
	
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

// MARK: - Weapon

struct Weapon: ItemProtocol, Hashable {
	
	let id = UUID()
	let label: String
	let itemType: ItemType
	let itemLevel: Int
	let description: String
	let minDamageBonus: Int
	let maxDamage: Int
	let hitChance: Int
	let critChance: Int
	let price: Int
	
	init(label: String,
		 itemLevel: Int,
		 itemType: ItemType,
		 description: String,
		 minDamage: Int,
		 maxDamage: Int,
		 hitChance: Int,
		 critChance: Int,
		 price: Int)
	{
		self.label = label
		self.itemLevel = itemLevel
		self.itemType = itemType
		self.description = description
		self.minDamageBonus = minDamage
		self.maxDamage = maxDamage
		self.hitChance = hitChance
		self.critChance = critChance
		self.price = price
	}
}
