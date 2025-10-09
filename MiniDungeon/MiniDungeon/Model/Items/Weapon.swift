import Foundation

struct WeaponManager {
	
	static let weapons: [Weapon] = [
		
		Weapon(
			label: "Knife",
			itemLevel: 1,
			itemType: .weapon,
			description: "+1 minDamage, +2 maxDamage",
			minDamage: 1,
			maxDamage: 2,
			hitChance: 0,
			critChance: 0,
			price: 100
		),
		
		Weapon(
			label: "Bronze Axe",
			itemLevel: 2,
			itemType: .weapon,
			description: "+2 minDamage, +4 maxDamage, +1% hitChance, +1% critChance",
			minDamage: 2,
			maxDamage: 4,
			hitChance: 1,
			critChance: 1,
			price: 200
		),
		
		Weapon(
			label: "Morning Star",
			itemLevel: 3,
			itemType: .weapon,
			description: "+3 minDamage, +6 maxDamage, +2% hitChance, +2% critChance. Suppose an evening too?",
			minDamage: 3,
			maxDamage: 6,
			hitChance: 2,
			critChance: 2,
			price: 300
		),
		
		Weapon(
			label: "Steel Sword",
			itemLevel: 4,
			itemType: .weapon,
			description: "+5 minDamage, +10 maxDamage, +3% hitChance, +3% critChance",
			minDamage: 5,
			maxDamage: 10,
			hitChance: 3,
			critChance: 3,
			price: 400
		),
		
		Weapon(
			label: "Frostmourne",
			itemLevel: 5,
			itemType: .weapon,
			description: "I will be twice the king my father was!",
			minDamage: 8,
			maxDamage: 16,
			hitChance: 5,
			critChance: 5,
			price: 500
		)
	]
	
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
	
	static let epicWeapons: [Weapon] = [
		
		// Items should inclued "corrapted versions" with negative effects
		// Start with just adding penalties like: "-1 crit chance, -1 hit chance and so on"
		
		Weapon(label: "Morning Star",
			   itemLevel: 3,
			   itemType: .weapon,
			   description: "+3 minDamage, +6 maxDamage, +2% hitChance, +2% critChance. Suppose an evening too?",
			   minDamage: 3,
			   maxDamage: 6,
			   hitChance: 2,
			   critChance: 2,
			   price: 300),
		
		Weapon(label: "Steel Sword",
			   itemLevel: 4,
			   itemType: .weapon,
			   description: "+5 minDamage, +10 maxDamage, +3% hitChance, +3% critChance",
			   minDamage: 5,
			   maxDamage: 10,
			   hitChance: 3,
			   critChance: 3,
			   price: 400),
	]
	
	static let legendaryWeapons: [Weapon] = [
		
		Weapon(label: "Frostmourne",
			   itemLevel: 5,
			   itemType: .weapon,
			   description: "I will be twice the king my father was!",
			   minDamage: 8,
			   maxDamage: 16,
			   hitChance: 5,
			   critChance: 5,
			   price: 500)
	]
	
	/// Method gets rarity of the level bonus and generates one accordingly
	static func generateWeapon(of rarity: Rarity) -> Weapon? {
		
		switch rarity {
			
		case .common: return self.commonWeapons.randomElement()
		case .rare: return self.rareWeapons.randomElement()
		case .epic: return self.epicWeapons.randomElement()
		case .legendary: return self.legendaryWeapons.randomElement()
		}
	}
}

struct Weapon: ItemProtocol, Hashable {
	
	let id = UUID()
	let label: String
	let itemType: ItemType
	let itemLevel: Int
	let description: String
	let minDamage: Int
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
		self.minDamage = minDamage
		self.maxDamage = maxDamage
		self.hitChance = hitChance
		self.critChance = critChance
		self.price = price
	}
}
