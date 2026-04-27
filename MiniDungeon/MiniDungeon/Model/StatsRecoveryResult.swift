import Foundation

/// We use this entity to restore hp and mana after each dungeon level for money. Take this model before and apply to hero stats after an interaction
struct StatsRecoveryResult {
	
	var newCurrentHPValue: Int
	var newCurrentMPValue: Int
	var newCurrentGoldValue: Int
}
