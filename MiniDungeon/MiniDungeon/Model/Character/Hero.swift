import Foundation

struct Hero {
	
	var heroLevel = 1
	
	var heroCurrentHP = 100
	var heroMaxHP = 100
	
	var currentMana = 100
	var maxMana = 100
	
	var currentEnergy = 5
	var maxEnergy = 5
	
	var heroDamage = 10
	
	/// Defence seems too powerful if you add one point each level
	var defence = 1
	var spellPower = 10
	
	var skillPoints = 1
	
	mutating func levelUP() {
		
		self.heroMaxHP += 20
		self.heroCurrentHP = self.heroMaxHP
		self.maxMana += 10
		self.currentMana = self.maxMana
		self.heroDamage += 2
		self.spellPower += 1
		self.skillPoints += 2
		self.heroLevel += 1
	}
	
	mutating func upgradeDamage() {
		
//		self.skillPoints -= 1
		self.heroDamage += 1
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
