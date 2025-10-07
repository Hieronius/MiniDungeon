import Foundation

struct WeaponManager {
	
	static let weapons: [Weapon] = [
		
		Weapon(label: "Wooden Sword",
			   itemLevel: 1,
			   itemType: .weapon,
			   description: "+1 minDamage, +2 maxDamage",
			   minDamage: 1,
			   maxDamage: 2,
			   hitChance: 0,
			   critChance: 0,
			   price: 100),
		
		Weapon(label: "Bronze Axe",
			   itemLevel: 2,
			   itemType: .weapon,
			   description: "+2 minDamage, +4 maxDamage, +1% hitChance, +1% critChance",
			   minDamage: 2,
			   maxDamage: 4,
			   hitChance: 1,
			   critChance: 1,
			   price: 200),
		
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
