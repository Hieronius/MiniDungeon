import Foundation

struct Hero {
	
	// Base Stats
	
	var heroLevel = 1
	
	var baseMinDamage = 5
	var baseMaxDamage = 10
	
	var baseDefence = 0
	
	// In %
	var baseHitChance = 85
	
	// In %
	var baseCritChance = 5
	
	// Current Stats
	
	var heroCurrentHP = 100
	var heroMaxHP = 100
	
	var currentMana = 100
	var maxMana = 100
	
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
	
	// MARK: Equip/Unequip Items
	
	mutating func equipWeapon(_ item: Weapon) {
		
		// add min/max damage
	}
	
	mutating func unequipWeapon(_ item: Weapon) {
		
		// remove min/max damage
	}
	
	mutating func equipArmor(_ item: Armor) {
		
	}
	
	mutating func unequipArmor(_ item: Armor) {
		
		
	}
	
	// MARK: Increase/Decrease Stats
	
	mutating func levelUP() {
		
		self.heroMaxHP += 20
		self.heroCurrentHP = self.heroMaxHP
		self.maxMana += 10
		self.currentMana = self.maxMana
		self.baseMinDamage += 1
		self.baseMaxDamage += 1
		self.spellPower += 1
		self.skillPoints += 2
		self.heroLevel += 1
	}
	
	mutating func upgradeDamage() {
		
//		self.skillPoints -= 1
		self.baseMinDamage += 1
		self.baseMaxDamage += 1
	}
	
	mutating func upgradeHP() {
		
//		self.skillPoints -= 1
		self.heroMaxHP += 1
		self.heroCurrentHP = self.heroMaxHP
	}
	
	mutating func upgradeDefence() {
		
//		self.skillPoints -= 1
		self.baseDefence += 1
	}
	
	mutating func upgradeSpellPower() {
		
//		self.skillPoints -= 1
		self.spellPower += 1
	}
}
