import Foundation

struct ArmorManager {
	
	static let armors: [Armor] = [
		
		Armor(label: "Cloth",
			  itemLevel: 1,
			  itemType: .armor,
			  description: "+1 Defence",
			  defence: 1,
			  price: 100),
		
		Armor(label: "Boiled Leather Armor",
			  itemLevel: 2,
			  itemType: .armor,
			  description: "+2 Defence",
			  defence: 2,
			  price: 200),
		
		Armor(label: "Bronze Armor",
			  itemLevel: 3,
			  itemType: .armor,
			  description: "+3 Defence",
			  defence: 3,
			  price: 300),
		
		Armor(label: "Steel Armor",
			  itemLevel: 4,
			  itemType: .armor,
			  description: "+4 Defence",
			  defence: 4,
			  price: 400),
		
		Armor(label: "Bone Armor",
			  itemLevel: 5,
			  itemType: .armor,
			  description: "+5 Defence",
			  defence: 5,
			  price: 500)
	]
}

struct Armor: ItemProtocol, Hashable {
	
	let id = UUID()
	let label: String
	let itemType: ItemType
	let itemLevel: Int
	let description: String
	let defence: Int
	let price: Int
	
	init(label: String,
		 itemLevel: Int,
		 itemType: ItemType,
		 description: String,
		 defence: Int,
		 price: Int) {
		
		self.label = label
		self.itemLevel = itemLevel
		self.itemType = itemType
		self.description = description
		self.defence = defence
		self.price = price
	}
}
