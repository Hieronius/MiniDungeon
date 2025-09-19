import Foundation

struct WeaponManager {
	
	static let weapons: [Weapon] = [
		
		Weapon(label: "Wooden Sword",
			   itemLevel: 1,
			   minDamage: 1,
			   maxDamage: 2,
			   hitChance: 0,
			   critChance: 0),
		
		Weapon(label: "Bronze Axe",
			   itemLevel: 2,
			   minDamage: 2,
			   maxDamage: 4,
			   hitChance: 1,
			   critChance: 1),
		
		Weapon(label: "Morning Star",
			   itemLevel: 3,
			   minDamage: 3,
			   maxDamage: 6,
			   hitChance: 2,
			   critChance: 2),
		
		Weapon(label: "Steel Sword",
			   itemLevel: 4,
			   minDamage: 5,
			   maxDamage: 10,
			   hitChance: 3,
			   critChance: 3),
		
		Weapon(label: "Frostmourne",
			   itemLevel: 5,
			   minDamage: 8,
			   maxDamage: 16,
			   hitChance: 5,
			   critChance: 5)
	]
}

struct Weapon: ItemProtocol {
	
	let id = UUID()
	let label: String
	let itemLevel: Int
	let minDamage: Int
	let maxDamage: Int
	let hitChance: Int
	let critChance: Int
	
	init(label: String,
		 itemLevel: Int,
		 minDamage: Int,
		 maxDamage: Int,
		 hitChance: Int,
		 critChance: Int)
	{
		self.label = label
		self.itemLevel = itemLevel
		self.minDamage = minDamage
		self.maxDamage = maxDamage
		self.hitChance = hitChance
		self.critChance = critChance
	}
}
