import SwiftUI

// MARK: - Battle Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildBattleView() -> some View {
		
		// MARK: - UI
		
			VStack {
				
				if viewModel.gameState.didFindFlask {
					
					Text("\(viewModel.gameState.hero.flask.currentSoulCollectionStatus.rawValue): \(viewModel.gameState.hero.flask.currentCombatImpactValue)/\(viewModel.gameState.hero.flask.currentCombatImpactCapacity)")
					ProgressView(
						value: Double(viewModel.gameState.hero.flask.currentCombatImpactValue),
						total: Double(viewModel.gameState.hero.flask.currentCombatImpactCapacity)
					)
					.frame(width: 200)
					.tint(viewModel.gameState.hero.flask.flaskIsCollectingCombatImpact ? .white : .yellow)
					Text(viewModel.gameState.hero.flask.flaskIsReadyToUnleashImpact ? "Flask is ready to unleash!" : "                 ")
					buildShadowFlaskView()
				}
			}
		
		HStack {
			
			Spacer()
			
			// MARK: - HERO UI
			
			VStack {
				
				Text("HP: \(viewModel.gameState.hero.currentHP) / \(viewModel.gameState.hero.maxHP)")
				Text("MP: \(viewModel.gameState.hero.currentMana) / \(viewModel.gameState.hero.maxMana)")
				Text("EP: \(viewModel.gameState.hero.currentEnergy) / \(viewModel.gameState.hero.maxEnergy)")
				Text("CP: \(viewModel.gameState.comboPoints) / 5")
				ZStack {
					
					Rectangle()
						.frame(width: 80, height: 80)
						.foregroundColor(viewModel.gameState.currentHeroAnimation.color)
						.border(Color.white, width: 5)
					Text("Hero")
						.frame(width: 80)
						.multilineTextAlignment(.center)
				}
				Text(viewModel.gameState.didHeroUseBlock ? "Armor ⬆️" : "      ")
			}
			
			Spacer()
			
			// MARK: - ENEMY UI
			
			VStack {
				
				Text("HP: \(viewModel.gameState.enemy.currentHP) / \(viewModel.gameState.enemy.maxHP)")
				Text("MP: \(viewModel.gameState.enemy.currentMP) / \(viewModel.gameState.enemy.maxMana)")
				Text("EP: \(viewModel.gameState.enemy.currentEnergy) / \(viewModel.gameState.enemy.maxEnergy)")
				Text("EMPTY LINE")
					.foregroundStyle(.background)
				ZStack {
					
					Rectangle()
						.frame(width: 80, height: 80)
						.foregroundColor(viewModel.gameState.currentEnemyAnimation.color)
						.border(Color.white, width: 5)
						.offset(y: viewModel.gameState.didEnemyReceivedComboAttack ? 10 : 0)
						.animation(
							Animation.linear(duration: 0.1)
								.repeatCount(3, autoreverses: true),
							value: viewModel.gameState.didEnemyReceivedComboAttack
						)
					
					Text("\(viewModel.gameState.enemy.name)")
						.frame(width: 80)
						.multilineTextAlignment(.center)
				}
				Text(viewModel.gameState.didEnemyUseBlock ? "Armor ⬆️" : "      ")
			}
			
			Spacer()
		}
		
		Spacer()
		
		Text(viewModel.gameState.logMessage)
		
		Spacer()
		
		// MARK: - CoinFlipMiniGame
		
		// In the code below you see a view construction with passing a closure to get it's onGameEnd property back to deal with.
		// THIS CLOSURE IS THE BRIDGE BETWEEN GAME RESULT AND OUTCOME IN BATTLE VIEW
		
		if viewModel.gameState.isCoinFlipMiniGameOn {
			CoinFlipMiniGameView(
				heroChanceForFirstTurn: viewModel.gameState.hero.currentChanceStartTurnFirst
			) { result in
				 viewModel.handleCoinFlipMiniGameResult(for: result)
			}
		}
		
		// MARK: CombatMiniGame
		
		if viewModel.gameState.isCombatMiniGameOn {
			
			CombatMiniGameView { result in
				viewModel.handleCombatMiniGameResult(for: result)
			}
		}
		
		// MARK: EvasionMiniGame
		
		if viewModel.gameState.isEvasionMiniGameOn {
			
			EvasionMiniGame { result in
				viewModel.handleEvasionMiniGameResult(for: result)
			}
		}
		
		// MARK: ShadowBallMiniGame
		
		if viewModel.gameState.isShadowBallMiniGameOn {
			
			ShadowBallMiniGameView(
				
				   onImpact: { result in
					   viewModel.handleShadowMiniGameImpact(for: result)
				   },
				   
				   didGameEnd: { gameEnd in  // true if all 10 resisted?
					   print(gameEnd ? "END OF THE GAME" : "GAME IN PROGRESS")
					   viewModel.gameState.isShadowBallMiniGameOn = false
					   viewModel.winLoseCondition()
				   }
			)
		}

			List {
				
				// MARK: - Actions
				
				Section(header: Text("Actions")) {
					
					Button(viewModel.gameState.didUseFlaskEmpowerForOffensive ? "Attack (Damage \(viewModel.gameState.hero.minDamage)-\(viewModel.gameState.hero.maxDamage), Hit \(viewModel.gameState.hero.hitChance)%, Crit \(viewModel.gameState.hero.critChance)%) Empowered" : "Attack (Damage \(viewModel.gameState.hero.minDamage)-\(viewModel.gameState.hero.maxDamage), Hit \(viewModel.gameState.hero.hitChance)%, Crit \(viewModel.gameState.hero.critChance)%)") {
						viewModel.startCombatMiniGame()
					}
					.foregroundStyle(
						viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? (viewModel.gameState.didUseFlaskEmpowerForOffensive ? .purple : .blue) : (.gray))
					
					// MARK: - Combo Section Starts Here
					
					if viewModel.gameState.comboPoints == 3 {
						Button("Combo (150% damage)") {
							viewModel.comboAttack()
						}
						.foregroundStyle(viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? .orange : .gray)
					}
					
					if viewModel.gameState.comboPoints == 4 {
						Button("Combo (175% damage + Armor Penetration)") {
							viewModel.comboAttack()
						}
						.foregroundStyle(viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? .purple : .gray)
					}
					
					if viewModel.gameState.comboPoints == 5 {
						Button("Combo (300% damage + Armor Penetration)") {
							viewModel.comboAttack()
						}
						.foregroundStyle(viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? .red : .gray)
					}
					
					// MARK: Combo Section End Here
					
					Button(viewModel.gameState.didUseFlaskEmpowerForDefensive ? "Block (\(viewModel.gameState.minBlockValue)-\(viewModel.gameState.maxBlockValue) defence for turn) Empowered" : "Block (\(viewModel.gameState.minBlockValue)-\(viewModel.gameState.maxBlockValue) defence for turn)") {
						viewModel.block()
					}
					.foregroundStyle(
						viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? (viewModel.gameState.didUseFlaskEmpowerForDefensive ? .orange : .blue) : (.gray))
					
					Button(viewModel.gameState.didUseFlaskEmpowerForDefensive ? "Heal (\(viewModel.gameState.healMinValue + viewModel.gameState.hero.spellPower)-\(viewModel.gameState.healMaxValue + viewModel.gameState.hero.spellPower) HP) Empowered" : "Heal (\(viewModel.gameState.healMinValue + viewModel.gameState.hero.spellPower)-\(viewModel.gameState.healMaxValue + viewModel.gameState.hero.spellPower) HP)") {
						viewModel.heal()
					}
					.foregroundStyle(
						viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? (viewModel.gameState.didUseFlaskEmpowerForDefensive ? .orange : .blue) : (.gray))
					
					// MARK: Flask
					
					if viewModel.gameState.didFindFlask {
						if viewModel.gameState.hero.flask.actionsToResetCD == 0 {
							
							Button(viewModel.gameState.hero.flask.battleMode == .defensive ? "Heal yourself by \(viewModel.gameState.hero.flask.currentHealingValueInPercent)% of max HP. Charges (\(viewModel.gameState.hero.flask.currentCharges)/\(viewModel.gameState.hero.flask.currentMaxCharges))" : "Damage by \(viewModel.gameState.hero.flask.currentDamageValueInPercent)% of enemy max HP. Charges (\(viewModel.gameState.hero.flask.currentCharges)/\(viewModel.gameState.hero.flask.currentMaxCharges))") {
								
								viewModel.useFlaskInBattlePipeline()
							}
							.foregroundColor(viewModel.gameState.hero.flask.currentCharges > 0 && viewModel.gameState.isHeroTurn && viewModel.gameState.hero.flask.actionsToResetCD == 0 ? (viewModel.gameState.hero.flask.battleMode == .defensive ? .green : .red) : .gray)
							.opacity(0.75)
							
						} else {
							
							Text("Turns to reset Flask CD: \(viewModel.gameState.hero.flask.actionsToResetCD)/\(viewModel.gameState.hero.flask.currentCooldown)")
								.foregroundColor(.gray)
						}
						
						if viewModel.gameState.isHeroTurn && viewModel.gameState.hero.flask.flaskIsReadyToUnleashImpact {
							
							Button(viewModel.gameState.hero.flask.battleMode == .offensive ? "Unleash Offensively (gain 1 EP)" : "Unleash Defensively (gain dark energy)") {
								
								viewModel.unleashFlaskImpactEffect()
							}
							.foregroundStyle(viewModel.gameState.hero.flask.battleMode == .offensive ? .red : .green)
							.opacity(0.75)
						}
					}
					
					// MARK: End Turn
					
			
					Button("End Turn") {
						viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
						viewModel.endHeroTurn()
					}
					.foregroundStyle(viewModel.gameState.isHeroTurn ? .blue : .gray)
				}
				
				// MARK: Navigation
				
				Section(header: Text("Navigation")) {
					
					Button("Enemy Stats") {
						viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
						viewModel.goToEnemyStats()
					}
					
					// How to fight Alert Controller
					
					if !viewModel.gameState.didEndDemoLevel {
						Button("How to fight Info") {
							viewModel.audioManager.playSound(fileName: "openInfo", extensionName: "mp3")
							isCombatInfoAlertOpen = true
						}
						
						.alert("Combat",
							   isPresented: $isCombatInfoAlertOpen) {
							
							Button("Got it", role: .cancel) {
								viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
								isCombatInfoAlertOpen = false
							}
						} message: {
							Text("""
		You and enemy will act in turns.		
	You have EP (Energy Points), each action usually costs 1 EP.					
	By hitting enemy with Attack button multiple times you will get CP (Combo Points).								
	After getting 3+ you will be able to commit a powerful strike with different effects.
	""")
						}
					}
				}
				
				// MARK: - Testability
				
				Section(header: Text("Testability")) {
					
					Button("Instant Enemy Kill") {
						viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
						viewModel.testEnemyExecute()
					}
					
					Button("Restore Hero Combo Points") {
						viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
						viewModel.testComboPointsRestoration()
					}
					
					Button("Restore Both Targets Stats") {
						viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
						viewModel.restoreStats()
					}
					
					if viewModel.gameState.didFindFlask {
						
						Button("Reset Flask CD") {
							viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
							viewModel.testFlaskCDreset()
						}
						
						Button {
							viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
							viewModel.toggleCurrentSoulCollectionStatus()
						} label: {
							Text("Toggle current Soul Collection Status (\(viewModel.gameState.hero.flask.currentSoulCollectionStatus.rawValue))")
						}
						
						Button("Refill Soul Collection") {
							viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
							viewModel.refillSoulCollection()
						}
					}
					
				}
				
			}
			.disabled(!viewModel.gameState.isHeroTurn)
		}
	}
