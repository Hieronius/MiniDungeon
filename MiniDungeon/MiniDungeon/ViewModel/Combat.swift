import Foundation
import SwiftUI

extension MainViewModel {
	
	// MARK: Start Mini Game
	
	/// Check energy for action and start a miniGame
	func startMiniGame() {
		
		if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost {
			gameState.isCombatMiniGameIsOn = true
		}
	}
	
	// MARK: startBattleWithRandomNonEliteEnemy
	
	/// Method to prepare game state and both sides for a battle
	func startBattleWithRandomNonEliteEnemy() {
		
		gameState.enemy = generateEnemy(didFinalBossSummoned: false)
		restoreAllEnergy()
		gameState.didHeroUseBlock = false
		gameState.didEnemyUseBlock = false
		goToBattle()
		gameState.logMessage = "Battle begin!"
	}
	
	// MARK: - Attack
	
	func continueAttackAfterMiniGame(success: Bool) {
		
		gameState.isCombatMiniGameIsOn = false
		gameState.isCombatMiniGameSuccessful = success
		
		if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			
			// hit chance
			
			let hitRoll = Int.random(in: 1...100)
			if hitRoll > gameState.hero.hitChance {
				gameState.logMessage = "Hero's Attack has been missed!"
				return
			}
			
			// damage - enemy defence
			
			var damage = Int.random(in: gameState.hero.minDamage...gameState.hero.maxDamage) - gameState.enemy.defence
			
			// EMPOWER FLAG ON (May be should be put to the different place due to huge Defence Ratio Influence. If there 5 enemy defence you can deal 0 damage with CRIT + EMPOWER + 5 EP COMBO which is not fun)
			
			if gameState.didUseFlaskEmpowerForOffensive {
				damage *= 2
			}
			
			// mini game success check
			
			if gameState.isCombatMiniGameSuccessful  {
				damage = Int(Double(damage) * 1.25)
				gameState.logMessage += "Nice Hit!"
			}
			
			// crit chance
			
			if damage > 0 {
				
				let critRoll = Int.random(in: 1...100)
				
				if critRoll <= gameState.hero.critChance {
					
					let criticalDamage = Int(Double(damage) * 1.5)
					
					// Collect Damage Done Impact
					
					gameState.hero.flask.collectCombatImpactWithAnimation(impact: criticalDamage)
					
					gameState.enemy.enemyCurrentHP -= criticalDamage
					gameState.logMessage = "Critical hit - \(criticalDamage) has been done!"
					
				} else {
					
					// Collect Damage Done Impact
					
					gameState.hero.flask.collectCombatImpactWithAnimation(impact: damage)
					
					gameState.enemy.enemyCurrentHP -= damage
					gameState.logMessage = "\(damage) damage has been done."
				}
				
				gameState.currentEnemyAnimation = .gotDamage
				
			}
			
			// If hero hit an enemy even with 0 damage -> add combo points
			if gameState.comboPoints < 5 {
				gameState.comboPoints += 1
			}
			
			
		} else if !gameState.isHeroTurn && gameState.enemy.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.enemy.currentEnergy -= gameState.skillEnergyCost
			
			let hitRoll = Int.random(in: 1...100)
			if hitRoll > gameState.enemy.hitChance {
				gameState.logMessage = "Enemy Attack has been missed"
				return
			}
			
			let damage = Int.random(in: gameState.enemy.minDamage...gameState.enemy.maxDamage) - gameState.hero.defence
			
			let critRoll = Int.random(in: 1...100)
			
			if damage > 0 {
				
				if critRoll <= gameState.enemy.critChance {
					
					let criticalDamage = Int(Double(damage) * 1.5)
					
					// Collect Critical Damage Received Impact
					
					gameState.hero.flask.collectCombatImpactWithAnimation(impact: criticalDamage)
					
					gameState.hero.currentHP -= criticalDamage
					gameState.logMessage = "Critical hit - \(criticalDamage) has been done!"
					
				} else {
					
					// Collect Damage Received Impact
					
					gameState.hero.flask.collectCombatImpactWithAnimation(impact: damage)
					
					gameState.hero.currentHP -= damage
					gameState.logMessage = "\(damage) damage has been done by enemy"
				}
				
				gameState.currentHeroAnimation = .gotDamage
				
			} else {
				gameState.logMessage = "0 damage has been made"
			}
		}
		// Reset Empower Flag after use
		gameState.didUseFlaskEmpowerForOffensive = false
		endHeroAndEnemyAnimation()
		
		winLoseCondition()
	}
	
	// MARK: ComboAttack
	
	/// You can use this attack when hero has 3 or more combo points
	/// Attack will always hit with special effects accordingly to how much combo points hero have
	/// 3 points -> +50% damage
	/// 4 points -> Ignore Armor
	/// 5 points -> 100% crit
	func comboAttack() {
		
		guard gameState.hero.currentEnergy >= 1 else { return }
		guard gameState.comboPoints >= 3 else { return }
		

		switch gameState.comboPoints {
			
		case 3:
			
			// With 3 combo points it will be an attack of 150% of damage
			
			let baseDamage = Int(Double(Int.random(in: gameState.hero.minDamage...gameState.hero.maxDamage) - gameState.enemy.defence) * 1.5)
			
			let critRoll = Int.random(in: 1...100)
			
			if critRoll <= gameState.hero.critChance {
				
				let criticalDamage = Int(Double(baseDamage) * 1.5)
				
				gameState.hero.flask.collectCombatImpactWithAnimation(impact: criticalDamage)
				
				gameState.enemy.enemyCurrentHP -= criticalDamage
				gameState.logMessage = "Critical Combo hit! - \(criticalDamage) has been done!"
				
			} else {
				
				gameState.hero.flask.collectCombatImpactWithAnimation(impact: baseDamage)
				
				gameState.enemy.enemyCurrentHP -= baseDamage
				gameState.logMessage = "\(baseDamage) Combo damage has been done!"
			}
			
		case 4:
			
			// With 4 Combo Points - 175% of damage + ignore target armor
			
			let baseDamage = Int(Double(Int.random(in: gameState.hero.minDamage...gameState.hero.maxDamage)) * 1.75)
			
			let critRoll = Int.random(in: 1...100)
			
			if critRoll <= gameState.hero.critChance {
				
				let criticalDamage = Int(Double(baseDamage) * 1.5)
				
				gameState.hero.flask.collectCombatImpactWithAnimation(impact: criticalDamage)
				
				gameState.enemy.enemyCurrentHP -= criticalDamage
				gameState.logMessage = "Critical Combo hit! - \(criticalDamage) has been done!"
				
			} else {
				
				gameState.hero.flask.collectCombatImpactWithAnimation(impact: baseDamage)
				
				gameState.enemy.enemyCurrentHP -= baseDamage
				gameState.logMessage = "\(baseDamage) Combo damage has been done!"
			}
			
		case 5:
			
			// With 5 Combo Points you deal 300% damage + ignore armor
			
			// This attack deduct base damage by enemy armor and only after apply it's modifiers. It's mean if base damage will be 1 it can inflict 0 damage if enemy armor is 1
			
			let baseDamage = Int.random(in: gameState.hero.minDamage...gameState.hero.maxDamage)
			let damage = Double(baseDamage) * 2.0
			
			let criticalDamage = Int(damage * 1.5)
			
			gameState.hero.flask.collectCombatImpactWithAnimation(impact: criticalDamage)
			
			gameState.enemy.enemyCurrentHP -= criticalDamage
			gameState.logMessage = "Critical Combo hit! - \(criticalDamage) has been done!"
			
			
		default: fatalError("Something went wrong with combo attack")
			
		}
		
		gameState.didEnemyReceivedComboAttack = true
		gameState.comboPoints = 0
		gameState.hero.currentEnergy -= 1
		gameState.currentEnemyAnimation = .gotDamage
		
		endHeroAndEnemyAnimation()
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			self.winLoseCondition()
			self.gameState.didEnemyReceivedComboAttack = false
		}
	}
	
	// MARK: TestEnemyExecute
	
	func testEnemyExecute() {
		
		guard gameState.isHeroTurn else { return }
		gameState.enemy.enemyCurrentHP -= 100
		winLoseCondition()
	}
	
	// MARK: TestEnergyRestoration
	
	func testComboPointsRestoration() {
		
		guard gameState.isHeroTurn else { return }
		gameState.comboPoints = 5
	}
	
	// MARK: TestFlaskCDreset
	
	func testFlaskCDreset() {
		
		guard gameState.isHeroTurn else { return }
		gameState.hero.flask.actionsToResetCD = 0
	}
	
	// MARK: - Block
	
	func block() {
		
		if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			
			// Collect Block Ability Impact
			
			var blockValue = (gameState.minBlockValue...gameState.maxBlockValue).randomElement() ?? 0
			var blockConsoleMessage = ""
			
			let critChance = Int.random(in: 1...100)
			
			if critChance <= gameState.hero.critChance {
				
				blockValue = Int(Double(blockValue) * 1.5)
				blockConsoleMessage = "Critical Block!"
			}
			
			if gameState.didUseFlaskEmpowerForDefensive {
				
				blockValue *= 2
			}
			
			gameState.hero.flask.collectCombatImpactWithAnimation(impact: blockValue)
			
			if gameState.didHeroUseBlock == false {
				
				gameState.hero.baseDefence += blockValue
				gameState.heroBlockValueBuffer = blockValue
				gameState.didHeroUseBlock = true
				gameState.logMessage = "\(blockConsoleMessage) \(blockValue) has been added to the Hero Defence!"
				
				gameState.currentHeroAnimation = .usedBlock
			}
			
		} else if !gameState.isHeroTurn &&
					gameState.enemy.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.enemy.currentEnergy -= gameState.skillEnergyCost
			
			var blockValue = (gameState.minBlockValue...gameState.maxBlockValue).randomElement() ?? 0
			var blockConsoleMessage = ""
			
			let critChance = Int.random(in: 1...100)
			
			if critChance <= gameState.enemy.critChance {
				
				blockValue = Int(Double(blockValue) * 1.5)
				blockConsoleMessage = "Critical Block!"
			}
			
			if gameState.didEnemyUseBlock == false {
				
				gameState.enemy.defence += blockValue
				gameState.enemyBlockValueBuffer = blockValue
				gameState.didEnemyUseBlock = true
			}
			gameState.logMessage = "\(blockConsoleMessage) \(blockValue)  has been added to Enemy Defence!"
		}
		
		// Reset Empower Flag after use
		gameState.didUseFlaskEmpowerForDefensive = false
		endHeroAndEnemyAnimation()
	}
	
	// MARK: - Heal
	
	func heal() {
		
		// Hero Turn
		
		if gameState.isHeroTurn &&
			gameState.hero.currentEnergy >= gameState.skillEnergyCost &&
			gameState.hero.currentMana >= gameState.spellManaCost {
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			gameState.hero.currentMana -= gameState.spellManaCost
			
			let minHealValue = gameState.healMinValue + gameState.hero.spellPower
			let maxHealValue = gameState.healMaxValue + gameState.hero.spellPower
			
			var healingValue = (minHealValue...maxHealValue).randomElement() ?? 0
			
			// apply crit here
			
			let critRoll = Int.random(in: 1...100)
			var critConsoleMessage = ""
			
			if critRoll <= gameState.hero.critChance {
				
				healingValue = Int(Double(healingValue) * 1.5)
				
				critConsoleMessage = "Critical Heal Effect!"
				
			}
			
			// if defensive flask empower flag toggles -> make it X2 of effect
			
			
			if gameState.didUseFlaskEmpowerForDefensive {
				
				healingValue *= 2
				gameState.hero.currentHP += healingValue
				
				// Collect Healing Ability Impact
				
				gameState.hero.flask.collectCombatImpactWithAnimation(
					impact: healingValue
				)
				
			} else {
				
				gameState.hero.currentHP += healingValue
				
				// Collect Healing Ability Impact
				
				gameState.hero.flask.collectCombatImpactWithAnimation(
					impact: healingValue
				)
			}
			
			if gameState.hero.currentHP >= gameState.hero.maxHP {
				gameState.hero.currentHP = gameState.hero.maxHP
			}
			
			gameState.currentHeroAnimation = .gotHealing
			
			gameState.logMessage = "\(critConsoleMessage) \(healingValue) amount of health has been recovered by hero"
			
		} else if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost &&
			gameState.hero.currentMana < gameState.spellManaCost {
			gameState.logMessage = "Not enough mana to cast"
			
			
			// Enemy Turn
			
		} else if !gameState.isHeroTurn &&
					gameState.enemy.currentEnergy >= gameState.skillEnergyCost &&
					gameState.enemy.currentMana >= gameState.spellManaCost {
			
			gameState.enemy.currentEnergy -= gameState.skillEnergyCost
			
			let minHealValue = gameState.healMinValue + gameState.enemy.spellPower
			let maxHealValue = gameState.healMaxValue + gameState.enemy.spellPower
			
			var healingValue = (minHealValue...maxHealValue).randomElement() ?? 0
			
			let critRoll = Int.random(in: 1...100)
			var critConsoleMessage = ""
			
			if critRoll <= gameState.enemy.critChance {
				
				healingValue = Int(Double(healingValue) * 1.5)
				
				critConsoleMessage = "Critical Heal Effect!"
				
			}
			
			gameState.enemy.enemyCurrentHP += healingValue
			gameState.logMessage = "\(critConsoleMessage) \(healingValue) amount of health has been recovered by enemy"
			
			if gameState.enemy.enemyCurrentHP >= gameState.enemy.enemyMaxHP {
				gameState.enemy.enemyCurrentHP = gameState.enemy.enemyMaxHP
			}
			
			gameState.currentEnemyAnimation = .gotHealing
			
		}
		// Reset Empower Flag after use
		gameState.didUseFlaskEmpowerForDefensive = false
		endHeroAndEnemyAnimation()
	}
	
	// MARK: - unleashFlaskImpactEffect
	
	/// Method to determine what effect flask should use when it collected enough impact and accordingly of it's SoulCollectionTalant status and Battle Mode
	func unleashFlaskImpactEffect() {
		
		guard gameState.enemy.enemyCurrentHP > 0 else { return }
		
		let currentFlaskTalant = gameState.hero.flask.currentSoulCollectionStatus
		let currentFlaskImpactValue = gameState.hero.flask.currentCombatImpactValue
		
		// Determine what BattleMode flask is on
		
		// 6 cases for each mode to handle all talants and impact value
		
		if gameState.hero.flask.battleMode == .offensive {
			
			// 1. Soul Collector - generates extra EP. If it's 3/3 -> 4/3
			// 2. Soul Extractor - dealt 10% extra damage to target
			// 3. Soul Eater - previous effects + Empower ability
			
			// In all three cases generates an extra EP point
			
			let energyPoint = 1
			
			gameState.hero.currentEnergy += energyPoint
			
			switch (currentFlaskTalant, currentFlaskImpactValue) {
				
			// Level 1 Talant + Max Capacity + Offensive Battle Mode -> Use Stage 1 Effect
				
			case (.soulCollector, 50):
				
				gameState.hero.flask.currentCombatImpactValue -= 50
				gameState.logMessage = "\(energyPoint) Energy Point been generated"
				
			// Level 2 Talant + not 100% capacity -> Use Stage 1 Effect
				
			case (.soulExtractor, 50..<100):
				
				gameState.hero.flask.currentCombatImpactValue -= 50
				gameState.logMessage = "\(energyPoint) Energy Point been generated"
				
			// Level 2 Talant + 100% capacity -> Use Stage 2 Effect
				
			case (.soulExtractor, 100):
				
				guard gameState.enemy.enemyCurrentHP > 0 else { return }
				
				print("Got an extra Energy Point + deal 10% target max hp as a damage")
				
				gameState.hero.flask.currentCombatImpactValue -= 100
				
				let damageValue = Int(Double(gameState.enemy.enemyMaxHP) * 0.10)
				
				if gameState.enemy.enemyCurrentHP - damageValue <= 0 {
					
					winLoseCondition()
					
				} else {
					
					gameState.enemy.enemyCurrentHP -= damageValue
					
					gameState.logMessage = "\(energyPoint) Energy Point been generated + \(damageValue) damage has been dealt"
				}
				
			// Level 3 Talant + Level 1 current capacity -> Use Stage 1 Effect
				
			case (.soulEater, 50..<100):
				
				gameState.hero.flask.currentCombatImpactValue -= 50
				gameState.logMessage = "\(energyPoint) Energy Point been generated"
				
			// Level 3 Talant + Level 2 current capacity -> Use Stage 2 Effect
				
			case (.soulEater, 100..<150):
				
				guard gameState.enemy.enemyCurrentHP > 0 else { return }
				
				print("Got an extra Energy Point + deal 10% target max hp as a damage")
				
				gameState.hero.flask.currentCombatImpactValue -= 100
				
				let damageValue = Int(Double(gameState.enemy.enemyMaxHP) * 0.10)
				
				if gameState.enemy.enemyCurrentHP - damageValue <= 0 {
					
					winLoseCondition()
					
				} else {
					
					gameState.enemy.enemyCurrentHP -= damageValue
					
					gameState.logMessage = "\(energyPoint) Energy Point been generated + \(damageValue) has been dealt"
				}
				
			case (.soulEater, 150):
				
				guard gameState.enemy.enemyCurrentHP > 0 else { return }
				
				print("Got an extra Energy Point + deal 10% target max hp as a damage and gives Empower Ability")
				
				gameState.hero.flask.currentCombatImpactValue -= 150
				
				let damageValue = Int(Double(gameState.enemy.enemyMaxHP) * 0.10)
				
				if gameState.enemy.enemyCurrentHP - damageValue <= 0 {
					
					winLoseCondition()
					
				} else {
					
					gameState.enemy.enemyCurrentHP -= damageValue
				}
				
				gameState.didUseFlaskEmpowerForOffensive = true
				
				gameState.logMessage = "\(energyPoint) Energy Point been generated + \(damageValue) damage  has been dealt + EMPOWER is ready to use"
				
			default:
				print("Not Enough Impact Collected or Something wen't wrong with unleashing flask effect from Offensive Mode")
			}
			
		} else if gameState.hero.flask.battleMode == .defensive {
			
			// 1. Soul Collector - generates extra Dark Energy
			// 2. Soul Extractor - heals for 10% of max hero hp
			// 3. Soul Eater - previous effects + Empower ability
			
			// In all three cases generates some extra dark energy
			
			let darkEnergyLoot = generateDarkEnergyLoot(didFinalBossSummoned: false) / 2
			
			gameState.heroDarkEnergy += darkEnergyLoot
			gameState.heroMaxDarkEnergyOverall += darkEnergyLoot
			gameState.hero.flask.currentXP += darkEnergyLoot
			
			switch (currentFlaskTalant, currentFlaskImpactValue) {
				
			// Level 1 Talant + 100% capacity -> Use Stage 1 Effect
				
			case (.soulCollector, 50):
				print("Got some extra dark energy")
				
				gameState.hero.flask.currentCombatImpactValue -= 50
				gameState.logMessage = "\(darkEnergyLoot) dark energy has been generated"
				
			// Level 2 Talant + not 100% capacity -> Use Level 1 Effect
				
			case (.soulExtractor, 50..<100):
				
				print("Got some extra dark energy")
				
				gameState.hero.flask.currentCombatImpactValue -= 50
				gameState.logMessage = "\(darkEnergyLoot) dark energy has been generated"
				
			// Level 2 Talant + not 100% max capacity -> Use Level 2 Effect
				
			case (.soulExtractor, 100):
				
				print("Got some extra dark energy + 10% of max HP")
				
				gameState.hero.flask.currentCombatImpactValue -= 100
				
				let healingValue = Int(Double(gameState.hero.maxHP) * 0.10)
				
				if gameState.hero.currentHP + healingValue >= gameState.hero.maxHP {
					gameState.hero.currentHP = gameState.hero.maxHP
					
				} else {
					gameState.hero.currentHP += healingValue
				}
				
				gameState.logMessage = "\(darkEnergyLoot) dark energy has been generated + \(healingValue) health ponts has been healed"
				
			// Level 3 Talant + Level 1 current capacity -> Use Level 1 Effect
				
			case (.soulEater, 50..<100):
				
				print("Got some extra dark energy")
				
				gameState.hero.flask.currentCombatImpactValue -= 50
				gameState.logMessage = "\(darkEnergyLoot) dark energy has been generated"
				
			// Level 3 Talant + Level 2 current capacity -> Use Level 2 Effect
				
			case (.soulEater, 100..<150):
				
				print("Got some extra dark energy + 10% of max HP")
				
				gameState.hero.flask.currentCombatImpactValue -= 100
				
				let healingValue = Int(Double(gameState.hero.maxHP) * 0.10)
				
				if gameState.hero.currentHP + healingValue >= gameState.hero.maxHP {
					gameState.hero.currentHP = gameState.hero.maxHP
					
				} else {
					gameState.hero.currentHP += healingValue
				}
				
				gameState.logMessage = "\(darkEnergyLoot) dark energy has been generated + \(healingValue) health ponts has been healed"
				
			case (.soulEater, 150):
				print("Got some extra dark energy + 10% of max HP and Empower ability")
				
				gameState.hero.flask.currentCombatImpactValue -= 150
				
				let healingValue = Int(Double(gameState.hero.maxHP) * 0.1)
				
				if gameState.hero.currentHP + healingValue >= gameState.hero.maxHP {
					gameState.hero.currentHP = gameState.hero.maxHP
					
				} else {
					gameState.hero.currentHP += healingValue
				}
				
				gameState.didUseFlaskEmpowerForDefensive = true
				
				gameState.logMessage = "\(darkEnergyLoot) dark energy has been generated + \(healingValue) health ponts has been healed + EMPOWER is ready to use"
				
			default:
				print("Not Enough Impact Value or Something went wrong from Defensive Mode")
			}
			
		}
		
		// if we use 1 stage effect of Soul Collection (cost 50 while having 75 - it should be still active to use)
		// if it 125 of 150 -> we can use it twice
		
		if gameState.hero.flask.currentCombatImpactValue < 50 {
			gameState.hero.flask.flaskIsReadyToUnleashImpact = false
		}
	}
	
	// MARK: - useFlaskInBattle
	
	/// All properties, methods, talants, bonuses should be applied here in a single method
	func useFlaskInBattlePipeline() {
		
		// Be sure we have resources to use flask
		
		guard gameState.hero.flask.currentCharges > 0 &&
				gameState.hero.flask.actionsToResetCD == 0 &&
				gameState.isHeroTurn
		else {
			return
		}
		
		// Check for charge back chance
		
		if !shouldGetChargeBack() {
			gameState.hero.flask.currentCharges -= 1
			print("got charge back")
		}
		
		// Put flask on CD
		
		if !shouldGetCDreset() {
			gameState.hero.flask.actionsToResetCD = gameState.hero.flask.currentCooldown
			print("got cd reset")
		}
		
		
		// Apply effect accordingly to battle mode
		
		// Defencive Mode
		
		if gameState.hero.flask.battleMode == .defensive {
			
			let healingValue = Int(Double(gameState.hero.maxHP) * gameState.hero.flask.currentHealingValue)
			
			if gameState.hero.currentHP + healingValue > gameState.hero.maxHP {
				gameState.hero.currentHP = gameState.hero.maxHP
			} else {
				gameState.hero.currentHP += healingValue
			}
			
			gameState.logMessage = "Flask did restore \(healingValue) of health"
			
			gameState.currentHeroAnimation = .gotHealing
			
		// Offesive Mode

		} else if gameState.hero.flask.battleMode == .offensive {
			
			// Check for damage debuff from the flask
			
			let damageReductionValue = gameState.hero.flask.baseDamageDebuffAfterUseOnTarget
			
			// Check for flask damage reduction talant
			
			if damageReductionValue > 0 {
				
				gameState.enemy.minDamage -= damageReductionValue
				gameState.enemy.maxDamage -= damageReductionValue
				
				// Do not allow to make damage less than 1
				
				if gameState.enemy.minDamage < 1 {
					gameState.enemy.minDamage = 1
				}
				
				if gameState.enemy.maxDamage < 1 {
					gameState.enemy.maxDamage = 1
				}
				print("Enemy damage has been reduced")
			}
			
			// Check for flask defence reduction talant
			
			let defenceReductionValue = gameState.hero.flask.baseDefenceDebuffAfterUseOnTarget
			
			if defenceReductionValue > 0 {
				
				// Do not allow to reduce to less than 0
				
				gameState.enemy.defence -= defenceReductionValue
				
				if gameState.enemy.defence < 0 {
					gameState.enemy.defence = 0
				}
				
				print("Enemy defence has been reduced")
			}
			
			let damageValue = Int(Double(gameState.enemy.enemyMaxHP) * gameState.hero.flask.currentDamageValue)
			
			gameState.enemy.enemyCurrentHP -= damageValue
			
			gameState.logMessage = "Flask dealt \(damageValue) of damage"
			
			gameState.currentEnemyAnimation = .gotDamage
		}
		
		// Check hero/enemy state
		
		winLoseCondition()
		
		endHeroAndEnemyAnimation()
	}
}
