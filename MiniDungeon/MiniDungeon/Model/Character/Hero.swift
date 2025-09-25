import Foundation

struct Hero {
	
	// MARK: Base Stats
	
	var heroLevel = 1
	
	var baseMinDamage = 5
	var baseMaxDamage = 10
	
	var baseDefence = 0
	
	// In %
	var baseHitChance = 85
	
	// In %
	var baseCritChance = 5
	
	// MARK: Current Stats
	
	var currentHP = 75
	var maxHP = 75
	
	var currentMana = 50
	var maxMana = 50
	
	var currentEnergy = 5
	var maxEnergy = 5
	
	var weaponSlot: Weapon? = nil
	var armorSlot: Armor? = nil
	
	var minDamage: Int { baseMinDamage + (weaponSlot?.minDamage ?? 0) }
	var maxDamage: Int { baseMaxDamage + (weaponSlot?.maxDamage ?? 0) }
	var hitChance: Int { baseHitChance + (weaponSlot?.hitChance ?? 0) }
	var critChance: Int { baseCritChance + (weaponSlot?.critChance ?? 0) }
	
	var defence: Int { baseDefence + (armorSlot?.defence ?? 0) }
	
	var spellPower = 10
	
	var skillPoints = 1
	
	// MARK: Inventory
	
	var weapons: [Weapon: Int] = [:]

	var armors: [Armor: Int] = [:]
	
	var inventory: [Item: Int] = [:]
	
	// MARK: Increase/Decrease Stats
	
	mutating func levelUP() {
		
		self.maxHP += 10
		self.currentHP = self.maxHP
		self.maxMana += 5
		self.currentMana = self.maxMana
		self.baseMinDamage += 1
		self.baseMaxDamage += 1
		self.spellPower += 1
		self.skillPoints += 2
		self.heroLevel += 1
	}
	
	mutating func upgradeDamage() {
		
		self.baseMinDamage += 1
		self.baseMaxDamage += 1
	}
	
	mutating func upgradeHP() {
		self.maxHP += 1
		self.currentHP = self.maxHP
	}
	
	mutating func upgradeDefence() {
		self.baseDefence += 1
	}
	
	mutating func upgradeSpellPower() {
		self.spellPower += 1
	}
}
