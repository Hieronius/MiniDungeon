import Foundation

struct Hero {
	
	// MARK: Base Stats
	
	var heroLevel = 1
	var specialisation: Specialisation?
	var currentXP = 0
	var maxXP = 150
	
	var baseMaxHP = 75
	var baseMaxMP = 50
	var baseMaxEP = 4
	
	var baseMinDamage = 5
	var baseMaxDamage = 10
	
	var baseDefence = 0
	
	// In %
	var baseHitChance = 85
	
	// In %
	var baseCritChance = 5
	
	var baseSpellPower = 10
	
	// MARK: Current Stats
	
	var currentHP = 75
	var maxHP: Int { baseMaxHP + (armorSlot?.healthBonus ?? 0) }
	
	var currentMana = 50
	var maxMana: Int { baseMaxMP + (armorSlot?.manaBonus ?? 0) }
	
	var currentEnergy = 4
	var maxEnergy: Int { baseMaxEP + (armorSlot?.energyBonus ?? 0) }
	
	/// Adds weapon MinDamage to hero baseMinDamage
	var minDamage: Int { baseMinDamage + (weaponSlot?.minDamageBonus ?? 0) }
	
	/// Adds weapon MaxDamage to hero baseMaxDamage
	var maxDamage: Int { baseMaxDamage + (weaponSlot?.maxDamage ?? 0) }
	var hitChance: Int { baseHitChance + (weaponSlot?.hitChance ?? 0) + (armorSlot?.hitChanceBonus ?? 0) }
	var critChance: Int { baseCritChance + (weaponSlot?.critChance ?? 0) + (armorSlot?.critChanceBonus ?? 0) }
	
	var defence: Int { baseDefence + (armorSlot?.defence ?? 0) }
	
	var spellPower: Int { baseSpellPower + (armorSlot?.spellPowerBonus ?? 0) }
	
	var skillPoints = 1
	
	// MARK: Armor + Weapon Slots
	
	var weaponSlot: Weapon? = nil
	var armorSlot: Armor? = nil
	
	// MARK: Inventory
	
	var weapons: [Weapon: Int] = [:]

	var armors: [Armor: Int] = [:]
	
	var inventory: [Item: Int] = [:]
	
	// MARK: Increase/Decrease Stats
	
	mutating func levelUP() {
		
		self.currentHP = self.maxHP
		self.currentMana = self.maxMana
		self.skillPoints += 2
		self.heroLevel += 1
	}
	
	mutating func upgradeDamage() {
		
		self.baseMinDamage += 1
		self.baseMaxDamage += 1
	}
	
	mutating func upgradeHP() {
		self.baseMaxHP += 1
		self.currentHP = self.maxHP
	}
	
	mutating func upgradeDefence() {
		self.baseDefence += 1
	}
	
	mutating func upgradeSpellPower() {
		self.baseSpellPower += 1
	}
}
