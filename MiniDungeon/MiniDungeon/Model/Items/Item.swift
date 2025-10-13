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
		),
		
		Item(
			label: "Small Energy Restoration Potion",
			itemType: .potion,
			itemLevel: 1,
			description: "Restores ENERGY by 1",
			price: 200
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
			description: "+1% hit chance",
			price: 300
		)
	]
	
	// MARK: - Epic Potions
	
	static let epicPotions: [Item] = [
		
		// A few normal and powerful ones and other should be corrupted to give not only benefits but also negative side effects
		
		Item(
			label: "Huge Health Restoration Potion",
			itemType: .potion,
			itemLevel: 3,
			description: "Heals by 35% of max health",
			price: 500
		),
		
		Item(
			label: "Huge Mana Restoration Potion",
			itemType: .potion,
			itemLevel: 3,
			description: "Restores mana by 35% of it's max capacity",
			price: 500
		),
		
		Item(
			label: "Elixir of Strength",
			itemType: .potion,
			itemLevel: 3,
			description: "+1 min damage, +1 max damage",
			price: 600
		),
		
		Item(
			label: "Huge Elixir of Tortoise",
			itemType: .potion,
			itemLevel: 3,
			description: "+20 health, -1% hit chance",
			price: 500
		),
		
		Item(
			label: "Huge Elixir of Wisdom",
			itemType: .potion,
			itemLevel: 3,
			description: "+3 spell power, -1 max damage",
			price: 500
		),
		
		Item(
			label: "Huge Elixir of Boldness",
			itemType: .potion,
			itemLevel: 3,
			description: "+3% crit chance, -20 health, -20 mana",
			price: 500
		),
		
		Item(
			label: "Huge Elixir of Accuracy",
			itemType: .potion,
			itemLevel: 3,
			description: "+3% hit chance, -1 armor, -1 spell power",
			price: 500
		)
		
	]
	
	// MARK: - Legendary Potions
	
	static let legendaryPotions: [Item] = [
		
		Item(
			label: "Legendary Potion of Energy",
			itemType: .potion,
			itemLevel: 4,
			description: "+1 ENERGY",
			price: 1500
		),
		
		Item(
			label: "Legendary Potion of Strength",
			itemType: .potion,
			itemLevel: 4,
			description: "+2 min damage, +2 max damage, +1% hit chance, +1% crit chance",
			price: 1500
		),
		
		Item(
			label: "Corrupted Elixir of Agility",
			itemType: .potion,
			itemLevel: 4,
			description: "+5% crit chance, -2% hit chance, -30 health, -30 mana",
			price: 1500
		),
		
		Item(
			label: "Corrupted Elixir of Wisdom",
			itemType: .potion,
			itemLevel: 4,
			description: "+5 spell power, +30 mana, -2% crit chance, -30 health",
			price: 1500
		),
		
		Item(
			label: "Corrupted Elixir of Behemoth",
			itemType: .potion,
			itemLevel: 4,
			description: "+3 Defence, +50 health, -1% crit chance, -1% hit chance, -30 mana, -3 spell power",
			price: 1500
		),
		
		Item(
			label: "Corrupted Elixir of Focus",
			itemType: .potion,
			itemLevel: 4,
			description: "+5% hit chance, -1% crit chance, -20 health, -1 defence, -20 mana, -1 spell power",
			price: 1500
		),
	]
	
	// MARK: - Loot
	
	static let loot: [Item] = [
		
		Item(label: "Trinket", itemType: .loot, itemLevel: 1, description: "An old and chip accessory", price: 150),
		
		Item(label: "Bronze Ring", itemType: .loot, itemLevel: 1, description: "An old ring", price: 300),
		
		Item(label: "Cracked Jewel", itemType: .loot, itemLevel: 1, description: "Probably was fansy when someone woar it", price: 500)
	]
	
	// MARK: GeneratePotion()
	
	/// Method gets rarity of the potion and generates one accordingly
	static func generatePotion(of rarity: Rarity) -> Item? {
		
		switch rarity {
			
		case .common: return self.commonPotions.randomElement()
		case .rare: return self.rarePotions.randomElement()
		case .epic: return self.epicPotions.randomElement()
		case .legendary: return self.legendaryPotions.randomElement()
		}
	}
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
