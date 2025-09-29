import Foundation

extension MainViewModel {
	
	func applySpecialisation(_ spec: Specialisation) {
		
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
			gameState.hero.maxHP += 5
			gameState.hero.currentHP = gameState.hero.maxHP
			gameState.hero.baseMaxDamage += 1
			
		case "Knight":
			gameState.hero.maxHP += 5
			gameState.hero.currentHP = gameState.hero.maxHP
			gameState.hero.baseDefence += 1
			
		case "Assasin":
			gameState.hero.baseMaxDamage += 3
			
		case "Priest":
			gameState.hero.maxMana += 5
			gameState.hero.currentMana = gameState.hero.maxMana
			gameState.hero.spellPower += 1
			
		case "Mage":
			gameState.hero.maxMana += 10
			gameState.hero.currentMana = gameState.hero.maxMana
			
		default: return
			
		}
		gameState.specToDisplay = spec
		gameState.didApplySpec = true
	}
}
