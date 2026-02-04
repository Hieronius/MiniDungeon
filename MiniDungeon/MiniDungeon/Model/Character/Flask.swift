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
	case readyForLevelUP = "Level UP!"
	case didGetLevelUP = "I'm stronger now!"
	case offensiveMode = "Offensive Mode On"
	case defensiveMode = "Defensive Mode On"
	case none = "                         "
}

/// Use this enum to determine what talant of Soul Collection user has under his belt so flask can collect more souls and unleash a bigger effect
enum FlaskSoulCollectionStatus: String, Codable {
	
	case soulCollector = "Soul Collector"
	case soulExtractor = "Soul Extractor"
	case soulEater = "Soul Eater"
}

// TODO: Uncomment when you refactor
//enum FlaskLevelBonus: Codable {
//	
//	case enhansedHealing // +5% of healing value
//	case enhansedimprovedDamage // +5 of damage value
//	// and so on
//}

enum FlaskTalants: Codable {
	
	case addArmorAfterUse // +5 armor for turn to hero
	case addArmorReductionAfterUse // -5 armor for turn for the enemy
	// and so on
}

// MARK: - Flask

@Model
class Flask {
	
	var level = 1
	var currentXP = 0
	var expToLevelUP = 50
	
	/// By default we have Soul Collector Talant to get combat impact up to 50
	var currentSoulCollectionStatus: FlaskSoulCollectionStatus = FlaskSoulCollectionStatus.soulCollector
	
	/// Property to describe how much impact points from healing, damage done, blocking flask can suck in
	var baseCombatImpactCapacity = 50
	
	/// Property to collect talants, items and other effects which might increase baseCombatImpactCapacity
	var currentCombatImpactCapacity: Int {
		baseCombatImpactCapacity
	}
	
	/// We start from 0 when a new battle begins or a new game starts
	var currentCombatImpactValue: Int = 0
	
	/// Property to determine current flask progress bar animation
	/// if isCollecting = true { make it white } otherwise { make it blue }
	var flaskIsCollectingCombatImpact = false
	
	/// Property to determine is flask full of combat impact so you can unleash it's effect
	var flaskIsReadyToUnleashImpact = false
	
	/// Use this property to define is there a level up of the flask so you can tap it and move to LevelBonus screen
	var readyForLevelUP = false
	
	var battleMode: FlaskBattleMode = FlaskBattleMode.defensive
	var actions: FlaskActions = FlaskActions.heal // probably should be removed for time being
	var currentComment: FlaskComments = FlaskComments.none
	var levelBonuses: [FlaskLevelBonus] = []
	var talants: [FlaskTalants] = []
	
	/// Basic Modifier of hero hp to heal
	var baseHealingValue: Double = 0.25
	
	/// Modifier of hero hp to heal after all talants and bonuses
	var currentHealingValue: Double { baseHealingValue }
	
	/// Specific value to transform Double property of current healing value to digestable Int property to display in BattleView
	var currentHealingValueInPercent: Int {
		Int(currentHealingValue * 100)
	}
	
	/// Modifier of enemy hp to damage
	var baseDamageValue: Double = 0.15
	
	/// Modifier of enemy hp to damage after all talants and bonuses
	var currentDamageValue: Double { baseDamageValue }
	
	/// Specific property to transform Double property of current damage value to digestable Int property to display in BattleView
	var currentDamageValueInPercent: Int {
		Int(currentDamageValue * 100)
	}
	
	/// Base chance to get a CD reset after flask use
	var baseChanceToGetCDreset = 0
	
	/// Modified chance to get a CD reset after bonuses and talants calculation
	var currentChanceToGetCDreset: Int {
		baseChanceToGetCDreset
	}
	
	/// Property to define a basic chance to return charge after use
	var baseChanceToGetChargeAfterUse = 0
	
	/// Property to calculate current chance to return charge after adding up talants and level bonuses
	var currentChanceToGetChargeAfterUse: Int {
		baseChanceToGetChargeAfterUse
	}
	
	/// How many charges flask have right now
	var currentCharges = 3
	
	/// Basic amount of max charges you can store
	var baseMaxCharges = 3
	
	/// An emount of max charges after calculation of talants and talent bonuses
	var currentMaxCharges: Int { baseMaxCharges } // + talants + bonuses
	
	/// This property should define is Flask available right now
	/// When it's on CD you should get this property being equal to `cooldown`
	var actionsToResetCD = 0
	
	/// This value mean that if basicCooldown is 10, you need 10 turns after use the flask to get it active again
	var baseCooldown = 10
	
	/// This property should be defined as 10 or 20 initially
	/// so each special action like turn or move will decrease it by 1
	/// use should be able to use flask when cooldown is zero
	var currentCooldown: Int { baseCooldown } // + talants + bouses
	
	/// basic value of damage bonus
	var baseDamageBonusWhileFlaskOnCD = 0
	
	/// dynamic value of damage bonus if flask on CD
	var currentDamageBonus: Int {
		
		// You can put damage bonus while flask on cd and damage bonus after use for example right into this computed property
		// hero.currentDamage: Int { otherSources + currentDamageBonus }
		actionsToResetCD > 0 ? baseDamageBonusWhileFlaskOnCD : 0
	}
	
	/// basic value of defence bonus
	var baseDefenceBonusWhileFlaskOnCD = 0
	
	
	/// dynamic value of armor bonus if flask on CD
	var currentDefenceBonus: Int {
		actionsToResetCD > 0 ? baseDefenceBonusWhileFlaskOnCD : 0
	}
	
	/// basic value of damage reduction debuff for flask level bonus with the same name
	var baseDamageDebuffAfterUseOnTarget = 0
	
	/// basic value of defence reduction debuff for flask level bonus with the same name
	var baseDefenceDebuffAfterUseOnTarget = 0
	
	
	init() {
		
	}
	
	// MARK: - collectCombatImpactWithAnimation
	
	/// Method to collect damage/healing done/damage received/block value by the flask with animation of changing color of the progress bar for a moment
	/// TODO: Change the way you check basic current combatImpactValue.
	/// If it will change to 100 or 75 as a basic the whole system will be ruined
	func collectCombatImpactWithAnimation(impact: Int) {
		
		if currentCombatImpactValue + impact >= 50 {
			
			currentCombatImpactValue += impact
			
			if (currentCombatImpactValue + impact) >= currentCombatImpactCapacity {
				currentCombatImpactValue = currentCombatImpactCapacity
			}
			flaskIsReadyToUnleashImpact = true
			
		} else {
			
			currentCombatImpactValue += impact
		}
		
		flaskIsCollectingCombatImpact = true
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			self.flaskIsCollectingCombatImpact = false
		}
	}
	
	// MARK: - setFlaskStatsToDefault
	
	func setFlaskStatsToDefault() {
		
		// basic stats
		level = 1
		currentXP = 0
		expToLevelUP = 50
		baseCombatImpactCapacity = 50
		readyForLevelUP = false
		levelBonuses = []
		talants = []
		baseHealingValue = 0.25
		baseDamageValue = 0.25
		actionsToResetCD = 0
		baseCooldown = 10
		
		// effects
		
		baseChanceToGetCDreset = 0
		baseChanceToGetChargeAfterUse = 0
		baseDefenceBonusWhileFlaskOnCD = 0
		baseDamageBonusWhileFlaskOnCD = 0
		baseDefenceDebuffAfterUseOnTarget = 0
		baseDamageDebuffAfterUseOnTarget = 0
	}
	
	// MARK: - levelUP
	
	func levelUP() {
		level += 1
		currentXP = 0
		expToLevelUP += 25
		currentComment = .didGetLevelUP
		cleanFlaskComment()
	}
	
	// MARK: - setStatsToDefault
	
	func setStatsToDefault() {
		// use the same logic as you did in hero.setStatsToDefault
		// Write in down before implementation
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
	
	/// Offensive - Defensive mode switcher
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
	
	/// Method to clean log console messages from visual clutter
	func cleanFlaskComment() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			self.currentComment = .none
			print("Did clean flask comment after a second")
		}
	}

}
