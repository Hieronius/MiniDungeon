import Foundation
import SwiftUI

extension MainViewModel {
	
	// MARK: - startCombatMiniGame
	
	/// Check energy for action and start a miniGame
	func startCombatMiniGame() {
		
		if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost {
			gameState.isCombatMiniGameOn = true
			playAttackSound(didMissHit: false)
		} else {
			audioManager.playSound(fileName: "denied", extensionName: "mp3")
		}
	}
	
	// MARK: - handleCoinFlipMiniGameResult
	
	/// Method to handle CoinFlipMiniGame outcome
	func handleCoinFlipMiniGameResult(for result: Bool) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
			self.gameState.isCoinFlipMiniGameOn = false
			if !result {
				self.gameState.isHeroTurn = false
				self.enemyTurn()
			}
		}
	}
	
	// MARK: - handleCombatMiniGameResult
	
	func handleCombatMiniGameResult(for result: Bool) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.gameState.isCombatMiniGameOn = false
			self.continueAttackAfterMiniGame(combatMiniGameSuccess: result, evasionMiniGameSuccess: false)
		}
	}
	
	// MARK: - handleEvasionMiniGameResult
	
	func handleEvasionMiniGameResult(for result: Bool) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.gameState.isEvasionMiniGameOn = false
			self.continueAttackAfterMiniGame(combatMiniGameSuccess: result, evasionMiniGameSuccess: result)
			
			if result {
				self.audioManager.playSound(fileName: "evasionSuccess", extensionName: "mp3")
			} else {
//				self.audioManager.playSound(fileName: "denied", extensionName: "mp3")
			}
		}
	}
	
	// MARK: - handleShadowMiniGameImpact
	
	func handleShadowMiniGameImpact(for result: Bool) {
		
		if result {
			
			// some kind of positive buff, word or rewards
			audioManager.playSound(fileName: "shadowBallBlock", extensionName: "mp3")
		} else {
			
			// negative impact of each ball which hits the edge of the screen
			// current plan is to damage hero by 50% for 10 missed balls which
			// gives us around 5% for each ball
			
			let damageImpact = Int(Double(gameState.hero.maxHP) * 0.1)
			gameState.hero.currentHP -= damageImpact
			gameState.currentHeroAnimation = .gotDamage
			gameState.hero.flask.collectCombatImpactWithAnimation(impact: damageImpact)
			audioManager.playSound(fileName: "shadowBallHit", extensionName: "mp3")
			
		}
		endHeroAndEnemyAnimation()
	}
	
	// MARK: startBattleWithRandomNonEliteEnemy
	
	/// Method to prepare game state and both sides for a battle
	func startBattleWithRandomNonEliteEnemy() {
		
		gameState.isCoinFlipMiniGameOn = true
		audioManager.playSound(fileName: "coinFlip", extensionName: "mp3")
		gameState.enemy = generateEnemy(didFinalBossSummoned: false)
		restoreAllEnergy()
		gameState.didHeroUseBlock = false
		gameState.didEnemyUseBlock = false
		goToBattle()
		gameState.logMessage = "Battle begin!"
	}
	
	// MARK: - Attack
	
	/// Method react to two properties
	/// combatMiniGameSuccess mean if user's attack should be improved
	/// evasionMiniGameSuccess mean if user did dodge an enemy attack
	func continueAttackAfterMiniGame(
		combatMiniGameSuccess: Bool,
		evasionMiniGameSuccess: Bool
	) {
		
		gameState.isCombatMiniGameSuccessful = combatMiniGameSuccess
		
		// MARK: - HERO ATTACK
		
		if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			
			// MARK: Energy Surge Perk Check
			
			if gameState.isEnergySurgePerkActive {
				
				let energyBackRoll = Int.random(in: 1...100)
				
				if energyBackRoll <= gameState.energySurgeEffectModifier {
					gameState.hero.currentEnergy += 1
				}
			}
			
			let hitRoll = Int.random(in: 1...100)
			
			if hitRoll > gameState.hero.hitChance {
				gameState.logMessage = "Hero's Attack has been missed!"
				playAttackSound(didMissHit: true)
				return
			}
			
			// MARK: Crushing Blow Perk Check
			
			if gameState.isCrushingBlowPerkActive {
				
				// THIS CODE DEDUCT ENEMY ENERGY POINTS INCORRECT
				
				let roll = Int.random(in: 1...100)
				if roll <= gameState.crushingBlowEffectModifier {
					gameState.enemy.maxEnergy -= 1
				}
			}
			
			// MARK: Armor Destruction Perk Check
			
			if gameState.isArmorDestructionPerkActive {
				
				gameState.enemy.defence -= gameState.armorDestructionEffectModifier
				
				if gameState.enemy.defence < 0 {
					gameState.enemy.defence = 0
				}
			}
			
			// MARK: Base Damage Calculation
			
			var baseDamage = Int(Double(Int.random(in: gameState.hero.minDamage...gameState.hero.maxDamage)) * gameState.hero.currentAttackDamageModifier)
			print("test damage indicator - \(baseDamage)")
			
			// MARK: Perk Of Preparation
			// Prep Perk Check should verify is perk active, was block used, wasn't perk effect already applied during this turn
			
			if gameState.isPrepPerkActive &&
				!gameState.didPrepPerkAffectCurrentTurn &&
				gameState.shouldPrepPerkAffectNextAttack {
				
				baseDamage += calculateBlockValueBonusDamageForNextAttack()
				gameState.didPrepPerkAffectCurrentTurn = true
			}
			
			// MARK: Perk Of Ill Word
			// Ill Word Perk Check should verify is perk active, was heal used, wasn't perk effect already applied during this turn
			
			if gameState.isIllWordPerkActive &&
				!gameState.didIllWordPerkAffectCurrentTurn &&
				gameState.shouldIllWordPerkAffectNextAttack {
				
				baseDamage += calculateHealValueDamageBonusForNextAttack()
				gameState.didIllWordPerkAffectCurrentTurn = true
			}
			
			// MARK: Enemy Base Armor Calculation
			// Deduct all talants and abilities from enemy armor before calculation
			
			let finalEnemyArmor = (gameState.enemy.defence - gameState.hero.currentArmorPenetration)
			
			// this is a final base damage after armor deduction
			var finalDamage = baseDamage - finalEnemyArmor
			
			// MARK: Empower
			// EMPOWER FLAG ON (May be should be put to the different place due to huge Defence Ratio Influence. If there 5 enemy defence you can deal 0 damage with CRIT + EMPOWER + 5 EP COMBO which is not fun)
			
			
			if gameState.didUseFlaskEmpowerForOffensive {
				finalDamage *= 2
			}
			
			// MARK: CombatMiniGame
			// mini game success check
			
			if gameState.isCombatMiniGameSuccessful  {
				finalDamage = Int(Double(finalDamage) * 1.25)
				gameState.logMessage += "Nice Hit!"
			}
			
			// MARK: Crit Chance
			// crit chance
			
			if finalDamage > 0 {
				
				let critRoll = Int.random(in: 1...100)
				
				if critRoll <= gameState.hero.critChance {
					
					let criticalDamage = Int(Double(finalDamage) * gameState.hero.currentCritEffectModifier)
					
					// MARK: Soul Extraction Perk
					// Soul Extraction Perk Check
					
					if gameState.isSoulExtractionPerkActive {
						
						gameState.heroDarkEnergy += calculateSoulExtractionEffect(from: criticalDamage)
						gameState.heroMaxDarkEnergyOverall += calculateSoulExtractionEffect(from: criticalDamage)
					}
					
					// MARK: Vampirism Perk
					// Vampirism Perk Check
					
					if gameState.isVampirismPerkActive {
						
						gameState.hero.currentHP += calculateVampiricEffect(from: criticalDamage)
						
						if gameState.hero.currentHP > gameState.hero.maxHP {
							gameState.hero.currentHP = gameState.hero.maxHP
						}
					}
					
					// MARK: Spell Stealing Perk
					// Spell Stealing Perk (MP Vampirism) Check
					
					if gameState.isSpellStealingPerkActive {
						
						gameState.hero.currentMana += calculateSpellStealingEffect(from: criticalDamage)
						
						if gameState.hero.currentMana > gameState.hero.maxMana {
							gameState.hero.currentMana = gameState.hero.maxMana
						}
					}
					
					// MARK: Damage Impact for Flask
					// Collect Damage Done Impact
					
					gameState.hero.flask.collectCombatImpactWithAnimation(impact: criticalDamage)
					
					gameState.enemy.currentHP -= criticalDamage
					gameState.logMessage = "Critical hit - \(criticalDamage) has been done!"
					
					// MARK: Perk Of Swiftness
					// Swiftness Perk Check
					
					if gameState.isSwiftnessPerkActive {
						
						let roll = Int.random(in: 1...100)
						if roll <= gameState.swiftnessPerkEffectModifier {
							
							gameState.hero.flask.collectCombatImpactWithAnimation(impact: criticalDamage)
							
							gameState.enemy.currentHP -= criticalDamage
							gameState.logMessage = "DOUBLE ATTACK - \(criticalDamage) has been done!"
						}
					}
					
				} else {
					
					// Vampirism Perk
					
					if gameState.isVampirismPerkActive {
						
						gameState.hero.currentHP += calculateVampiricEffect(from: finalDamage)
						
						if gameState.hero.currentHP > gameState.hero.maxHP {
							gameState.hero.currentHP = gameState.hero.maxHP
						}
					}
					
					// Spell Stealing Perk (MP Vampirism)
					
					if gameState.isSpellStealingPerkActive {
						
						gameState.hero.currentMana += calculateSpellStealingEffect(from: finalDamage)
						
						if gameState.hero.currentMana > gameState.hero.maxMana {
							gameState.hero.currentMana = gameState.hero.maxMana
						}
					}
					
					// Collect Damage Done Impact
					
					gameState.hero.flask.collectCombatImpactWithAnimation(impact: finalDamage)
					
					gameState.enemy.currentHP -= finalDamage
					gameState.logMessage = "\(finalDamage) damage has been done."
					
					// Swiftness Perk Check
					
					if gameState.isSwiftnessPerkActive {
						
						let roll = Int.random(in: 1...100)
						if roll <= gameState.swiftnessPerkEffectModifier {
							
							gameState.hero.flask.collectCombatImpactWithAnimation(impact: finalDamage)
							
							gameState.enemy.currentHP -= finalDamage
							gameState.logMessage = "DOUBLE ATTACK - \(finalDamage) has been done!"
						}
					}
				}
				
				gameState.currentEnemyAnimation = .gotDamage
//				playAttackSound(didMissHit: false)
				audioManager.playSound(fileName: "comboHit1", extensionName: "mp3")
				
			}
			
			// If hero hit an enemy even with 0 damage -> add combo points
			if gameState.comboPoints < 5 {
				gameState.comboPoints += 1
			}
			
			// MARK: - ENEMY ATTACK
			
		} else if !gameState.isHeroTurn && gameState.enemy.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.enemy.currentEnergy -= gameState.skillEnergyCost
			
			if evasionMiniGameSuccess {
				gameState.logMessage = "Perfect Evasion!"
				return
			}
			
			let hitRoll = Int.random(in: 1...100)
			if hitRoll > gameState.enemy.hitChance {
				gameState.logMessage = "Enemy Attack has been missed"
				playAttackSound(didMissHit: true)
				return
			}
			
			let damage = Int.random(in: gameState.enemy.minDamage...gameState.enemy.maxDamage) - gameState.hero.defence
			
			let critRoll = Int.random(in: 1...100)
			
			if damage > 0 {
				
				if critRoll <= gameState.enemy.critChance {
					
					let criticalDamage = Int(Double(damage) * 1.5)
					
					// Reflection Flag Check for Critical Hit
					
					if gameState.isReflectionPerkActive &&
						gameState.shouldReflectAttacks {
						
						gameState.enemy.currentHP -= calculateReflectionDamage(damage: criticalDamage)
					}
					
					// Collect Critical Damage Received Impact
					
					gameState.hero.flask.collectCombatImpactWithAnimation(impact: criticalDamage)
					
					gameState.hero.currentHP -= criticalDamage
					gameState.logMessage = "Critical hit - \(criticalDamage) has been done!"
					
				} else {
					
					// Collect Damage Received Impact
					
					gameState.hero.flask.collectCombatImpactWithAnimation(impact: damage)
					
					// Reflection Flag Check for Normal Hit
					
					if gameState.isReflectionPerkActive &&
						gameState.shouldReflectAttacks {
						
						gameState.enemy.currentHP -= calculateReflectionDamage(damage: damage)
					}
					
					gameState.hero.currentHP -= damage
					
					gameState.logMessage = "\(damage) damage has been done by enemy"
				}
				audioManager.playSound(fileName: "comboHit1", extensionName: "mp3")
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
		
		guard gameState.hero.currentEnergy >= 1 else {
			audioManager.playSound(fileName: "denied", extensionName: "mp3")
			return
		}
		guard gameState.comboPoints >= 3 else { return }
		

		switch gameState.comboPoints {
			
		case 3:
			
			audioManager.playSound(fileName: "comboHit1", extensionName: "mp3")
			
			// With 3 combo points it will be an attack of 150% of damage
			
			let firstStageComboModifier = 0.5 + gameState.hero.currentComboDamageModifier
			
			let baseDamage = Int.random(in: gameState.hero.minDamage...gameState.hero.maxDamage)
			
			let finalEnemyArmor = gameState.enemy.defence - gameState.hero.currentArmorPenetration
			
			let finalDamage = Int(Double(baseDamage - finalEnemyArmor) * firstStageComboModifier)
			
			let critRoll = Int.random(in: 1...100)
			
			if critRoll <= gameState.hero.critChance {
				
				let criticalDamage = Int(Double(finalDamage) * gameState.hero.currentCritEffectModifier)
				
				gameState.hero.flask.collectCombatImpactWithAnimation(impact: criticalDamage)
				
				gameState.enemy.currentHP -= criticalDamage
				gameState.logMessage = "Critical Combo hit! - \(criticalDamage) has been done!"
				
			} else {
				
				gameState.hero.flask.collectCombatImpactWithAnimation(impact: finalDamage)
				
				gameState.enemy.currentHP -= finalDamage
				gameState.logMessage = "\(finalDamage) Combo damage has been done!"
			}
			
		case 4:
			
			// With 4 Combo Points - 175% of damage + ignore target armor
			
			audioManager.playSound(fileName: "comboHit3", extensionName: "mp3")
			
			let secondStageComboModifier = 0.75 + gameState.hero.currentComboDamageModifier
			
			let baseDamage = Int.random(in: gameState.hero.minDamage...gameState.hero.maxDamage)
			
			let finalDamage = Int(Double(baseDamage) * secondStageComboModifier)
			
			let critRoll = Int.random(in: 1...100)
			
			if critRoll <= gameState.hero.critChance {
				
				let criticalDamage = Int(Double(finalDamage) * gameState.hero.currentCritEffectModifier)
				
				gameState.hero.flask.collectCombatImpactWithAnimation(impact: criticalDamage)
				
				gameState.enemy.currentHP -= criticalDamage
				gameState.logMessage = "Critical Combo hit! - \(criticalDamage) has been done!"
				
			} else {
				
				gameState.hero.flask.collectCombatImpactWithAnimation(impact: finalDamage)
				
				gameState.enemy.currentHP -= finalDamage
				gameState.logMessage = "\(finalDamage) Combo damage has been done!"
			}
			
		case 5:
			
			// With 5 Combo Points you deal 300% damage + ignore armor
			
			// This attack deduct base damage by enemy armor and only after apply it's modifiers. It's mean if base damage will be 1 it can inflict 0 damage if enemy armor is 1
			
			audioManager.playSound(fileName: "comboHit2", extensionName: "mp3")
			
			let thirdStageComboModifier = 1.0 + gameState.hero.currentComboDamageModifier
			
			let baseDamage = Int.random(in: gameState.hero.minDamage...gameState.hero.maxDamage)
			
			let finalDamage = Double(baseDamage) * thirdStageComboModifier
			
			let criticalDamage = Int(finalDamage * gameState.hero.currentCritEffectModifier)
			
			gameState.hero.flask.collectCombatImpactWithAnimation(impact: criticalDamage)
			
			gameState.enemy.currentHP -= criticalDamage
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
		gameState.enemy.currentHP -= 100
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
	
	// MARK: - block
	
	func block() {
		
		if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost {
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			
			// Energy Surge Perk Check
			
			if gameState.isEnergySurgePerkActive {
				
				let energyBackRoll = Int.random(in: 1...100)
				
				if energyBackRoll <= gameState.energySurgeEffectModifier {
					gameState.hero.currentEnergy += 1
				}
			}
			
			// Preparation Perk Activation
			
			if gameState.isPrepPerkActive {
				gameState.shouldPrepPerkAffectNextAttack = true
			}
			
			// Reflection Perk Activation
			
			if gameState.isReflectionPerkActive {
				gameState.shouldReflectAttacks = true
			}
			
			// Resilience Perk Check
			
			if gameState.isResiliencePerkActive {
				gameState.shouldEmpowerNextHeal = true
			}
			
			
			// Collect Block Ability Impact
			
			var blockValue = (gameState.minBlockValue...gameState.maxBlockValue).randomElement() ?? 0
			var blockConsoleMessage = ""
			
			// Fortitude Perk Check
			
			if gameState.isFortitudePerkActive && gameState.shouldEmpowerNextBlock {
				
				blockValue += gameState.fortitudeEffectModifier
				
				// we should empower only a single block after using a single heal, not all of the blocks during the turn. Who know if in the future the block effect will be able to stack up
				gameState.shouldEmpowerNextBlock = false
			}
			
			let critChance = Int.random(in: 1...100)
			
			if critChance <= gameState.hero.critChance {
				
				blockValue = Int(Double(blockValue) * gameState.hero.currentCritEffectModifier)
				blockConsoleMessage = "Critical Block!"
			}
			
			// Flask Soul Eater Talant Check with 150/150 Combat Impact Collected
			
			if gameState.didUseFlaskEmpowerForDefensive {
				
				blockValue *= 2
			}
			
			gameState.hero.flask.collectCombatImpactWithAnimation(impact: blockValue)
			
			if gameState.didHeroUseBlock == false {
				
				gameState.hero.baseDefence += blockValue
				gameState.heroBlockValueBuffer = blockValue
				gameState.didHeroUseBlock = true
				gameState.logMessage = "\(blockConsoleMessage) \(blockValue) has been added to the Hero Defence!"
				
				audioManager.playSound(fileName: "shieldBlock", extensionName: "mp3")
				gameState.currentHeroAnimation = .usedBlock
			}
			
			// Swiftness Perk Check
			
			if gameState.isSwiftnessPerkActive {
				
				let roll = Int.random(in: 1...100)
				
				if roll <= gameState.swiftnessPerkEffectModifier {
					gameState.hero.baseDefence += blockValue
					gameState.heroBlockValueBuffer = blockValue
					gameState.didHeroUseBlock = true
					gameState.logMessage = "DOUBLE BLOCK \(blockConsoleMessage) \(blockValue * 2) has been added to the Hero Defence!"
				}
			}
			
		} else if gameState.isHeroTurn && !(gameState.hero.currentEnergy >= gameState.skillEnergyCost) {
			
			audioManager.playSound(fileName: "denied", extensionName: "mp3")
			
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
				
				gameState.logMessage = "\(blockConsoleMessage) \(blockValue) has been added to the Enemy Defence!"
				
				audioManager.playSound(fileName: "shieldBlock", extensionName: "mp3")
				gameState.currentEnemyAnimation = .usedBlock
			}
		}
		
		// Reset Empower Flag after use
		gameState.didUseFlaskEmpowerForDefensive = false
		endHeroAndEnemyAnimation()
	}
	
	// MARK: - calculateBlockValueBonusDamageForNextAttack
	
	/// This method will get average block value to increase the damage of next attack if Common Perk of Preparation is Active
	func calculateBlockValueBonusDamageForNextAttack() -> Int {
		
		let bonusDamage = Int(Double((gameState.minBlockValue + gameState.maxBlockValue) / 2) * gameState.prepPerkEffectModifier)
		print("Added \(bonusDamage) as PrepPerk bonus block value to next attack")
		return bonusDamage
	}
	
	// MARK: - calculateReflectionDamage
	
	func calculateReflectionDamage(damage: Int) -> Int {
		
		let reflectionDamage = Int(Double(damage) * gameState.reflectionPerkEffectModifier)
		print("Enemy should get back - \(reflectionDamage)")
		return reflectionDamage
	}
	
	// MARK: - heal
	
	func heal() {
		
		// Hero Turn
		
		if gameState.isHeroTurn &&
			gameState.hero.currentEnergy >= gameState.skillEnergyCost &&
			gameState.hero.currentMana >= gameState.spellManaCost {
			
			gameState.hero.currentEnergy -= gameState.skillEnergyCost
			gameState.hero.currentMana -= gameState.spellManaCost
			
			// Health Grow Perk Check
			
			if gameState.isHealthGrowPerkActive && !gameState.wasHealthGrowPerkEffectUsed {
				
				gameState.hero.baseMaxHP += gameState.healthGrowEffectModifier
				gameState.wasHealthGrowPerkEffectUsed = true
			}
			
			// Energy Surge Perk Check
			
			if gameState.isEnergySurgePerkActive {
				
				let energyBackRoll = Int.random(in: 1...100)
				
				if energyBackRoll <= gameState.energySurgeEffectModifier {
					gameState.hero.currentEnergy += 1
				}
			}
			
			if gameState.isIllWordPerkActive {
				gameState.shouldIllWordPerkAffectNextAttack = true
			}
			
			if gameState.isFortitudePerkActive {
				gameState.shouldEmpowerNextBlock = true
			}
			
			let minHealValue = gameState.healMinValue + gameState.hero.spellPower
			let maxHealValue = gameState.healMaxValue + gameState.hero.spellPower
			
			var healingValue = (minHealValue...maxHealValue).randomElement() ?? 0
			
			// Resilience Perk Check
			
			if gameState.isResiliencePerkActive && gameState.shouldEmpowerNextHeal {
				
				healingValue += gameState.resilienceEffectModifier
				
				gameState.shouldEmpowerNextHeal = false
			}
			
			// apply crit here
			
			let critRoll = Int.random(in: 1...100)
			var critConsoleMessage = ""
			
			if critRoll <= gameState.hero.critChance {
				
				healingValue = Int(Double(healingValue) * gameState.hero.currentCritEffectModifier)
				
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
			
			audioManager.playSound(fileName: "healSpell1", extensionName: "mp3")
			gameState.currentHeroAnimation = .gotHealing
			
			gameState.logMessage = "\(critConsoleMessage) \(healingValue) amount of health has been recovered by hero"
			
			// Swiftness Perk Check
			
			if gameState.isSwiftnessPerkActive {
				
				let roll = Int.random(in: 1...100)
				if roll <= gameState.swiftnessPerkEffectModifier {
					
					gameState.hero.currentHP += healingValue
					
					// Collect Healing Ability Impact
					
					gameState.hero.flask.collectCombatImpactWithAnimation(
						impact: healingValue
					)
					
					gameState.logMessage = "DOUBLE \(critConsoleMessage) \(healingValue) amount of health has been recovered by hero"
				}
			}
			
			
			if gameState.hero.currentHP >= gameState.hero.maxHP {
				gameState.hero.currentHP = gameState.hero.maxHP
			}
			
		} else if gameState.isHeroTurn &&
					!(gameState.hero.currentEnergy >= gameState.skillEnergyCost) ||
					!(gameState.hero.currentMana >= gameState.spellManaCost) {
			
			audioManager.playSound(fileName: "denied", extensionName: "mp3")
			
		} else if gameState.isHeroTurn && gameState.hero.currentEnergy >= gameState.skillEnergyCost &&
			gameState.hero.currentMana < gameState.spellManaCost {
			gameState.logMessage = "Not enough mana to cast"
			audioManager.playSound(fileName: "denied", extensionName: "mp3")
			
			
			// Enemy Turn
			
		} else if !gameState.isHeroTurn &&
					gameState.enemy.currentEnergy >= gameState.skillEnergyCost &&
					gameState.enemy.currentMP >= gameState.spellManaCost {
			
			gameState.enemy.currentEnergy -= gameState.skillEnergyCost
			gameState.enemy.currentMP -= gameState.spellManaCost
			
			let minHealValue = gameState.healMinValue + gameState.enemy.spellPower
			let maxHealValue = gameState.healMaxValue + gameState.enemy.spellPower
			
			var healingValue = (minHealValue...maxHealValue).randomElement() ?? 0
			
			let critRoll = Int.random(in: 1...100)
			var critConsoleMessage = ""
			
			if critRoll <= gameState.enemy.critChance {
				
				healingValue = Int(Double(healingValue) * 1.5)
				
				critConsoleMessage = "Critical Heal Effect!"
				
			}
			
			gameState.enemy.currentHP += healingValue
			gameState.logMessage = "\(critConsoleMessage) \(healingValue) amount of health has been recovered by enemy"
			
			if gameState.enemy.currentHP >= gameState.enemy.maxHP {
				gameState.enemy.currentHP = gameState.enemy.maxHP
			}
			
			audioManager.playSound(fileName: "healSpell1", extensionName: "mp3")
			gameState.currentEnemyAnimation = .gotHealing
			
		}
		// Reset Empower Flag after use
		gameState.didUseFlaskEmpowerForDefensive = false
		endHeroAndEnemyAnimation()
	}
	
	// MARK: - calculateHealValueDamageBonusForNextAttack
	
	/// Method to calculate average heal value to empower a next attack accordingly to Ill Word Perk
	func calculateHealValueDamageBonusForNextAttack() -> Int {
		
		let bonusDamage = Int(Double((gameState.healMinValue + gameState.healMaxValue) / 2) * gameState.illWordPerkEffectModifier)
		print("heal value bonus damage for next ability - \(bonusDamage)")
		return bonusDamage
	}
	
	// MARK: - calculateVampiricEffect
	
	/// Method should calculate how big chunk of hero damage should transform into HP
	func calculateVampiricEffect(from damage: Int) -> Int {
		
		let vampiricEffect = Int(Double(damage) * gameState.vampirismEffectModifier)
		print("Vampiric effect from this attack is \(vampiricEffect) hp")
		return vampiricEffect
	}
	
	// MARK: - calculateSpellStealingEffect
	
	/// Method should calculate how big chunk of hero damage should transform into MP
	func calculateSpellStealingEffect(from damage: Int) -> Int {
		
		let spellStealingEffect = Int(Double(damage) * gameState.spellStealingEffectModifier)
		print("Spell Stealing effect from this attack is \(spellStealingEffect) mp")
		return spellStealingEffect
	}
	
	// MARK: - calculateSoulExtractionEffect
	
	/// Method should calculate how much of the critical damage done should be converted to Dark Energy
	func calculateSoulExtractionEffect(from criticalHit: Int) -> Int {
		
		let extractionEffect = Int(Double(criticalHit) * gameState.soulExtractionEffectModifier)
		print("Extraction effect is \(extractionEffect) dark energy")
		return extractionEffect
	}
	
	// MARK: - unleashFlaskImpactEffect
	
	/// Method to determine what effect flask should use when it collected enough impact and accordingly of it's SoulCollectionTalant status and Battle Mode
	func unleashFlaskImpactEffect() {
		
		guard gameState.enemy.currentHP > 0 else { return }
		
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
				audioManager.playSound(fileName: "flaskImpactUnleash", extensionName: "mp3")
				
			// Level 2 Talant + not 100% capacity -> Use Stage 1 Effect
				
			case (.soulExtractor, 50..<100):
				
				gameState.hero.flask.currentCombatImpactValue -= 50
				gameState.logMessage = "\(energyPoint) Energy Point been generated"
				audioManager.playSound(fileName: "flaskImpactUnleash", extensionName: "mp3")
				
			// Level 2 Talant + 100% capacity -> Use Stage 2 Effect
				
			case (.soulExtractor, 100):
				
				guard gameState.enemy.currentHP > 0 else { return }
				
				print("Got an extra Energy Point + deal 10% target max hp as a damage")
				
				gameState.hero.flask.currentCombatImpactValue -= 100
				
				let damageValue = Int(Double(gameState.enemy.maxHP) * 0.10)
				
				if gameState.enemy.currentHP - damageValue <= 0 {
					
					winLoseCondition()
					
				} else {
					
					gameState.enemy.currentHP -= damageValue
					
					gameState.logMessage = "\(energyPoint) Energy Point been generated + \(damageValue) damage has been dealt"
				}
				audioManager.playSound(fileName: "flaskImpactUnleash", extensionName: "mp3")
				
			// Level 3 Talant + Level 1 current capacity -> Use Stage 1 Effect
				
			case (.soulEater, 50..<100):
				
				gameState.hero.flask.currentCombatImpactValue -= 50
				gameState.logMessage = "\(energyPoint) Energy Point been generated"
				audioManager.playSound(fileName: "flaskImpactUnleash", extensionName: "mp3")
				
			// Level 3 Talant + Level 2 current capacity -> Use Stage 2 Effect
				
			case (.soulEater, 100..<150):
				
				guard gameState.enemy.currentHP > 0 else { return }
				
				print("Got an extra Energy Point + deal 10% target max hp as a damage")
				
				gameState.hero.flask.currentCombatImpactValue -= 100
				
				let damageValue = Int(Double(gameState.enemy.maxHP) * 0.10)
				
				if gameState.enemy.currentHP - damageValue <= 0 {
					
					winLoseCondition()
					
				} else {
					
					gameState.enemy.currentHP -= damageValue
					
					gameState.logMessage = "\(energyPoint) Energy Point been generated + \(damageValue) has been dealt"
				}
				audioManager.playSound(fileName: "flaskImpactUnleash", extensionName: "mp3")
				
			case (.soulEater, 150):
				
				guard gameState.enemy.currentHP > 0 else { return }
				
				print("Got an extra Energy Point + deal 10% target max hp as a damage and gives Empower Ability")
				
				gameState.hero.flask.currentCombatImpactValue -= 150
				
				let damageValue = Int(Double(gameState.enemy.maxHP) * 0.10)
				
				if gameState.enemy.currentHP - damageValue <= 0 {
					
					winLoseCondition()
					
				} else {
					
					gameState.enemy.currentHP -= damageValue
				}
				
				gameState.didUseFlaskEmpowerForOffensive = true
				
				gameState.logMessage = "\(energyPoint) Energy Point been generated + \(damageValue) damage  has been dealt + EMPOWER is ready to use"
				audioManager.playSound(fileName: "flaskImpactUnleash", extensionName: "mp3")
				
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
				audioManager.playSound(fileName: "flaskImpactUnleash", extensionName: "mp3")
				
			// Level 2 Talant + not 100% capacity -> Use Level 1 Effect
				
			case (.soulExtractor, 50..<100):
				
				print("Got some extra dark energy")
				
				gameState.hero.flask.currentCombatImpactValue -= 50
				gameState.logMessage = "\(darkEnergyLoot) dark energy has been generated"
				audioManager.playSound(fileName: "flaskImpactUnleash", extensionName: "mp3")
				
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
				audioManager.playSound(fileName: "flaskImpactUnleash", extensionName: "mp3")
				
			// Level 3 Talant + Level 1 current capacity -> Use Level 1 Effect
				
			case (.soulEater, 50..<100):
				
				print("Got some extra dark energy")
				
				gameState.hero.flask.currentCombatImpactValue -= 50
				gameState.logMessage = "\(darkEnergyLoot) dark energy has been generated"
				audioManager.playSound(fileName: "flaskImpactUnleash", extensionName: "mp3")
				
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
				audioManager.playSound(fileName: "flaskImpactUnleash", extensionName: "mp3")
				
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
				audioManager.playSound(fileName: "flaskImpactUnleash", extensionName: "mp3")
				
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
		
		guard gameState.enemy.currentHP > 0 else { return }
		
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
			audioManager.playSound(fileName: "flaskEffectUnleash", extensionName: "mp3")
			
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
			
			let damageValue = Int(Double(gameState.enemy.maxHP) * gameState.hero.flask.currentDamageValue)
			
			gameState.enemy.currentHP -= damageValue
			
			gameState.logMessage = "Flask dealt \(damageValue) of damage"
			
			gameState.currentEnemyAnimation = .gotDamage
			audioManager.playSound(fileName: "flaskEffectUnleash", extensionName: "mp3")
		}
		
		// Check hero/enemy state
		
		endHeroAndEnemyAnimation()
		
		winLoseCondition()
	}
}
