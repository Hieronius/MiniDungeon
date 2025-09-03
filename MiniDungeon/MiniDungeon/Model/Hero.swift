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
	var defence = 1
	var spellPower = 10
	
	var skillPoints = 1
	
	mutating func levelUP() {
		
		self.heroMaxHP += 20
		self.heroCurrentHP = self.heroMaxHP
		self.heroDamage += 2
		self.skillPoints += 2
		self.heroLevel += 1
		self.defence += 1
	}
	
	mutating func upgradeDamage() {
		
		self.skillPoints -= 1
		self.heroDamage += 5
	}
	
	mutating func upgradeHP() {
		
		self.skillPoints -= 1
		self.heroMaxHP += 5
		self.heroCurrentHP = self.heroMaxHP
	}
	
	mutating func upgradeDefence() {
		
		self.skillPoints -= 1
		self.defence += 2
	}
	
	mutating func upgradeSpellPower() {
		
		self.skillPoints -= 1
		self.spellPower += 2
	}
}
