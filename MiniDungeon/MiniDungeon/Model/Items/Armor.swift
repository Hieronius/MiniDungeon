import Foundation

struct ArmorManager {
	
//	static let armors: [Armor] = [
//		
//		Armor(label: "Cloth",
//			  itemLevel: 1,
//			  itemType: .armor,
//			  description: "+1 Defence, +5 health, +5 mana",
//			  defence: 1,
//			  healthBonus: 5,
//			  manaBonus: 5,
//			  energyBonus: 0,
//			  spellPowerBonus: 0,
//			  critChanceBonus: 0,
//			  hitChanceBonus: 0,
//			  price: 100),
//		
//		Armor(label: "Boiled Leather Armor",
//			  itemLevel: 2,
//			  itemType: .armor,
//			  description: "+2 Defence",
//			  defence: 2,
//			  healthBonus: 10,
//			  manaBonus: 10,
//			  energyBonus: 0,
//			  spellPowerBonus: 0,
//			  critChanceBonus: 0,
//			  hitChanceBonus: 0,
//			  price: 200),
//		
//		Armor(label: "Bronze Armor",
//			  itemLevel: 3,
//			  itemType: .armor,
//			  description: "+3 Defence",
//			  defence: 3,
//			  healthBonus: 15,
//			  manaBonus: 15,
//			  energyBonus: 0,
//			  spellPowerBonus: 0,
//			  critChanceBonus: 0,
//			  hitChanceBonus: 0,
//			  price: 300),
//		
//		Armor(label: "Steel Armor",
//			  itemLevel: 4,
//			  itemType: .armor,
//			  description: "+4 Defence",
//			  defence: 4,
//			  healthBonus: 20,
//			  manaBonus: 20,
//			  energyBonus: 0,
//			  spellPowerBonus: 0,
//			  critChanceBonus: 0,
//			  hitChanceBonus: 0,
//			  price: 400),
//		
//		Armor(label: "Bone Armor",
//			  itemLevel: 5,
//			  itemType: .armor,
//			  description: "+5 Defence",
//			  defence: 5,
//			  healthBonus: 25,
//			  manaBonus: 25,
//			  energyBonus: 1,
//			  spellPowerBonus: 0,
//			  critChanceBonus: 0,
//			  hitChanceBonus: 0,
//			  price: 500)
//	]
	
	// MARK: - Common Armors
	
	static let commonArmors: [Armor] = [
		
		Armor(label: "Torn cloak",
			  itemLevel: 1,
			  itemType: .armor,
			  description: "+5 health, +5 mana",
			  defence: 0,
			  healthBonus: 5,
			  manaBonus: 5,
			  energyBonus: 0,
			  spellPowerBonus: 0,
			  critChanceBonus: 0,
			  hitChanceBonus: 0,
			  price: 75),
		
		Armor(
			label: "Ripped Lether Armor",
			itemLevel: 1,
			itemType: .armor,
			description: "+1 defence, +2 health, +2 mana",
			defence: 1,
			healthBonus: 2,
			manaBonus: 2,
			energyBonus: 0,
			spellPowerBonus: 0,
			critChanceBonus: 0,
			hitChanceBonus: 0,
			price: 75
		),
		
		Armor(
			label: "Old Priest Robe",
			itemLevel: 1,
			itemType: .armor,
			description: "+10 mana",
			defence: 0,
			healthBonus: 0,
			manaBonus: 10,
			energyBonus: 0,
			spellPowerBonus: 0,
			critChanceBonus: 0,
			hitChanceBonus: 0,
			price: 75
		),
		
		Armor(
			label: "Colorless Mage Tunic",
			itemLevel: 1,
			itemType: .armor,
			description: "+1 spell power, +5 mana",
			defence: 0,
			healthBonus: 0,
			manaBonus: 5,
			energyBonus: 0,
			spellPowerBonus: 1,
			critChanceBonus: 0,
			hitChanceBonus: 0,
			price: 75
		),
		
		Armor(
			label: "Blood Stained Knight Cloak",
			itemLevel: 1,
			itemType: .armor,
			description: "+10 health",
			defence: 0,
			healthBonus: 10,
			manaBonus: 0,
			energyBonus: 0,
			spellPowerBonus: 0,
			critChanceBonus: 0,
			hitChanceBonus: 0,
			price: 75
		),
		
		Armor(
			label: "Thin Assasin's Cloak ",
			itemLevel: 1,
			itemType: .armor,
			description: "+1% crit chance",
			defence: 0,
			healthBonus: 0,
			manaBonus: 0,
			energyBonus: 0,
			spellPowerBonus: 0,
			critChanceBonus: 1,
			hitChanceBonus: 0,
			price: 75
		)
	]
	
	// MARK: - Rare Armors
	
	static let rareArmors: [Armor] = [
		
		Armor(
			label: "Damaged Plate Armor",
			itemLevel: 2,
			itemType: .armor,
			description: "+2 defence, +10 health",
			defence: 2,
			healthBonus: 10,
			manaBonus: 0,
			energyBonus: 0,
			spellPowerBonus: 0,
			critChanceBonus: 0,
			hitChanceBonus: 0,
			price: 150
		),
		
		Armor(
			label: "Boiled Leather Armor",
			itemLevel: 2,
			itemType: .armor,
			description: "+2 defence, +10 health, +10 mana",
			defence: 2,
			healthBonus: 10,
			manaBonus: 10,
			energyBonus: 0,
			spellPowerBonus: 0,
			critChanceBonus: 0,
			hitChanceBonus: 0,
			price: 200
		),
		
		Armor(
			label: "Mage's robe",
			itemLevel: 2,
			itemType: .armor,
			description: "+1 defence, +10 mana, +1 spell power",
			defence: 1,
			healthBonus: 0,
			manaBonus: 10,
			energyBonus: 0,
			spellPowerBonus: 1,
			critChanceBonus: 0,
			hitChanceBonus: 0,
			price: 200
		),
		
		Armor(
			label: "Priest's Tunic",
			itemLevel: 2,
			itemType: .armor,
			description: "+1 defence, + 20 mana",
			defence: 1,
			healthBonus: 0,
			manaBonus: 20,
			energyBonus: 0,
			spellPowerBonus: 0,
			critChanceBonus: 0,
			hitChanceBonus: 0,
			price: 200
		),
		
		Armor(
			label: "Squire Jacket",
			itemLevel: 2,
			itemType: .armor,
			description: "+1 defence, +10 health, + 1% hit chance",
			defence: 1,
			healthBonus: 10,
			manaBonus: 0,
			energyBonus: 0,
			spellPowerBonus: 0,
			critChanceBonus: 0,
			hitChanceBonus: 1,
			price: 200
		),
		
		Armor(
			label: "Thief Costume",
			itemLevel: 2,
			itemType: .armor,
			description: "+2% crit chance, +1% hit chance",
			defence: 0,
			healthBonus: 0,
			manaBonus: 0,
			energyBonus: 0,
			spellPowerBonus: 0,
			critChanceBonus: 2,
			hitChanceBonus: 1,
			price: 200
		)
	]
	
	// MARK: - Epic Armors
	
	static let epicArmors: [Armor] = [
		
		// Items should inclued "corrapted versions" with negative effects
		// Start with just adding penalties like: "-1 crit chance, -1 hit chance and so on"
		
		Armor(
			label: "Great Plate Armor",
			itemLevel: 3,
			itemType: .armor,
			description: "+2 defence, +20 health, +1% hit chance",
			defence: 2,
			healthBonus: 20,
			manaBonus: 0,
			energyBonus: 0,
			spellPowerBonus: 0,
			critChanceBonus: 0,
			hitChanceBonus: 1,
			price: 250
		),
		
		Armor(
			label: "Bronze Armor",
			itemLevel: 3,
			itemType: .armor,
			description: "+3 Defence, +15 health, +15 mana",
			defence: 3,
			healthBonus: 15,
			manaBonus: 15,
			energyBonus: 0,
			spellPowerBonus: 0,
			critChanceBonus: 0,
			hitChanceBonus: 0,
			price: 300
		),
		
		Armor(
			label: "Corrupted tunic",
			itemLevel: 3,
			itemType: .armor,
			description: "+1 defence, +40 mana, -20 health, +5 spell power, -1% crit chance, -1% hit chance",
			defence: 1,
			healthBonus: -20,
			manaBonus: 40,
			energyBonus: 0,
			spellPowerBonus: 5,
			critChanceBonus: -1,
			hitChanceBonus: -1,
			price: 250
		),
		
		Armor(
			label: "Corrupted Composite Armor",
			itemLevel: 3,
			itemType: .armor,
			description: "+5 defence, -20 health, -20 mana, -2 spell power, -1% crit chance, -1% hit chance",
			defence: 5,
			healthBonus: -20,
			manaBonus: -20,
			energyBonus: 0,
			spellPowerBonus: -2,
			critChanceBonus: -1,
			hitChanceBonus: -1,
			price: 250
		),
		
		Armor(
			label: "Great Wisard Robe",
			itemLevel: 3,
			itemType: .armor,
			description: "+1 defence, +20 health, +20 mana, +3 spell power, +1% crit chance, +1% hit chance",
			defence: 1,
			healthBonus: 20,
			manaBonus: 20,
			energyBonus: 0,
			spellPowerBonus: 3,
			critChanceBonus: 1,
			hitChanceBonus: 1,
			price: 250
		),
		
		Armor(
			label: "Corrupted Owl Mantle",
			itemLevel: 3,
			itemType: .armor,
			description: "-2 defence, -10 health, -10 mana, +10 spell power, +2% crit chance, +2% hit chance",
			defence: -2,
			healthBonus: -10,
			manaBonus: -10,
			energyBonus: 0,
			spellPowerBonus: 10,
			critChanceBonus: 2,
			hitChanceBonus: 2,
			price: 250
		),
		
		Armor(
			label: "Corrupted Fox Suit",
			itemLevel: 3,
			itemType: .armor,
			description: "+1 defence, +10% crit chance, -20 health, -20 mana, -5 spell power, -5% hit chance",
			defence: 1,
			healthBonus: -20,
			manaBonus: -20,
			energyBonus: 0,
			spellPowerBonus: -5,
			critChanceBonus: 10,
			hitChanceBonus: -5,
			price: 250
		)
		
	]
	
	// MARK: - Legendary Armors
	
	static let legendaryArmors: [Armor] = [
		
		Armor(
			label: "Bone Armor",
			itemLevel: 4,
			itemType: .armor,
			description: "+5 Defence",
			defence: 5,
			healthBonus: 25,
			manaBonus: 25,
			energyBonus: 0,
			spellPowerBonus: 0,
			critChanceBonus: 0,
			hitChanceBonus: 0,
			price: 500
		),
		
		Armor(
			label: "Death Robe",
			itemLevel: 4,
			itemType: .armor,
			description: "+2 defence, +50 mana, +5 spell power, +2% crit chance, +2% hit chance, -25 health",
			defence: 2,
			healthBonus: -25,
			manaBonus: 50,
			energyBonus: 0,
			spellPowerBonus: 5,
			critChanceBonus: 2,
			hitChanceBonus: 2,
			price: 500
		),
		
		Armor(
			label: "Snake Armor",
			itemLevel: 4,
			itemType: .armor,
			description: "+1 ENERGY, +5 spell power, +5% crit chance, +5% hit chance, -5 DEFENCE, -25 health, -25 mana",
			defence: -5,
			healthBonus: -25,
			manaBonus: -25,
			energyBonus: 1,
			spellPowerBonus: 5,
			critChanceBonus: 5,
			hitChanceBonus: 5,
			price: 500
		),
		
		Armor(
			label: "Golden Armor",
			itemLevel: 4,
			itemType: .armor,
			description: "+2 defence, +100 health, +2% hit chance",
			defence: 2,
			healthBonus: 100,
			manaBonus: 0,
			energyBonus: 0,
			spellPowerBonus: 0,
			critChanceBonus: 0,
			hitChanceBonus: 2,
			price: 500
		),
		
		Armor(
			label: "Faraam Great Armor",
			itemLevel: 4,
			itemType: .armor,
			description: "+10 DEFENCE, +50 health, -50 mana, -1 ENERGY, -5 spell power, -5% crit chance, -5% hit chance",
			defence: 10,
			healthBonus: +50,
			manaBonus: -50,
			energyBonus: -1,
			spellPowerBonus: -5,
			critChanceBonus: -5,
			hitChanceBonus: -5,
			price: 500
		),
	]
	
	// MARK: GenerateArmor()
	
	/// Method gets rarity of the armor and generates one accordingly
	static func generateArmor(of rarity: Rarity) -> Armor? {
		
		switch rarity {
			
		case .common: return self.commonArmors.randomElement()
		case .rare: return self.rareArmors.randomElement()
		case .epic: return self.epicArmors.randomElement()
		case .legendary: return self.legendaryArmors.randomElement()
		}
	}
}

struct Armor: ItemProtocol, Hashable {
	
	let id = UUID()
	let label: String
	let itemType: ItemType
	let itemLevel: Int
	let description: String
	let defence: Int
	let healthBonus: Int
	let manaBonus: Int
	let energyBonus: Int
	let spellPowerBonus: Int
	let critChanceBonus: Int
	let hitChanceBonus: Int
	let price: Int
	
	init(label: String,
		 itemLevel: Int,
		 itemType: ItemType,
		 description: String,
		 defence: Int,
		 healthBonus: Int,
		 manaBonus: Int,
		 energyBonus: Int,
		 spellPowerBonus: Int,
		 critChanceBonus: Int,
		 hitChanceBonus: Int,
		 price: Int) {
		
		self.label = label
		self.itemLevel = itemLevel
		self.itemType = itemType
		self.description = description
		self.defence = defence
		self.healthBonus = healthBonus
		self.manaBonus = manaBonus
		self.energyBonus = energyBonus
		self.spellPowerBonus = spellPowerBonus
		self.critChanceBonus = critChanceBonus
		self.hitChanceBonus = hitChanceBonus
		self.price = price
	}
}
