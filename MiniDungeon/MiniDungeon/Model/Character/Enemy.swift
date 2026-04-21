import Foundation

/// Entity to store Enemy information and it's stats
struct Enemy: Codable {
	
	var name = "Enemy"
	var isBoss = false
	
	// State Flags
	
	var currentHP = 100
	var maxHP = 100
	
	var currentMP = 100
	var maxMana = 100
	
	var currentEnergy = 3
	var maxEnergy = 3
	
	var minDamage = 3
	var maxDamage = 6
	var hitChance = 85
	var critChance = 5
	
	var defence = 0
	var spellPower = 5
}
