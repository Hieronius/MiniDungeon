import Foundation

extension MainViewModel {
	
	// MARK: applySpecialisation
	
	func applySpecialisation(_ spec: Specialisation?) {
		
		guard let spec = spec else { return }
		/*
		 Current ones:
		 
		 Specialisation(name: "Warrior"),
		 Specialisation(name: "Knight"),
		 Specialisation(name: "Assasin"),
		 Specialisation(name: "Priest"),
		 Specialisation(name: "Mage")
		 */
		
		switch spec.name {
			
		case "Warrior":
			gameState.hero.baseMaxHP += 5
			gameState.hero.currentHP = gameState.hero.maxHP
			gameState.hero.baseMaxDamage += 1
			
		case "Knight":
			gameState.hero.baseMaxHP += 5
			gameState.hero.currentHP = gameState.hero.maxHP
			gameState.hero.baseDefence += 1
			
		case "Assasin":
			gameState.hero.baseMaxDamage += 3
			
		case "Priest":
			gameState.hero.baseMaxMP += 5
			gameState.hero.currentMana = gameState.hero.maxMana
			gameState.hero.baseSpellPower += 1
			
		case "Mage":
			gameState.hero.baseMaxMP += 10
			gameState.hero.currentMana = gameState.hero.maxMana
			
		default: return
			
		}
		gameState.didApplySpec = true
		gameState.hero.specialisation = spec
	}
}
