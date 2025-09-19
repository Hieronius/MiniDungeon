import Foundation

struct ArmorManager {
	
	static let armors: [Armor] = [
		
		Armor(label: "Cloth",
			  itemLevel: 1,
			  defence: 1),
		
		Armor(label: "Boiled Leather Armor",
			  itemLevel: 2,
			  defence: 2),
		
		Armor(label: "Bronze Armor",
			  itemLevel: 3,
			  defence: 3),
		
		Armor(label: "Steel Armor",
			  itemLevel: 4,
			  defence: 4),
		
		Armor(label: "Bone Armor",
			  itemLevel: 5,
			  defence: 5)
	]
}

struct Armor: ItemProtocol {
	
	let id = UUID()
	let label: String
	let itemLevel: Int
	let defence: Int
	
	init(label: String,
		 itemLevel: Int,
		 defence: Int) {
		
		self.label = label
		self.itemLevel = itemLevel
		self.defence = defence
	}
}
