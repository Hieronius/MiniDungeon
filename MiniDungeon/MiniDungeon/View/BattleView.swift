import SwiftUI

// MARK: - Battle Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildBattleView() -> some View {
		
		// MARK: - UI
		
			VStack {
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
				
				Text("HP: \(viewModel.gameState.enemy.enemyCurrentHP) / \(viewModel.gameState.enemy.enemyMaxHP)")
				Text("MP: \(viewModel.gameState.enemy.currentMana) / \(viewModel.gameState.enemy.maxMana)")
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
		
		// MARK: Actions
		
		if viewModel.gameState.isCombatMiniGameIsOn {
			
			// MARK: Call Mini Game and get it's result
			
			CombatMiniGameView { success in
				viewModel.gameState.isCombatMiniGameSuccessful = success
				print(success)
				// TODO: Probably should be inside the method in ViewModel
				DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
					viewModel.gameState.isCombatMiniGameIsOn = false
					viewModel.continueAttackAfterMiniGame(success: success)
				}
			}
		}

			List {
				
				Section(header: Text("Actions")) {
					
					Button(viewModel.gameState.didUseFlaskEmpowerForOffensive ? "Attack (Damage \(viewModel.gameState.hero.minDamage)-\(viewModel.gameState.hero.maxDamage), Hit \(viewModel.gameState.hero.hitChance)%, Crit \(viewModel.gameState.hero.critChance)%) Empowered" : "Attack (Damage \(viewModel.gameState.hero.minDamage)-\(viewModel.gameState.hero.maxDamage), Hit \(viewModel.gameState.hero.hitChance)%, Crit \(viewModel.gameState.hero.critChance)%)") {
						viewModel.startMiniGame()
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
					
					if viewModel.gameState.hero.flask.actionsToResetCD == 0 {
						
						Button(viewModel.gameState.hero.flask.battleMode == .defensive ? "Heal yourself by \(viewModel.gameState.hero.flask.currentHealingValueInPercent)% of max HP.   Charges (\(viewModel.gameState.hero.flask.currentCharges)/\(viewModel.gameState.hero.flask.currentMaxCharges))" : "Damage by \(viewModel.gameState.hero.flask.currentDamageValueInPercent)% of enemy max HP. Charges (\(viewModel.gameState.hero.flask.currentCharges)/\(viewModel.gameState.hero.flask.currentMaxCharges))") {
							
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
					
					// MARK: End Turn
					
			
					Button("End Turn") {
						viewModel.endHeroTurn()
					}
					.foregroundStyle(viewModel.gameState.isHeroTurn ? .blue : .gray)
					.disabled(viewModel.gameState.didUserPressedEndTurnButton)
				}
				
				// MARK: Navigation
				
				Section(header: Text("Navigation")) {
					
					Button("Enemy Stats") {
						viewModel.goToEnemyStats()
					}
				}
				
				// MARK: - Testability
				
				Section(header: Text("Testability")) {
					
					Button("Instant Enemy Kill") {
						viewModel.testEnemyExecute()
					}
					
					Button("Restore Hero Combo Points") {
						viewModel.testComboPointsRestoration()
					}
					
					Button("Restore Both Targets Stats") {
						viewModel.restoreStats()
					}
					
					Button("Reset Flask CD") {
						viewModel.testFlaskCDreset()
					}
					
					Button {
						viewModel.toggleCurrentSoulCollectionStatus()
					} label: {
						Text("Toggle current Soul Collection Status (\(viewModel.gameState.hero.flask.currentSoulCollectionStatus.rawValue))")
					}
					
					Button("Refill Soul Collection") {
						viewModel.refillSoulCollection()
					}
					
				}
				
			}
		}
	}
