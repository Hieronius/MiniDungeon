import Foundation

protocol ItemProtocol: Identifiable {
	
	var label: String { get }
	var id: UUID { get }
}

struct ItemManager {
	
	static let potions: [Item] = [
		
		Item(label: "Small Health Potion", itemLevel: 1, description: "Heals by 25% of maximum HP", price: 75),
		
		Item(label: "Mana Potion", itemLevel: 1, description: "Resumes mana by 25% of maximum MP", price: 75),
		
		Item(label: "Great Health Elixir", itemLevel: 2, description: "Adds 10% to maximum HP", price: 300),
		
		Item(label: "Great Mana Elixir", itemLevel: 2, description: "Adds 10% to maximum MP", price: 300),
		
		// + damage potion
		// + hp potion
		// + defence potion
		// + mana potion
		// restore all stats potion
		// and so on
	]
	
	static let loot: [Item] = [
		
		Item(label: "Trinket", itemLevel: 1, description: "An old and chip accessory", price: 50),
		
		Item(label: "Bronze Ring", itemLevel: 1, description: "An old ring", price: 75),
		
		Item(label: "Cracked Jewel", itemLevel: 1, description: "Probably was fansy when someone woar it", price: 100)
	]
}

struct Item: ItemProtocol {
	
	let id = UUID()
	let label: String
	let itemLevel: Int
	let description: String
	var amount: Int?
	let price: Int
	
	init(
		label: String,
		itemLevel: Int,
		description: String,
		price: Int
	) {
		self.label = label
		self.itemLevel = itemLevel
		self.description = description
		self.price = price
	}
}
