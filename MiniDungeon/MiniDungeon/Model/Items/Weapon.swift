import Foundation

struct WeaponManager {
	
	static let weapons: [Weapon] = [
		
		Weapon(label: "Wooden Sword", minDamage: 1, maxDamage: 2),
		Weapon(label: "Bronze Axe", minDamage: 2, maxDamage: 4),
		Weapon(label: "Morning Star", minDamage: 3, maxDamage: 6),
		Weapon(label: "Steel Sword", minDamage: 5, maxDamage: 10),
		Weapon(label: "Frostmourne", minDamage: 8, maxDamage: 16)
	]
}

struct Weapon {
	
	let label: String
	let minDamage: Int
	let maxDamage: Int
	
	init(label: String,
		 minDamage: Int,
		 maxDamage: Int)
	{
		self.label = label
		self.minDamage = minDamage
		self.maxDamage = maxDamage
	}
}
