import Foundation

struct ArmorManager {
	
	static let armors: [Armor] = [
		
		Armor(label: "Cloth", defence: 1),
		Armor(label: "Boiled Leather Armor", defence: 2),
		Armor(label: "Bronze Armor", defence: 3),
		Armor(label: "Steel Armor", defence: 4),
		Armor(label: "Bone Armor", defence: 5)
	]
}

struct Armor {
	
	let label: String
	let defence: Int
	
	init(label: String,
		 defence: Int) {
		
		self.label = label
		self.defence = defence
	}
}
