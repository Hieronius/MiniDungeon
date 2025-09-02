import Foundation

struct Hero {
	
	var heroLevel = 1
	var heroCurrentHP = 100
	var heroMaxHP = 100
	var heroDamage = 10
	var skillPoints = 1
	
	mutating func levelUP() {
		self.heroMaxHP += 20
		self.heroCurrentHP = self.heroMaxHP
		self.heroDamage += 2
		self.skillPoints += 2
		self.heroLevel += 1
	}
}
