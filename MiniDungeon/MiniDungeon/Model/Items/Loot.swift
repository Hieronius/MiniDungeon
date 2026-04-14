import Foundation

struct Loot: Hashable, Codable, Identifiable {
	
	var id = UUID()
	
	var experience: Int
	var gold: Int
	var darkEnergy: Int
	var items: [Item]
	var armors: [Armor]
	var weapons: [Weapon]
	
	init(
		experience: Int,
		gold: Int,
		darkEnergy: Int,
		items: [Item],
		armors: [Armor],
		weapons: [Weapon]
	) {
		self.experience = experience
		self.gold = gold
		self.darkEnergy = darkEnergy
		self.items = items
		self.armors = armors
		self.weapons = weapons
	}
	
	func getItems() -> [Item] {
		self.items
	}
}
