import Foundation

// MARK: - ItemProtocol

protocol ItemProtocol: Identifiable {
	
	var id: String { get }
//	var id: UUID { get }
	var label: String { get }
	var itemType: ItemType { get }
	var itemLevel: Int { get }
	var itemDescription: String { get }
	var price: Int { get }
}

// MARK: - ItemType

enum ItemType: Codable {
	
	case weapon
	case armor
	case potion
	case loot
}

// MARK: - Item

/// Entity to store all information about basic object of the inventory
struct Item: ItemProtocol, Hashable, Codable, Identifiable {
	
//	let id: UUID
//	let id = UUID()
	let id: String
	var label: String
	var itemType: ItemType
	var itemLevel: Int
	var itemDescription: String
	var amount: Int?
	var price: Int
	
	init(
		label: String,
		itemType: ItemType,
		itemLevel: Int,
		itemDescription: String,
		price: Int
	) {
//		self.id = UUID()
		self.id = "\(label)"
		self.label = label
		self.itemLevel = itemLevel
		self.itemType = itemType
		self.itemDescription = itemDescription
		self.price = price
	}
}

// MARK: - ItemManager

/// Data Type to hold all possible items of loot and potions
struct ItemManager {
	
	// MARK: - Common Loot
	
	static let commonLoot: [Item] = [
		
		Item(
			label: "Key",
			itemType: .loot,
			itemLevel: 1,
			itemDescription: "Can open the Chest",
			price: 100
		),
		
		Item(
			label: "Broken Trinket",
			itemType: .loot,
			itemLevel: 1,
			itemDescription: "An old and chip accessory",
			price: 75
		),
		
		Item(
			label: "Cheap gem",
			itemType: .loot,
			itemLevel: 1,
			itemDescription: "Really cheap",
			price: 75
		),
		
		Item(
			label: "Cracked Jewel",
			itemType: .loot,
			itemLevel: 1,
			itemDescription: "Probably was fancy when was new",
			price: 75
		),
		
		Item(
			label: "Darkened Ring",
			itemType: .loot,
			itemLevel: 1,
			itemDescription: "You can't see it's original color",
			price: 75
		),
		
		Item(
			label: "Damaged Necklace",
			itemType: .loot,
			itemLevel: 1,
			itemDescription: "Part of it is missing",
			price: 75
		),
	]
	
	// MARK: - Rare Loot
	
	static let rareLoot: [Item] = [
		
		Item(
			label: "Steel Ring",
			itemType: .loot,
			itemLevel: 2,
			itemDescription: "Just a ring",
			price: 100
		),
		
		Item(
			label: "Bronze Necklace",
			itemType: .loot,
			itemLevel: 2,
			itemDescription: "An ordinary one",
			price: 100
		),
		
		Item(
			label: "Old Ridge",
			itemType: .loot,
			itemLevel: 2,
			itemDescription: "Still handy if you want to get your hair in order",
			price: 100
		),
		
		Item(
			label: "White Stud",
			itemType: .loot,
			itemLevel: 2,
			itemDescription: "Someone important was probably wearing it",
			price: 100
		),
		
		Item(
			label: "Gray Chain",
			itemType: .loot,
			itemLevel: 2,
			itemDescription: "Probably was part of some kind of a costume",
			price: 100
		),
	]
	
	// MARK: - Epic Loot
	
	static let epicLoot: [Item] = [
		
		Item(
			label: "Moon Stone",
			itemType: .loot,
			itemLevel: 3,
			itemDescription: "A shiny and beautiful gem",
			price: 150
		),
		
		Item(
			label: "Golden Statue",
			itemType: .loot,
			itemLevel: 3,
			itemDescription: "Statue of someone important like a king or a lord",
			price: 150
		),
		
		Item(
			label: "Silver Mirror",
			itemType: .loot,
			itemLevel: 3,
			itemDescription: "An old but still well made mirror",
			price: 150
		),
		
		Item(
			label: "Painted Vase",
			itemType: .loot,
			itemLevel: 3,
			itemDescription: "You still can see an epic battle between a dragon and a knight described on it",
			price: 150
		),
		
		Item(
			label: "Scarlet Ruby",
			itemType: .loot,
			itemLevel: 3,
			itemDescription: "Probably ment to be used in one of these well made king's crowns",
			price: 150
		),
	]
	
	// MARK: - Legendary Loot
	
	static let legendaryLoot: [Item] = [
		
		Item(
			label: "Perfect Diamond",
			itemType: .loot,
			itemLevel: 4,
			itemDescription: "A truly perfect gem",
			price: 300
		),
		
		Item(
			label: "Jewel-encrusted Casket",
			itemType: .loot,
			itemLevel: 4,
			itemDescription: "An empty but very expensive chest",
			price: 300
		),
		
		Item(
			label: "Violet Soul Crystal",
			itemType: .loot,
			itemLevel: 4,
			itemDescription: "As legend tells that kind of crystal can be a storage or a prison for poor's souls",
			price: 300
		),
		
		Item(
			label: "Ivory Flute covered with gold",
			itemType: .loot,
			itemLevel: 4,
			itemDescription: "You still can try to made a sound from this thing",
			price: 300
		),
		
		Item(
			label: "Giant Silver Cup",
			itemType: .loot,
			itemLevel: 4,
			itemDescription: "Cup so huge you think only giant's king could drink from it",
			price: 300
		),
	]
	
	// MARK: - Common Potions
	
	static let commonPotions: [Item] = [
		
		Item(
			label: "Small Health Restoration Potion",
			itemType: .potion,
			itemLevel: 1,
			itemDescription: "Heals by 10% of maximum HP",
			price: 150
		),
		
		Item(
			label: "Small Mana Restoration Potion",
			itemType: .potion,
			itemLevel: 1,
			itemDescription: "Restore mana by 10% of maximum MP",
			price: 150
		),
		
		Item(
			label: "Small Energy Restoration Potion",
			itemType: .potion,
			itemLevel: 1,
			itemDescription: "Restores ENERGY by 1",
			price: 200
		)
	]
	
	// MARK: - Rare Potions
	
	static let rarePotions: [Item] = [
		
		Item(
			label: "Health Restoration Potion",
			itemType: .potion,
			itemLevel: 2,
			itemDescription: "Heals by 25% of max HP",
			price: 300
		),
		
		Item(
			label: "Mana Restoration Potion",
			itemType: .potion,
			itemLevel: 2,
			itemDescription: "Restore mana by 25% of max MP",
			price: 300
		),
		
		Item(
			label: "Small Health Pool Elixir",
			itemType: .potion,
			itemLevel: 2,
			itemDescription: "+5 current HP, +5 max HP",
			price: 300
		),
		
		Item(
			label: "Small Mana Pool Elixir",
			itemType: .potion,
			itemLevel: 2,
			itemDescription: "+5 current MP, +5 max MP",
			price: 300
		),
		
		Item(
			label: "Small Wolf Tonic",
			itemType: .potion,
			itemLevel: 2,
			itemDescription: "+1 min damage",
			price: 300
		),
		
		Item(
			label: "Small Bear Tonic",
			itemType: .potion,
			itemLevel: 2,
			itemDescription: "+1 max damage",
			price: 300
		),
		
		Item(
			label: "Small Fox Tonic",
			itemType: .potion,
			itemLevel: 2,
			itemDescription: "+1% crit chance",
			price: 300
		),
		
		Item(
			label: "Small Owl Tonic",
			itemType: .potion,
			itemLevel: 2,
			itemDescription: "+1 spell power",
			price: 300
		),
		
		Item(
			label: "Small Iguana Tonic",
			itemType: .potion,
			itemLevel: 2,
			itemDescription: "+1% hit chance",
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
			itemDescription: "Heals by 35% of max health",
			price: 500
		),
		
		Item(
			label: "Huge Mana Restoration Potion",
			itemType: .potion,
			itemLevel: 3,
			itemDescription: "Restores mana by 35% of it's max capacity",
			price: 500
		),
		
		Item(
			label: "Elixir of Strength",
			itemType: .potion,
			itemLevel: 3,
			itemDescription: "+1 min damage, +1 max damage",
			price: 600
		),
		
		Item(
			label: "Huge Elixir of Tortoise",
			itemType: .potion,
			itemLevel: 3,
			itemDescription: "+20 health, -1% hit chance",
			price: 500
		),
		
		Item(
			label: "Huge Elixir of Wisdom",
			itemType: .potion,
			itemLevel: 3,
			itemDescription: "+3 spell power, -1 max damage",
			price: 500
		),
		
		Item(
			label: "Huge Elixir of Boldness",
			itemType: .potion,
			itemLevel: 3,
			itemDescription: "+3% crit chance, -20 health, -20 mana",
			price: 500
		),
		
		Item(
			label: "Huge Elixir of Accuracy",
			itemType: .potion,
			itemLevel: 3,
			itemDescription: "+3% hit chance, -1 armor, -1 spell power",
			price: 500
		)
		
	]
	
	// MARK: - Legendary Potions
	
	static let legendaryPotions: [Item] = [
		
		Item(
			label: "Legendary Potion of Energy",
			itemType: .potion,
			itemLevel: 4,
			itemDescription: "+1 ENERGY",
			price: 1500
		),
		
		Item(
			label: "Legendary Potion of Strength",
			itemType: .potion,
			itemLevel: 4,
			itemDescription: "+2 min damage, +2 max damage, +1% hit chance, +1% crit chance",
			price: 1500
		),
		
		Item(
			label: "Corrupted Elixir of Agility",
			itemType: .potion,
			itemLevel: 4,
			itemDescription: "+5% crit chance, -2% hit chance, -30 health, -30 mana",
			price: 1500
		),
		
		Item(
			label: "Corrupted Elixir of Wisdom",
			itemType: .potion,
			itemLevel: 4,
			itemDescription: "+5 spell power, +30 mana, -2% crit chance, -30 health",
			price: 1500
		),
		
		Item(
			label: "Corrupted Elixir of Behemoth",
			itemType: .potion,
			itemLevel: 4,
			itemDescription: "+3 Defence, +50 health, -1% crit chance, -1% hit chance, -30 mana, -3 spell power",
			price: 1500
		),
		
		Item(
			label: "Corrupted Elixir of Focus",
			itemType: .potion,
			itemLevel: 4,
			itemDescription: "+5% hit chance, -1% crit chance, -20 health, -1 defence, -20 mana, -1 spell power",
			price: 1500
		),
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
	
	// MARK: - GenerateLoot()
	
	/// Method gets rarity of the loot and generates one accordingly
	static func generateLoot(of rarity: Rarity) -> Item? {
		
		switch rarity {
			
		case .common: return self.commonLoot.randomElement()
		case .rare: return self.rareLoot.randomElement()
		case .epic: return self.epicLoot.randomElement()
		case .legendary: return self.legendaryLoot.randomElement()
		}
	}
	
	// MARK: - returnKeyItem()
	
	/// method to pass an exact Key Item to work with
	static func returnKeyItem() -> Item {
		return self.commonLoot[0]
	}
}
