import SwiftData

/// Entity to store stats and inventory of the hero in the game
@Model
class Hero {
	
	// MARK: Base Stats
	
	var heroLevel = 1
	var specialisation: Specialisation?
	
	// test property
	var flask: Flask
	var currentXP = 0
	var maxXP = 150
	
	var baseMaxHP = 75
	var baseMaxMP = 50
	var baseMaxEP = 3
	
	var baseMinDamage = 5
	var baseMaxDamage = 10
	
	var baseDefence = 0
	
	// In %
	var baseHitChance = 85
	
	// In %
	var baseCritChance = 5
	
	var baseSpellPower = 5
	
	// MARK: Current Stats
	
	var currentHP = 75
	var maxHP: Int { baseMaxHP + (armorSlot?.healthBonus ?? 0) }
	
	var currentMana = 50
	var maxMana: Int { baseMaxMP + (armorSlot?.manaBonus ?? 0) }
	
	var currentEnergy = 3
	var maxEnergy: Int { baseMaxEP + (armorSlot?.energyBonus ?? 0) }
	
	/// Adds weapon MinDamage to hero baseMinDamage
	var minDamage: Int {
		baseMinDamage + (weaponSlot?.minDamageBonus ?? 0) + flask.currentDamageBonus
	}
	
	/// Adds weapon MaxDamage to hero baseMaxDamage
	var maxDamage: Int {
		baseMaxDamage + (weaponSlot?.maxDamage ?? 0) + flask.currentDamageBonus
	}
	var hitChance: Int { baseHitChance + (weaponSlot?.hitChance ?? 0) + (armorSlot?.hitChanceBonus ?? 0) }
	var critChance: Int { baseCritChance + (weaponSlot?.critChance ?? 0) + (armorSlot?.critChanceBonus ?? 0) }
	
	var defence: Int {
		baseDefence + (armorSlot?.defence ?? 0) + flask.currentDefenceBonus
	}
	
	var spellPower: Int { baseSpellPower + (armorSlot?.spellPowerBonus ?? 0) }
	
	var skillPoints = 1
	
	// MARK: Armor + Weapon Slots
	
	var weaponSlot: Weapon? = nil
	var armorSlot: Armor? = nil
	
	// MARK: Inventory
	
	var weapons: [Weapon: Int] = [:]
	
//	var weapons = [WeaponManager.commonWeapons[0]: 1,
//				   WeaponManager.commonWeapons[1]: 1,
//				   WeaponManager.commonWeapons[2]: 1,
//				   WeaponManager.commonWeapons[3]: 1,
//				   WeaponManager.commonWeapons[4]: 1,
//				   
//				   WeaponManager.rareWeapons[1]: 1,
//				   WeaponManager.rareWeapons[2]: 1,
//				   WeaponManager.rareWeapons[3]: 1,
//				   WeaponManager.rareWeapons[4]: 1,
//				   WeaponManager.rareWeapons[0]: 1,
//				   
//				   
//				   WeaponManager.epicWeapons[1]: 1,
//				   WeaponManager.epicWeapons[2]: 1,
//				   WeaponManager.epicWeapons[3]: 1,
//				   WeaponManager.epicWeapons[4]: 1,
//				   WeaponManager.epicWeapons[0]: 1,
//				   
//				   WeaponManager.legendaryWeapons[1]: 1,
//				   WeaponManager.legendaryWeapons[2]: 1,
//				   WeaponManager.legendaryWeapons[3]: 1,
//				   WeaponManager.legendaryWeapons[0]: 1]

	var armors: [Armor: Int] = [:]
	
//	var armors = [ArmorManager.commonArmors[0]: 1,
//				  ArmorManager.commonArmors[1]: 1,
//				  ArmorManager.commonArmors[2]: 1,
//				  ArmorManager.commonArmors[3]: 1,
//				  
//				  
//				  ArmorManager.rareArmors[0]: 1,
//				  ArmorManager.rareArmors[1]: 1,
//				  ArmorManager.rareArmors[2]: 1,
//				  ArmorManager.rareArmors[3]: 1,
//				  
//				  ArmorManager.epicArmors[0]: 1,
//				  ArmorManager.epicArmors[1]: 1,
//				  ArmorManager.epicArmors[2]: 1,
//				  ArmorManager.epicArmors[3]: 1,
//				  
//				  ArmorManager.legendaryArmors[0]: 1,
//				  ArmorManager.legendaryArmors[1]: 1,
//				  ArmorManager.legendaryArmors[2]: 1,
//				  ArmorManager.legendaryArmors[3]: 1]
	
	var inventory: [Item: Int] = [:]
//	var inventory = [ItemManager.commonPotions[0]: 5,
//					 ItemManager.commonPotions[1]: 5,
////					 ItemManager.commonPotions[2]: 5,
//					 
//					 ItemManager.rarePotions[0]: 5,
//					 ItemManager.rarePotions[1]: 5,
//					 ItemManager.rarePotions[2]: 5,
//					 ItemManager.rarePotions[3]: 5,
//					 ItemManager.rarePotions[4]: 5,
//					 
//					 ItemManager.epicPotions[0]: 5,
//					 ItemManager.epicPotions[1]: 5,
//					 ItemManager.epicPotions[2]: 5,
//					 ItemManager.epicPotions[3]: 5,
//					 ItemManager.epicPotions[4]: 5,
//					 
//					 ItemManager.legendaryPotions[0]: 5,
//					 ItemManager.legendaryPotions[1]: 5,
//					 ItemManager.legendaryPotions[2]: 5,
//					 ItemManager.legendaryPotions[3]: 5,
//					 ItemManager.legendaryPotions[4]: 5]
	
//  test keys
//	var inventory: [Item: Int] = [ItemManager.returnKeyItem(): 1]
	
	// MARK: - Init
	
	init(flask: Flask) {
		self.flask = flask
	}
	
	// MARK: Increase/Decrease Stats
	
	func levelUP() {
		
		self.currentHP = self.maxHP
		self.currentMana = self.maxMana
		self.skillPoints += 2
		self.heroLevel += 1
	}
	
	func upgradeDamage() {
		
		self.baseMinDamage += 1
		self.baseMaxDamage += 1
	}
	
	func upgradeHP() {
		self.baseMaxHP += 1
		self.currentHP = self.maxHP
	}
	
	func upgradeDefence() {
		self.baseDefence += 1
	}
	
	func upgradeSpellPower() {
		self.baseSpellPower += 1
	}
	
	func equipArmor(_ armor: Armor?) {
		
		self.armorSlot = armor
		
		// Manual "didSet" logic
		if self.currentHP > self.maxHP {
			self.currentHP = self.maxHP
		}
		
		if self.currentMana > self.maxMana {
			self.currentMana = self.maxMana
		}
		
		print("Equipped \(armor?.label ?? "None"). HP is now \(currentHP)/\(maxHP)")
	}
	
	func equipWeapon(_ weapon: Weapon?) {
		
		self.weaponSlot = weapon
		
		// Manual "didSet" logic
		if self.currentHP > self.maxHP {
			self.currentHP = self.maxHP
		}
		
		if self.currentMana > self.maxMana {
			self.currentMana = self.maxMana
		}
		
		print("Equipped \(weapon?.label ?? "None"). HP is now \(currentHP)/\(maxHP)")
	}
	
	/// Method to use each time when player dies to avoid getting stats bonuses from previous run
	func restoreStatsToDefault() {
		
		self.baseMaxHP = 75
		self.baseMaxMP = 50
		self.baseMaxEP = 3
		self.baseMinDamage = 5
		self.baseMaxDamage = 10
		self.baseDefence = 0
		self.baseSpellPower = 5
		self.baseCritChance = 5
		self.baseHitChance = 85
	}
}
