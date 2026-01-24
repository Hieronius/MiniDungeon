/*
 Create a method like "applyFlaskLevelBonus" with different effects you get each time flask get level up
 For info look at HeroLevelBonus file from ViewModel
 */

import Foundation

extension MainViewModel {
	
	// MARK: - applyFlaskLevelBonus
	
	/// Method to apply bonus of choice when hero get a new level
	func applyFlaskLevelBonus(_ bonus: FlaskLevelBonus?) {
		
		guard let bonus = bonus else { return }
		
		switch bonus.name {
			
		// Common
			
		case "Common Healing Bonus":
			gameState.hero.flask.baseHealingValue += 0.05
			
		case "Common Damage Bonus":
			gameState.hero.flask.baseDamageValue += 0.05
			
		case "Common CD Reduction Bonus":
			if gameState.hero.flask.baseCooldown > 1 {
				gameState.hero.flask.baseCooldown -= 1
			}
			
		case "Common Charge Back Bonus":
			gameState.hero.flask.baseChanceToGetChargeAfterUse += 5
			
		case "Common CD Reset Bonus":
			gameState.hero.flask.baseChanceToGetCDreset += 5
			
		// Rare
			
		case "Rare Healing Bonus":
			gameState.hero.flask.baseHealingValue += 0.10
			
		case "Rare Damage Bonus":
			gameState.hero.flask.baseDamageValue += 0.10
			
		case "Rare CD Reduction Bonus":
			if gameState.hero.flask.baseCooldown > 1 {
				gameState.hero.flask.baseCooldown -= 2
				
				if gameState.hero.flask.baseCooldown < 1 {
					gameState.hero.flask.baseCooldown = 1
				}
			}
			
		case "Rare Charge Back Bonus":
			gameState.hero.flask.baseChanceToGetChargeAfterUse += 10
			
		case "Rare CD Reset Bonus":
			gameState.hero.flask.baseChanceToGetCDreset += 10
			
		case "Rare Damage Buff Bonus":
			gameState.hero.flask.baseDamageBonusWhileFlaskOnCD += 1
			
		case "Rare Armor Buff Bonus":
			gameState.hero.flask.baseDefenceBonusWhileFlaskOnCD += 1
			
		case "Rare Damage Debuff Bonus":
			gameState.hero.flask.baseDamageDebuffAfterUseOnTarget += 1
		
		case "Rare Armor Debuff Bonus":
			gameState.hero.flask.baseDefenceDebuffAfterUseOnTarget += 1
			
			
		// Epic
			
		case "Epic Healing Bonus":
			gameState.hero.flask.baseHealingValue += 0.15
			
		case "Epic Damage Bonus":
			gameState.hero.flask.baseDamageValue += 0.15
			
		case "Epic CD Reduction Bonus":
			if gameState.hero.flask.baseCooldown > 1 {
				gameState.hero.flask.baseCooldown -= 4
				
				if gameState.hero.flask.baseCooldown < 1 {
					gameState.hero.flask.baseCooldown = 1
				}
			}
			
		case "Epic Charge Back Bonus":
			gameState.hero.flask.baseChanceToGetChargeAfterUse += 15
			
		case "Epic CD Reset Bonus":
			gameState.hero.flask.baseChanceToGetCDreset += 15
			
		case "Epic Damage Buff Bonus":
			gameState.hero.flask.baseDamageBonusWhileFlaskOnCD += 2
			
		case "Epic Armor Buff Bonus":
			gameState.hero.flask.baseDefenceBonusWhileFlaskOnCD += 2
			
		case "Epic Damage Debuff Bonus":
			gameState.hero.flask.baseDamageDebuffAfterUseOnTarget += 2
			
		case "Epic Armor Debuff":
			gameState.hero.flask.baseDefenceDebuffAfterUseOnTarget += 2
			
		case "Epic Flask Charge Bonus":
			gameState.hero.flask.baseMaxCharges += 1
			gameState.hero.flask.currentCharges += 1
		
		// Legendary
			
		case "Legendary Healing Bonus":
			gameState.hero.flask.baseHealingValue += 0.20
			
		case "Legendary Damage Bonus":
			gameState.hero.flask.baseDamageValue += 0.20
			
		case "Legendary CD Reduction Bonus":
			
			if gameState.hero.flask.baseCooldown > 1 {
				gameState.hero.flask.baseCooldown -= 6
				
				if gameState.hero.flask.baseCooldown < 1 {
					gameState.hero.flask.baseCooldown = 1
				}
				
			}
			
		case "Legendary Charge Back Bonus":
			gameState.hero.flask.baseChanceToGetChargeAfterUse += 20
			
		case "Legendary CD Reset Bonus":
			gameState.hero.flask.baseChanceToGetCDreset += 20
			
		case "Legendary Damage Buff Bonus":
			gameState.hero.flask.baseDamageBonusWhileFlaskOnCD += 3
			
		case "Legendary Armor Buff Bonus":
			gameState.hero.flask.baseDefenceBonusWhileFlaskOnCD += 3
			
		case "Legendary Damage Debuff Bonus":
			gameState.hero.flask.baseDamageDebuffAfterUseOnTarget += 3
			
		case "Legendary Armor Debuff Bonus":
			gameState.hero.flask.baseDefenceDebuffAfterUseOnTarget += 3
			
		case "Legendary Flask Charge Bonus":
			gameState.hero.flask.baseMaxCharges += 2
			gameState.hero.flask.currentCharges += 2
			
		default: fatalError("Something went wrong with Flask Level Bonus")
			
		}
		
		// This block should be modified accordingly to Flask
		gameState.flaskLevelBonusToDisplay = nil
		gameState.flaskLevelBonusesToChoose = []
		gameState.hero.flask.levelUP()
		goToDungeon()
	}
	
	// MARK: - shouldGetChargeBack
	
	/// Method to calculate if hero should get Flask Charge after use or not
	func shouldGetChargeBack() -> Bool {
		
		let roll = Int.random(in: 1...100)
		let result = roll <= gameState.hero.flask.currentChanceToGetChargeAfterUse
		return result
	}
	
	// MARK: - shouldGetCDreset
	
	func shouldGetCDreset() -> Bool {
		
		let roll = Int.random(in: 1...100)
//		let result = roll < gameState.flask.currentChanceToGetCDreset
		let result = roll < gameState.hero.flask.currentChanceToGetCDreset
		return result
	}
}
