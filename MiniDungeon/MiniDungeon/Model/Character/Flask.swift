import SwiftData
import Foundation

/*
 1. Create a new class ShadowFlask so i can share it's state alongside with Hero.
 - If it's a new session -> create new Flask, otherwise load an old one
 - Create a Enum of flask abilities, flask words, actions to be expandable
 - Add To Flask current mode like Defensive/Offensive
 - Add level and XP progression to flask
 */

enum FlaskBattleMode: Codable {
	
	case offensive
	case defensive
}

enum FlaskActions: Codable {
	
	case heal
	case damage
}

enum FlaskComments: String, Codable {
	
	case battleModeChange = "Battle Mode has been changed"
	case levelUP = "I'm stronger now!"
	case offensiveMode = "Offensive Mode On"
	case defensiveMode = "Defensive Mode On"
	case none = "                         "
}

enum FlaskLevelBonus: Codable {
	
	case enhansedHealing // +5% of healing value
	case enhansedimprovedDamage // +5 of damage value
	// and so on
}

enum FlaskTalants: Codable {
	
	case addArmorAfterUse // +5 armor for turn to hero
	case addArmorReductionAfterUse // -5 armor for turn for the enemy
	// and so on
}

@Model
class Flask {
	
	var level = 1
	var currentXP = 0
	var expToLevelUP = 100
	var charges = 3
	
	/// This property should be defined as 10 or 20 initially
	/// so each special action like turn or move will decrease it by 1
	/// use should be able to use flask when cooldown is zero
	var cooldown = 0
	var battleMode: FlaskBattleMode = FlaskBattleMode.defensive
	var actions: FlaskActions = FlaskActions.heal
	var currentComment: FlaskComments = FlaskComments.battleModeChange
	var levelBonuses: [FlaskLevelBonus] = []
	var talants: [FlaskTalants] = []
	
	init() {
		
	}
	
	func levelUP() {
		level += 1
		currentXP = 0
		expToLevelUP += 25
		currentComment = .levelUP
	}
	
	func generateLevelBonus() -> [FlaskLevelBonus] {
		
		// Use random generator to choose 3 different one to choose
		// Use Set to make them unique
		
		return []
	}
	
	func applyLevelBonus(_ bonus: FlaskLevelBonus) {
		
		// When user press bonus button to choose, add this bonus to level bonuses and apply them 
		
		levelBonuses.append(bonus)
	}
	
	func toggleBattleMode() {
		
		if battleMode == .offensive {
			battleMode = .defensive
			currentComment = .defensiveMode
		} else if battleMode == .defensive {
			battleMode = .offensive
			currentComment = .offensiveMode
		}
		cleanFlaskComment()
		
	}
	
	func cleanFlaskComment() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			self.currentComment = .none
		}
	}

}
