import Foundation

struct Armor: ItemProtocol, Hashable, Codable, Identifiable {
	
	//	let id: UUID
	//	let id = UUID()
	let id: String
	var labelEN: String
	var labelRU: String
	var itemType: ItemType
	var itemLevel: Int
	var itemDescriptionEN: String
	var itemDescriptionRU: String
	var defence: Int
	var healthBonus: Int
	var manaBonus: Int
	var energyBonus: Int
	var spellPowerBonus: Int
	var critChanceBonus: Int
	var hitChanceBonus: Int
	var rarity: Rarity
	var price: Int
	
	init(labelEN: String,
		 labelRU: String,
		 itemLevel: Int,
		 itemType: ItemType,
		 itemDescriptionEN: String,
		 itemDescriptionRU: String,
		 defence: Int,
		 healthBonus: Int,
		 manaBonus: Int,
		 energyBonus: Int,
		 spellPowerBonus: Int,
		 critChanceBonus: Int,
		 hitChanceBonus: Int,
		 rarity: Rarity,
		 price: Int) {
		
		//		self.id = UUID()
		self.id = "\(labelEN)"
		self.labelEN = labelEN
		self.labelRU = labelRU
		self.itemLevel = itemLevel
		self.itemType = itemType
		self.itemDescriptionEN = itemDescriptionEN
		self.itemDescriptionRU = itemDescriptionRU
		self.defence = defence
		self.healthBonus = healthBonus
		self.manaBonus = manaBonus
		self.energyBonus = energyBonus
		self.spellPowerBonus = spellPowerBonus
		self.critChanceBonus = critChanceBonus
		self.hitChanceBonus = hitChanceBonus
		self.rarity = rarity
		self.price = price
	}
}
	
	struct ArmorManager {
		
		// MARK: - Common Armors
		
		static let commonArmors: [Armor] = [
			
			Armor(
				labelEN: "Torn cloak",
				labelRU: "Разованная туника",
				itemLevel: 1,
				itemType: .armor,
				itemDescriptionEN: "+5 health, +5 mana",
				itemDescriptionRU: "+5 к максимальному уровню здоровья, +5 к максимальному уровню маны",
				defence: 0,
				healthBonus: 5,
				manaBonus: 5,
				energyBonus: 0,
				spellPowerBonus: 0,
				critChanceBonus: 0,
				hitChanceBonus: 0,
				rarity: .common,
				price: 75
			),
			
			Armor(
				labelEN: "Ripped Lether Armor",
				labelRU: "Надорванный кожаный доспех",
				itemLevel: 1,
				itemType: .armor,
				itemDescriptionEN: "+1 defence, +2 health, +2 mana",
				itemDescriptionRU: "+1 к броне, +2 к максимальному уровню здоровья, +2 к максимальному уровню маны",
				defence: 1,
				healthBonus: 2,
				manaBonus: 2,
				energyBonus: 0,
				spellPowerBonus: 0,
				critChanceBonus: 0,
				hitChanceBonus: 0,
				rarity: .common,
				price: 75
			),
			
			Armor(
				labelEN: "Old Priest Robe",
				labelRU: "Старая роба жреца",
				itemLevel: 1,
				itemType: .armor,
				itemDescriptionEN: "+10 mana",
				itemDescriptionRU: "+10 к максимальному уровню маны",
				defence: 0,
				healthBonus: 0,
				manaBonus: 10,
				energyBonus: 0,
				spellPowerBonus: 0,
				critChanceBonus: 0,
				hitChanceBonus: 0,
				rarity: .common,
				price: 75
			),
			
			Armor(
				labelEN: "Colorless Mage Tunic",
				labelRU: "Выцвевшая туника мага",
				itemLevel: 1,
				itemType: .armor,
				itemDescriptionEN: "+1 spell power, +5 mana",
				itemDescriptionRU: "+1 к силе заклинаний, +5 к максимальному уровню маны",
				defence: 0,
				healthBonus: 0,
				manaBonus: 5,
				energyBonus: 0,
				spellPowerBonus: 1,
				critChanceBonus: 0,
				hitChanceBonus: 0,
				rarity: .common,
				price: 75
			),
			
			Armor(
				labelEN: "Blood Stained Knight Cloak",
				labelRU: "Покрытая кровью туника рыцаря",
				itemLevel: 1,
				itemType: .armor,
				itemDescriptionEN: "+10 health",
				itemDescriptionRU: "+10 к максимальному уровню здоровья",
				defence: 0,
				healthBonus: 10,
				manaBonus: 0,
				energyBonus: 0,
				spellPowerBonus: 0,
				critChanceBonus: 0,
				hitChanceBonus: 0,
				rarity: .common,
				price: 75
			),
			
			Armor(
				labelEN: "Thin Assasin's Cloak",
				labelRU: "Легкая туника ассасина",
				itemLevel: 1,
				itemType: .armor,
				itemDescriptionEN: "+1% crit chance",
				itemDescriptionRU: "+1% к шансу критического эффекта",
				defence: 0,
				healthBonus: 0,
				manaBonus: 0,
				energyBonus: 0,
				spellPowerBonus: 0,
				critChanceBonus: 1,
				hitChanceBonus: 0,
				rarity: .common,
				price: 75
			)
		]
		
		// MARK: - Rare Armors
		
		static let rareArmors: [Armor] = [
			
			Armor(
				labelEN: "Damaged Plate Armor",
				labelRU: "Поврежденная пластинчатая броня",
				itemLevel: 2,
				itemType: .armor,
				itemDescriptionEN: "+2 defence, +10 health",
				itemDescriptionRU: "+2 к броне, +10 к максимальному уровню здоровья",
				defence: 2,
				healthBonus: 10,
				manaBonus: 0,
				energyBonus: 0,
				spellPowerBonus: 0,
				critChanceBonus: 0,
				hitChanceBonus: 0,
				rarity: .rare,
				price: 150
			),
			
			Armor(
				labelEN: "Boiled Leather Armor",
				labelRU: "Отличная кожаная броня",
				itemLevel: 2,
				itemType: .armor,
				itemDescriptionEN: "+2 defence, +10 health, +10 mana",
				itemDescriptionRU: "+2 к броне, +10 к максимальному уровню здоровья, +10 к максимальному уровню маны",
				defence: 2,
				healthBonus: 10,
				manaBonus: 10,
				energyBonus: 0,
				spellPowerBonus: 0,
				critChanceBonus: 0,
				hitChanceBonus: 0,
				rarity: .rare,
				price: 200
			),
			
			Armor(
				labelEN: "Mage's robe",
				labelRU: "Роба мага",
				itemLevel: 2,
				itemType: .armor,
				itemDescriptionEN: "+1 defence, +10 mana, +1 spell power",
				itemDescriptionRU: "+1 к броне, +10 к максимальному уровню маны, +10 к максимальному уровню здоровья",
				defence: 1,
				healthBonus: 0,
				manaBonus: 10,
				energyBonus: 0,
				spellPowerBonus: 1,
				critChanceBonus: 0,
				hitChanceBonus: 0,
				rarity: .rare,
				price: 200
			),
			
			Armor(
				labelEN: "Priest's Tunic",
				labelRU: "Туника жреца",
				itemLevel: 2,
				itemType: .armor,
				itemDescriptionEN: "+1 defence, +20 mana",
				itemDescriptionRU: "+1 к броне, +20 к максимальному уровню маны",
				defence: 1,
				healthBonus: 0,
				manaBonus: 20,
				energyBonus: 0,
				spellPowerBonus: 0,
				critChanceBonus: 0,
				hitChanceBonus: 0,
				rarity: .rare,
				price: 200
			),
			
			Armor(
				labelEN: "Squire Jacket",
				labelRU: "Жилет оруженосца",
				itemLevel: 2,
				itemType: .armor,
				itemDescriptionEN: "+1 defence, +10 health, +1% hit chance",
				itemDescriptionRU: "+1 к броне, +10 к здоровью, +1% к шансу критического эффекта",
				defence: 1,
				healthBonus: 10,
				manaBonus: 0,
				energyBonus: 0,
				spellPowerBonus: 0,
				critChanceBonus: 0,
				hitChanceBonus: 1,
				rarity: .rare,
				price: 200
			),
			
			Armor(
				labelEN: "Thief Costume",
				labelRU: "Одеяние вора",
				itemLevel: 2,
				itemType: .armor,
				itemDescriptionEN: "+2% crit chance, +1% hit chance",
				itemDescriptionRU: "+2% к шансу критического эффекта, +1% к шансу попадения по противнику",
				defence: 0,
				healthBonus: 0,
				manaBonus: 0,
				energyBonus: 0,
				spellPowerBonus: 0,
				critChanceBonus: 2,
				hitChanceBonus: 1,
				rarity: .rare,
				price: 200
			)
		]
		
		// MARK: - Epic Armors
		
		static let epicArmors: [Armor] = [
			
			// Items should inclued "corrapted versions" with negative effects
			// Start with just adding penalties like: "-1 crit chance, -1 hit chance and so on"
			
			Armor(
				labelEN: "Great Plate Armor",
				labelRU: "Отличная пластинчатая броня",
				itemLevel: 3,
				itemType: .armor,
				itemDescriptionEN: "+2 defence, +20 health, +1% hit chance",
				itemDescriptionRU: "+2 к броне, +20 к максимальному уровню здоровья, +1% к шансу попадения по противнику",
				defence: 2,
				healthBonus: 20,
				manaBonus: 0,
				energyBonus: 0,
				spellPowerBonus: 0,
				critChanceBonus: 0,
				hitChanceBonus: 1,
				rarity: .epic,
				price: 250
			),
			
			Armor(
				labelEN: "Bronze Armor",
				labelRU: "Бронзовая броня",
				itemLevel: 3,
				itemType: .armor,
				itemDescriptionEN: "+3 Defence, +15 health, +15 mana",
				itemDescriptionRU: "+3 к броне, +15 к максимальному уровню здоровья, +15 к максимальному уровню маны",
				defence: 3,
				healthBonus: 15,
				manaBonus: 15,
				energyBonus: 0,
				spellPowerBonus: 0,
				critChanceBonus: 0,
				hitChanceBonus: 0,
				rarity: .epic,
				price: 300
			),
			
			Armor(
				labelEN: "Corrupted tunic",
				labelRU: "Проклятая туника",
				itemLevel: 3,
				itemType: .armor,
				itemDescriptionEN: "+1 defence, +40 mana, -20 health, +5 spell power, -1% crit chance, -1% hit chance",
				itemDescriptionRU: "+1 к броне, +40 к максимальному уровню маны, -20 к максимальному уровню здоровья, +5 к силе заклинаний, -1% к шансу критического эффекта, -1% к шансу попадения по противнику",
				defence: 1,
				healthBonus: -20,
				manaBonus: 40,
				energyBonus: 0,
				spellPowerBonus: 5,
				critChanceBonus: -1,
				hitChanceBonus: -1,
				rarity: .epic,
				price: 250
			),
			
			Armor(
				labelEN: "Corrupted Composite Armor",
				labelRU: "Проклятая пластинчатая броня",
				itemLevel: 3,
				itemType: .armor,
				itemDescriptionEN: "+5 defence, -20 health, -20 mana, -2 spell power, -1% crit chance, -1% hit chance",
				itemDescriptionRU: "+5 к броне, -20 к максимальному уровню здоровья, -20 к максимальному уровню маны, -1% к шансу критического эффекта, -1% к шансу попадения по противнику",
				defence: 5,
				healthBonus: -20,
				manaBonus: -20,
				energyBonus: 0,
				spellPowerBonus: -2,
				critChanceBonus: -1,
				hitChanceBonus: -1,
				rarity: .epic,
				price: 250
			),
			
			Armor(
				labelEN: "Great Wisard Robe",
				labelRU: "Отличная роба волшебника",
				itemLevel: 3,
				itemType: .armor,
				itemDescriptionEN: "+1 defence, +20 health, +20 mana, +3 spell power, +1% crit chance, +1% hit chance",
				itemDescriptionRU: "+1 к броне, +20 к максимальному уровню здоровья, +20 к максимальному уровню маны, +3 к силе заклинаний, +1% к шансу критического эффекта, +1% к шансу попадения по противнику",
				defence: 1,
				healthBonus: 20,
				manaBonus: 20,
				energyBonus: 0,
				spellPowerBonus: 3,
				critChanceBonus: 1,
				hitChanceBonus: 1,
				rarity: .epic,
				price: 250
			),
			
			Armor(
				labelEN: "Corrupted Owl Mantle",
				labelRU: "Проклятая мантия совы",
				itemLevel: 3,
				itemType: .armor,
				itemDescriptionEN: "-2 defence, -10 health, -10 mana, +10 spell power, +2% crit chance, +2% hit chance",
				itemDescriptionRU: "-2 к броне, -10 к максимальному уровню здоровья, -10 к максимальному уровню маны, +10 к силе заклинаний, +2% к шансу критического эффекта, +2% к шансу попасть по противнику",
				defence: -2,
				healthBonus: -10,
				manaBonus: -10,
				energyBonus: 0,
				spellPowerBonus: 10,
				critChanceBonus: 2,
				hitChanceBonus: 2,
				rarity: .epic,
				price: 250
			),
			
			Armor(
				labelEN: "Corrupted Fox Suit",
				labelRU: "Проклятый костюм лисы",
				itemLevel: 3,
				itemType: .armor,
				itemDescriptionEN: "+1 defence, +10% crit chance, -20 health, -20 mana, -5 spell power, -5% hit chance",
				itemDescriptionRU: "+1 к броне, +10% к шансу критического эффекта, -20 к максимальному уровню здоровья, -20 к максимальному уровню маны, -5 к силе заклинаний, -5% к шансу попадения по противнику",
				defence: 1,
				healthBonus: -20,
				manaBonus: -20,
				energyBonus: 0,
				spellPowerBonus: -5,
				critChanceBonus: 10,
				hitChanceBonus: -5,
				rarity: .epic,
				price: 250
			)
			
		]
		
		// MARK: - Legendary Armors
		
		static let legendaryArmors: [Armor] = [
			
			Armor(
				labelEN: "Bone Armor",
				labelRU: "Костяной доспех",
				itemLevel: 4,
				itemType: .armor,
				itemDescriptionEN: "+5 Defence",
				itemDescriptionRU: "+5 к броне",
				defence: 5,
				healthBonus: 25,
				manaBonus: 25,
				energyBonus: 0,
				spellPowerBonus: 0,
				critChanceBonus: 0,
				hitChanceBonus: 0,
				rarity: .legendary,
				price: 500
			),
			
			Armor(
				labelEN: "Death Robe",
				labelRU: "Роба смертоностности",
				itemLevel: 4,
				itemType: .armor,
				itemDescriptionEN: "+2 defence, +50 mana, +5 spell power, +2% crit chance, +2% hit chance, -25 health",
				itemDescriptionRU: "+2 к броне, +50 к максимальному уровню маны, +5 к силе заклинаний, +2% к шансу критического эффекта, +2% к шансу попасть по противнику, -25 к максимальному уровню здоровья",
				defence: 2,
				healthBonus: -25,
				manaBonus: 50,
				energyBonus: 0,
				spellPowerBonus: 5,
				critChanceBonus: 2,
				hitChanceBonus: 2,
				rarity: .legendary,
				price: 500
			),
			
			Armor(
				labelEN: "Snake Armor",
				labelRU: "Броня змеи",
				itemLevel: 4,
				itemType: .armor,
				itemDescriptionEN: "+1 ENERGY, +5 spell power, +5% crit chance, +5% hit chance, -5 DEFENCE, -25 health, -25 mana",
				itemDescriptionRU: "+1 к ОЧКАМ ДЕЙСТВИЯ, +5 к силе заклинаний, +5 к шансу попадения по противнику, -5 к БРОНЕ, -25 к максимальному запасу здоровья, -25 к максимальному запасу маны",
				defence: -5,
				healthBonus: -25,
				manaBonus: -25,
				energyBonus: 1,
				spellPowerBonus: 5,
				critChanceBonus: 5,
				hitChanceBonus: 5,
				rarity: .epic,
				price: 500
			),
			
			Armor(
				labelEN: "Golden Armor",
				labelRU: "Золотой доспех",
				itemLevel: 4,
				itemType: .armor,
				itemDescriptionEN: "+2 defence, +100 health, +2% hit chance",
				itemDescriptionRU: "+2 к броне, +100 к здоровью, +2% к шансу попасть по противнику",
				defence: 2,
				healthBonus: 100,
				manaBonus: 0,
				energyBonus: 0,
				spellPowerBonus: 0,
				critChanceBonus: 0,
				hitChanceBonus: 2,
				rarity: .legendary,
				price: 500
			),
			
			Armor(
				labelEN: "Faraam Great Armor",
				labelRU: "Великий доспех Фараама",
				itemLevel: 4,
				itemType: .armor,
				itemDescriptionEN: "+10 DEFENCE, +50 health, -50 mana, -1 ENERGY, -5 spell power, -5% crit chance, -5% hit chance",
				itemDescriptionRU: "+10 к БРОНЕ, +50 к максимальному уровню здоровья, -50 к максимальному уровню маны, -1 к ОЧКАМ ДЕЙСТВИЯ, -5 к силе заклинаний, -5% к шансу критического эффекта, -5% к шансу попадения по противнику",
				defence: 10,
				healthBonus: +50,
				manaBonus: -50,
				energyBonus: -1,
				spellPowerBonus: -5,
				critChanceBonus: -5,
				hitChanceBonus: -5,
				rarity: .legendary,
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
