import Foundation

struct Hero {
	
	// Stats
	
	var heroLevel = 1
	
	var heroCurrentHP = 100
	var heroMaxHP = 100
	
	var currentMana = 100
	var maxMana = 100
	
	var currentEnergy = 5
	var maxEnergy = 5
	
//	var heroDamage = 10
	var minDamage = 5
	var maxDamage = 10
	
	var weaponSlot: Weapon
	var armorSlot: Armor
	
	var defence = 1
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
		self.minDamage += 1
		self.maxDamage += 1
		self.spellPower += 1
		self.skillPoints += 2
		self.heroLevel += 1
	}
	
	mutating func upgradeDamage() {
		
//		self.skillPoints -= 1
//		self.heroDamage += 1
	}
	
	mutating func upgradeHP() {
		
//		self.skillPoints -= 1
		self.heroMaxHP += 1
		self.heroCurrentHP = self.heroMaxHP
	}
	
	mutating func upgradeDefence() {
		
//		self.skillPoints -= 1
		self.defence += 1
	}
	
	mutating func upgradeSpellPower() {
		
//		self.skillPoints -= 1
		self.spellPower += 1
	}
}
