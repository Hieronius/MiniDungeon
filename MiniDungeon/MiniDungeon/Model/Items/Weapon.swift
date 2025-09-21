import Foundation

struct WeaponManager {
	
	static let weapons: [Weapon] = [
		
		Weapon(label: "Wooden Sword",
			   itemLevel: 1,
			   itemType: .weapon,
			   description: "like a wood",
			   minDamage: 1,
			   maxDamage: 2,
			   hitChance: 0,
			   critChance: 0),
		
		Weapon(label: "Bronze Axe",
			   itemLevel: 2,
			   itemType: .weapon,
			   description: "Is it a real bronze?",
			   minDamage: 2,
			   maxDamage: 4,
			   hitChance: 1,
			   critChance: 1),
		
		Weapon(label: "Morning Star",
			   itemLevel: 3,
			   itemType: .weapon,
			   description: "Suppose an evening too?",
			   minDamage: 3,
			   maxDamage: 6,
			   hitChance: 2,
			   critChance: 2),
		
		Weapon(label: "Steel Sword",
			   itemLevel: 4,
			   itemType: .weapon,
			   description: "Did they really knew how to make steel?",
			   minDamage: 5,
			   maxDamage: 10,
			   hitChance: 3,
			   critChance: 3),
		
		Weapon(label: "Frostmourne",
			   itemLevel: 5,
			   itemType: .weapon,
			   description: "Now i have the power my father never seen before!",
			   minDamage: 8,
			   maxDamage: 16,
			   hitChance: 5,
			   critChance: 5)
	]
}

struct Weapon: ItemProtocol {
	
	let id = UUID()
	let label: String
	let itemType: ItemType
	let itemLevel: Int
	let description: String
	let minDamage: Int
	let maxDamage: Int
	let hitChance: Int
	let critChance: Int
	
	init(label: String,
		 itemLevel: Int,
		 itemType: ItemType,
		 description: String,
		 minDamage: Int,
		 maxDamage: Int,
		 hitChance: Int,
		 critChance: Int)
	{
		self.label = label
		self.itemLevel = itemLevel
		self.itemType = itemType
		self.description = description
		self.minDamage = minDamage
		self.maxDamage = maxDamage
		self.hitChance = hitChance
		self.critChance = critChance
	}
}
