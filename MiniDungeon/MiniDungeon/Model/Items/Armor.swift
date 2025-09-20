import Foundation

struct ArmorManager {
	
	static let armors: [Armor] = [
		
		Armor(label: "Cloth",
			  itemLevel: 1,
			  description: "Is it a real armor?",
			  defence: 1),
		
		Armor(label: "Boiled Leather Armor",
			  itemLevel: 2,
			  description: "And there might be Fried Armor as well?",
			  defence: 2),
		
		Armor(label: "Bronze Armor",
			  itemLevel: 3,
			  description: "Finally something like a real ARMOR",
			  defence: 3),
		
		Armor(label: "Steel Armor",
			  itemLevel: 4,
			  description: "Uf, it's heavy",
			  defence: 4),
		
		Armor(label: "Bone Armor",
			  itemLevel: 5,
			  description: "Seems fansy",
			  defence: 5)
	]
}

struct Armor: ItemProtocol {
	
	let id = UUID()
	let label: String
	let itemLevel: Int
	let description: String
	let defence: Int
	
	init(label: String,
		 itemLevel: Int,
		 description: String,
		 defence: Int) {
		
		self.label = label
		self.itemLevel = itemLevel
		self.description = description
		self.defence = defence
	}
}
