/*
 Implement the same methods you did in ActivateShrines
 */

import Foundation

extension MainViewModel {
	
	// MARK: - activateFlaskTalant
	
	/// Method to activate shrine by adding a selected one
	func activateFlaskTalant(_ talant: FlaskTalant?) {
		
		guard let talant else { return }
		
		guard gameState.heroMaxDarkEnergyOverall >= talant.darkEnergyLevelToUpgrade && !gameState.upgradedFlaskTalants.contains(talant)
		else { return }
		
		gameState.upgradedFlaskTalants.append(talant)
		gameState.flaskTalantToDisplay = nil
		print("new talant has been activated")
	}
	
	// MARK: - checkIsThereFlaskTalantsToUpgrade
	
	func checkIsThereFlaskTalantsToUpgrade(_ talants: [FlaskTalant]) -> Bool {
		
		for talant in talants {
			if !gameState.upgradedFlaskTalants.contains(talant) {
				return false
			}
		}
		return true
	}
	
	// MARK: - applyActiveFlaskTalantsEffects()
	
	/// Check all upgraded flask talants and apply it's effect on new run
	func applyActiveFlaskTalantEffects() {
		gameState.upgradedFlaskTalants.forEach {
			applyFlaskTalantEffect($0)
			print("applied \($0.name) flask talant effect for a new run")
		}
	}
	
	// MARK: - applyFlaskTalantEffect
	
	/// Use this method on the array of shrines to activate at the start of new run
	func applyFlaskTalantEffect(_ talant: FlaskTalant) {
		
		// TODO: Should be refactored. relying on talant.name is not safe
		
		switch talant.name {
			
			// Minor talants
			
		case "Soul Collector":
			
			gameState.hero.flask.baseCombatImpactCapacity = 50
			// gameState.hero.flask.soulCollector.activated = true
			// or gameState.soulCollector.activated = true
			/*
			 description: "Flask gains ability to collect damage done, damage received, healing done, block value after skill use. When it reach 100, gain some dark energy or 1 extra EP"
			 */
			
		case "Minor Talant of Recovery":
			gameState.hero.flask.baseHealingValue += 0.05
			print("should be 30 now")
			print(gameState.hero.flask.baseHealingValue)
			
			
		case "Minor Talant of Sharness":
			gameState.hero.flask.baseDamageValue += 0.05
			
			
		case "Minor Talant of Swiftness":
			gameState.hero.flask.baseCooldown -= 1
			
			
		case "Minor Talant of Soul Collection":
			gameState.hero.flask.baseMaxCharges += 1
			gameState.hero.flask.currentCharges += 1
			

			// Medium Talants
			
		case "Soul Extractor":
			
			gameState.hero.flask.baseCombatImpactCapacity += 50
			/* other logic accordingly to talant description
			 
			 description: "Flask gains ability to collect damage done, damage received, healing done, block value after skill use. When it reach 100, gain some dark energy or 1 extra EP + 10% healing of max HP/10% damage of target max HP"
			 */
		case "Medium Talant of Recovery":
			gameState.hero.flask.baseHealingValue += 0.05
			
		case "Medium Talant of Sharness":
			gameState.hero.flask.baseDamageValue += 0.05
			
		case "Medium Talant of Swiftness":
			gameState.hero.flask.baseCooldown -= 1
			
		case "Medium Talant of Soul Extraction":
			gameState.hero.flask.baseMaxCharges += 1
			gameState.hero.flask.currentCharges += 1
			
			// Huge Talants
			
		case "Soul Eater":
			
			gameState.hero.flask.baseCombatImpactCapacity += 50
			
			/*
			 description: "Flask gains ability to collect damage done, damage received, healing done, block value after skill use. When it reach 100, gain some dark energy or 1 extra EP + 10% healing of max HP/10% damage of target max HP + to empower next ability",
			 */
			
		case "Huge Talant of Recovery":
			gameState.hero.flask.baseHealingValue += 0.05
			
		case "Huge Talant of Sharness":
			gameState.hero.flask.baseDamageValue += 0.05
			
		case "Huge Talant of Swiftness":
			gameState.hero.flask.baseCooldown -= 1
			
		case "Huge Talant of Souls Devouring":
			gameState.hero.flask.baseMaxCharges += 1
			gameState.hero.flask.currentCharges += 1
			
			// Great Talants
			
		case "Great Talant of Empowering":
			print("Add special effects there")
			/*
			 description: "Flask gains ability to use some of existing shadow energy to empower one of hero abilities"
			 */
			
		default: print("it's a default case from FlaskTalantsView")
		}
		// clean view with talant info if activated
		gameState.flaskTalantToDisplay = nil
	}
	
}
