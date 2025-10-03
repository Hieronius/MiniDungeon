import Foundation

// MARK: - ItemProtocol

protocol ItemProtocol: Identifiable {
	
	var id: UUID { get }
	var label: String { get }
	var itemType: ItemType { get }
	var itemLevel: Int { get }
	var description: String { get }
	var price: Int { get }
}

// MARK: - ItemType

enum ItemType {
	
	case weapon
	case armor
	case potion
	case loot
}

// MARK: - ItemManager

struct ItemManager {
	
	static let potions: [Item] = [
		
		Item(label: "Small Health Potion", itemType: .potion, itemLevel: 1, description: "Heals by 25% of maximum HP", price: 75),
		
		Item(label: "Mana Potion", itemType: .potion, itemLevel: 1, description: "Resumes mana by 25% of maximum MP", price: 75),
		
		Item(label: "Great Health Elixir", itemType: .potion, itemLevel: 2, description: "Adds 10% to maximum HP", price: 300),
		
		Item(label: "Great Mana Elixir", itemType: .potion, itemLevel: 2, description: "Adds 10% to maximum MP", price: 300),
		
		// + damage potion
		// + hp potion
		// + defence potion
		// + mana potion
		// restore all stats potion
		// and so on
	]
	
	static let loot: [Item] = [
		
		Item(label: "Trinket", itemType: .loot, itemLevel: 1, description: "An old and chip accessory", price: 50),
		
		Item(label: "Bronze Ring", itemType: .loot, itemLevel: 1, description: "An old ring", price: 75),
		
		Item(label: "Cracked Jewel", itemType: .loot, itemLevel: 1, description: "Probably was fansy when someone woar it", price: 100)
	]
}

// MARK: - Item

struct Item: ItemProtocol, Hashable {
	
	let id = UUID()
	let label: String
	var itemType: ItemType
	let itemLevel: Int
	let description: String
	var amount: Int?
	let price: Int
	
	init(
		label: String,
		itemType: ItemType,
		itemLevel: Int,
		description: String,
		price: Int
	) {
		self.label = label
		self.itemLevel = itemLevel
		self.itemType = itemType
		self.description = description
		self.price = price
	}
}
