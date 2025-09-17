import Foundation

struct WeaponManager {
	
	static let weapons: [Weapon] = [
		
		Weapon(label: "Wooden Sword",
			   minDamage: 1,
			   maxDamage: 2,
			   hitChance: 0,
			   critChance: 0),
		
		Weapon(label: "Bronze Axe",
			   minDamage: 2,
			   maxDamage: 4,
			   hitChance: 1,
			   critChance: 1),
		
		Weapon(label: "Morning Star",
			   minDamage: 3,
			   maxDamage: 6,
			   hitChance: 2,
			   critChance: 2),
		
		Weapon(label: "Steel Sword",
			   minDamage: 5,
			   maxDamage: 10,
			   hitChance: 3,
			   critChance: 3),
		
		Weapon(label: "Frostmourne",
			   minDamage: 8,
			   maxDamage: 16,
			   hitChance: 5,
			   critChance: 5)
	]
}

struct Weapon {
	
	let label: String
	let minDamage: Int
	let maxDamage: Int
	let hitChance: Int
	let critChance: Int
	
	init(label: String,
		 minDamage: Int,
		 maxDamage: Int,
		 hitChance: Int,
		 critChance: Int)
	{
		self.label = label
		self.minDamage = minDamage
		self.maxDamage = maxDamage
		self.hitChance = hitChance
		self.critChance = critChance
	}
}
