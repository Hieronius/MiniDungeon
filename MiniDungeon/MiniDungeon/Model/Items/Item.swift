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
		
		Item(
			label: "Small Health Potion",
			itemType: .potion,
			itemLevel: 1,
			description: "Heals by 25% of maximum HP",
			price: 150
		),
		
		Item(
			label: "Mana Potion",
			itemType: .potion,
			itemLevel: 1,
			description: "Resumes mana by 25% of maximum MP",
			price: 150
		),
		
		Item(
			label: "Great Health Elixir",
			itemType: .potion,
			itemLevel: 2,
			description: "Adds 10% to maximum HP",
			price: 600
		),
		
		Item(
			label: "Great Mana Elixir",
			itemType: .potion,
			itemLevel: 2,
			description: "Adds 10% to maximum MP",
			price: 600
		),
		
		// + damage potion
		// + hp potion
		// + defence potion
		// + mana potion
		// restore all stats potion
		// and so on
	]
	
	// MARK: - Common Potions
	
	static let commonPotions: [Item] = [
		
		Item(
			label: "Small Health Restoration Potion",
			itemType: .potion,
			itemLevel: 1,
			description: "Heals by 10% of maximum HP",
			price: 150
		),
		
		Item(
			label: "Small Mana Restoration Potion",
			itemType: .potion,
			itemLevel: 1,
			description: "Restore mana by 10% of maximum MP",
			price: 150
		)
	]
	
	// MARK: - Rare Potions
	
	static let rarePotions: [Item] = [
		
		Item(
			label: "Health Restoration Potion",
			itemType: .potion,
			itemLevel: 2,
			description: "Heals by 25% of max HP",
			price: 300
		),
		
		Item(
			label: "Mana Restoration Potion",
			itemType: .potion,
			itemLevel: 2,
			description: "Restore mana by 25% of max MP",
			price: 300
		),
		
		Item(
			label: "Small Health Pool Elixir",
			itemType: .potion,
			itemLevel: 2,
			description: "+5 current HP, +5 max HP",
			price: 300
		),
		
		Item(
			label: "Small Mana Pool Elixir",
			itemType: .potion,
			itemLevel: 2,
			description: "+5 current MP, +5 max MP",
			price: 300
		),
		
		Item(
			label: "Small Wolf Tonic",
			itemType: .potion,
			itemLevel: 2,
			description: "+1 min damage",
			price: 300
		),
		
		Item(
			label: "Small Bear Tonic",
			itemType: .potion,
			itemLevel: 2,
			description: "+1 max damage",
			price: 300
		),
		
		Item(
			label: "Small Fox Tonic",
			itemType: .potion,
			itemLevel: 2,
			description: "+1% crit chance",
			price: 300
		),
		
		Item(
			label: "Small Owl Tonic",
			itemType: .potion,
			itemLevel: 2,
			description: "+1 spell power",
			price: 300
		),
		
		Item(
			label: "Small Iguana Tonic",
			itemType: .potion,
			itemLevel: 2,
			description: "1% hit chance",
			price: 300
		)
	]
	
	// MARK: - Epic Potions
	
	static let epicPotions: [Item] = [
		
		// A few normal and powerful ones and other should be corrupted to give not only benefits but also negative side effects
		
	]
	
	// MARK: - Legendary Potions
	
	static let legendaryPotions: [Item] = [
		
		
	]
	
	// MARK: - Loot
	
	static let loot: [Item] = [
		
		Item(label: "Trinket", itemType: .loot, itemLevel: 1, description: "An old and chip accessory", price: 150),
		
		Item(label: "Bronze Ring", itemType: .loot, itemLevel: 1, description: "An old ring", price: 300),
		
		Item(label: "Cracked Jewel", itemType: .loot, itemLevel: 1, description: "Probably was fansy when someone woar it", price: 500)
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
