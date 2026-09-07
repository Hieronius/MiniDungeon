import SwiftUI

// MARK: - Battle Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildBattleView() -> some View {
		
		// MARK: - UI
		
		
		// Main Stack to include an entire battle screen
		VStack {
			
			VStack {
				
				if viewModel.gameState.didFindFlask {
					
					HStack {
						
						Spacer()
						
						buildShadowFlaskView()
						
						VStack {
							Text("\(viewModel.localizeFlaskSoulCollectionStatus(status: viewModel.gameState.hero.flask.currentSoulCollectionStatus)): \(viewModel.gameState.hero.flask.currentCombatImpactValue)/\(viewModel.gameState.hero.flask.currentCombatImpactCapacity)")
							
							ProgressView(
								value: Double(viewModel.gameState.hero.flask.currentCombatImpactValue),
								total: Double(viewModel.gameState.hero.flask.currentCombatImpactCapacity)
							)
							.frame(width: 200)
							.tint(viewModel.gameState.hero.flask.flaskIsCollectingCombatImpact ? .white : .yellow)
							if isEnglish() {
								Text(viewModel.gameState.hero.flask.flaskIsReadyToUnleashImpact ? "Flask is ready to unleash!" : "                 ")
								
							} else {
								
								Text(viewModel.gameState.hero.flask.flaskIsReadyToUnleashImpact ? "Фляга готова к действию!" : "                 ")
							}
							
						}
						Spacer()
					}
				}
			}
			
			HStack {
				
				Spacer()
				
				// MARK: - HERO UI
				
				VStack {
					
					if isEnglish() {
						
						Text("HP: \(viewModel.gameState.hero.currentHP) / \(viewModel.gameState.hero.maxHP)")
						Text("MP: \(viewModel.gameState.hero.currentMana) / \(viewModel.gameState.hero.maxMana)")
						Text("EP: \(viewModel.gameState.hero.currentEnergy) / \(viewModel.gameState.hero.maxEnergy)")
						Text("CP: \(viewModel.gameState.comboPoints) / 5")
						ZStack {
							
							Rectangle()
								.frame(width: 130, height: 130)
								.foregroundColor(viewModel.gameState.currentHeroAnimation.color)
								.border(Color.white, width: 5)
							Image("hero1")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 120, height: 120)
						}
						Text(viewModel.gameState.didHeroUseBlock ? "Armor ⬆️" : "      ")
						
					} else {
						
						Text("Здоровье: \(viewModel.gameState.hero.currentHP) / \(viewModel.gameState.hero.maxHP)")
						Text("Мана: \(viewModel.gameState.hero.currentMana) / \(viewModel.gameState.hero.maxMana)")
						Text("Энергия: \(viewModel.gameState.hero.currentEnergy) / \(viewModel.gameState.hero.maxEnergy)")
						Text("Комбо: \(viewModel.gameState.comboPoints) / 5")
						
						ZStack {
							
							Rectangle()
								.frame(width: 130, height: 130)
								.foregroundColor(viewModel.gameState.currentHeroAnimation.color)
								.border(Color.white, width: 5)
							Image("hero1")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 120, height: 120)
						}
						Text(viewModel.gameState.didHeroUseBlock ? "Броня ⬆️" : "      ")
					}
					
				}
				
				Spacer()
				
				// MARK: - ENEMY UI
				
				VStack {
					
					if isEnglish() {
						
						Text("HP: \(viewModel.gameState.enemy.currentHP) / \(viewModel.gameState.enemy.maxHP)")
						Text("MP: \(viewModel.gameState.enemy.currentMP) / \(viewModel.gameState.enemy.maxMana)")
						Text("EP: \(viewModel.gameState.enemy.currentEnergy) / \(viewModel.gameState.enemy.maxEnergy)")
						Text("IN ACTION")
							.foregroundStyle(viewModel.gameState.isActionInProgress ? .blue : .black)
						ZStack {
							
							Rectangle()
								.frame(width: 130, height: 130)
								.foregroundColor(viewModel.gameState.currentEnemyAnimation.color)
								.border(Color.white, width: 5)
							Image(viewModel.gameState.enemy.imageName)
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 120, height: 120)
						}
						.offset(y: viewModel.gameState.didEnemyReceivedComboAttack ? 10 : 0)
						.animation(
							Animation.linear(duration: 0.1)
								.repeatCount(3, autoreverses: true),
							value: viewModel.gameState.didEnemyReceivedComboAttack
						)
						
						Text(viewModel.gameState.didEnemyUseBlock ? "Armor ⬆️" : "      ")
						
					} else {
						
						Text("Здоровье: \(viewModel.gameState.enemy.currentHP) / \(viewModel.gameState.enemy.maxHP)")
						Text("Мана: \(viewModel.gameState.enemy.currentMP) / \(viewModel.gameState.enemy.maxMana)")
						Text("Энергия: \(viewModel.gameState.enemy.currentEnergy) / \(viewModel.gameState.enemy.maxEnergy)")
						Text("В ДЕЙСТВИИ")
							.foregroundStyle(viewModel.gameState.isActionInProgress ? .blue : .black)
						ZStack {
							
							ZStack {
								
								Rectangle()
									.frame(width: 130, height: 130)
									.foregroundColor(viewModel.gameState.currentEnemyAnimation.color)
									.border(Color.white, width: 5)
								Image(viewModel.gameState.enemy.imageName)
									.resizable()
									.aspectRatio(contentMode: .fit)
									.frame(width: 120, height: 120)
							}
							.offset(y: viewModel.gameState.didEnemyReceivedComboAttack ? 10 : 0)
							.animation(
								Animation.linear(duration: 0.1)
									.repeatCount(3, autoreverses: true),
								value: viewModel.gameState.didEnemyReceivedComboAttack
							)
						}
						Text(viewModel.gameState.didEnemyUseBlock ? "Броня ⬆️" : "      ")
					}
				}
				
				// MARK: - Test Pause Action
				
				.onTapGesture {
					
					viewModel.gameState.isGamePaused.toggle()
				}
				
				Spacer()
				
			}
			.overlay(alignment: .center) {
				
				// MARK: BEWARE label
				
				if viewModel.gameState.isBewareLabelVisiable {
					Text(isEnglish() ? "BEWARE!" : "ВНИМАНИЕ!")
						.foregroundStyle(.red)
						.frame(width: 250, height: 100)
						.border(.white, width: 5)
						.background(.black)
						.font(.largeTitle)
				}
			}
			
			Text(viewModel.gameState.logMessage)
			
			Spacer()
			
			// MARK: - CoinFlipMiniGame
			
			// In the code below you see a view construction with passing a closure to get it's onGameEnd property back to deal with.
			// THIS CLOSURE IS THE BRIDGE BETWEEN GAME RESULT AND OUTCOME IN BATTLE VIEW
			
			if viewModel.gameState.isCoinFlipMiniGameOn {
				CoinFlipMiniGameView(
					isEnglish: isEnglish(),
					heroChanceForFirstTurn: viewModel.gameState.hero.currentChanceStartTurnFirst
				) { result in
					viewModel.handleCoinFlipMiniGameResult(for: result)
				}
			}
			
			// MARK: DamageBoostMiniGame
			
			if viewModel.gameState.isDamageBoostMiniGameOn {
				
				DamageBoostMiniGameView(
					isEnglish: isEnglish(),
					isGamePaused: isGamePaused()
				) { result in
					viewModel.processDamageBoostMiniGameOutcome(result: result)
				}
			}
			
			// MARK: EvasionMiniGame
			
			if viewModel.gameState.isEvasionMiniGameOn {
				
				EvasionMiniGameView(
					isEnglish: isEnglish(),
					isGamePaused: isGamePaused()
				) { result in
					viewModel.handleEvasionMiniGameResult(for: result)
				}
			}
			
			// MARK: ShadowBallMiniGame
			
			if viewModel.gameState.isShadowBallMiniGameOn {
				
				ShadowBallMiniGameView(
					isEnglish: isEnglish(),
					gameState: viewModel.gameState,
					
					onImpact: { result in
						viewModel.handleShadowMiniGameImpact(for: result)
					},
					
					didGameEnd: { gameEnd in  // true if all 10 resisted?
						viewModel.gameState.isShadowBallMiniGameOn = false
						viewModel.winLoseCondition()
					}
				)
			}
			
			List {
				
				// MARK: - Actions
				
				Section(header: Text(isEnglish() ? "Actions" : "Действия")) {
					
					if isEnglish() {
						
						Button(viewModel.gameState.didUseFlaskEmpowerForOffensive ? "Attack (Damage \(viewModel.gameState.hero.minDamage)-\(viewModel.gameState.hero.maxDamage), Hit \(viewModel.gameState.hero.hitChance)%, Crit \(viewModel.gameState.hero.critChance)%, cost 1 EP) Empowered" : "Attack (Damage \(viewModel.gameState.hero.minDamage)-\(viewModel.gameState.hero.maxDamage), Hit \(viewModel.gameState.hero.hitChance)%, Crit \(viewModel.gameState.hero.critChance)%, cost 1 EP)") {
							viewModel.startCombatMiniGame()
						}
						.foregroundStyle(
							viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? (viewModel.gameState.didUseFlaskEmpowerForOffensive ? .purple : .blue) : (.gray))
						
					} else {
						
						Button(viewModel.gameState.didUseFlaskEmpowerForOffensive ? "Атака (Урон \(viewModel.gameState.hero.minDamage)-\(viewModel.gameState.hero.maxDamage), Попадение \(viewModel.gameState.hero.hitChance)%, Крит \(viewModel.gameState.hero.critChance)%, стоимость 1 очко энергии) Усиление" : "Атака (Урон \(viewModel.gameState.hero.minDamage)-\(viewModel.gameState.hero.maxDamage), Попадение \(viewModel.gameState.hero.hitChance)%, Крит \(viewModel.gameState.hero.critChance)%, стоимость 1 очко энергии)") {
							viewModel.startCombatMiniGame()
						}
						.foregroundStyle(
							viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? (viewModel.gameState.didUseFlaskEmpowerForOffensive ? .purple : .blue) : (.gray))
					}
					
					// MARK: - Combo Section Starts Here
					
					if isEnglish() {
						
						if viewModel.gameState.comboPoints == 3 {
							
							Button("Combo (Deal 150% damage)") {
								viewModel.comboAttack()
							}
							
							.foregroundStyle(viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? .orange : .gray)
						}
						
						if viewModel.gameState.comboPoints == 4 {
							Button("Combo (Deal 175% damage + Armor Penetration)") {
								viewModel.comboAttack()
							}
							.foregroundStyle(viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? .purple : .gray)
						}
						
						if viewModel.gameState.comboPoints == 5 {
							Button("Combo (Deal 300% damage + Armor Penetration)") {
								viewModel.comboAttack()
							}
							.foregroundStyle(viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? .red : .gray)
						}
						
					} else {
						
						if viewModel.gameState.comboPoints == 3 {
							
							Button("Комбо (Нанести 150% урона)") {
								viewModel.comboAttack()
							}
							
							.foregroundStyle(viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? .orange : .gray)
						}
						
						if viewModel.gameState.comboPoints == 4 {
							Button("Комбо (Нанести 175% урона + Пробивание Брони)") {
								viewModel.comboAttack()
							}
							.foregroundStyle(viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? .purple : .gray)
						}
						
						if viewModel.gameState.comboPoints == 5 {
							Button("Комбо (Нанести 300% урона + Пробивание Брони)") {
								viewModel.comboAttack()
							}
							.foregroundStyle(viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? .red : .gray)
						}
					}
					
					// MARK: Combo Section End Here
					
					if isEnglish() {
						
						Button(viewModel.gameState.didUseFlaskEmpowerForDefensive ? "Block (add \(viewModel.gameState.minBlockValue)-\(viewModel.gameState.maxBlockValue) defence for turn, cost 1 EP) Empowered" : "Block (add \(viewModel.gameState.minBlockValue)-\(viewModel.gameState.maxBlockValue) defence for turn, cost 1 EP)") {
							viewModel.block()
						}
						.foregroundStyle(
							viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? (viewModel.gameState.didUseFlaskEmpowerForDefensive ? .orange : .blue) : (.gray))
						
					} else {
						
						Button(viewModel.gameState.didUseFlaskEmpowerForDefensive ? "Блок (добавить \(viewModel.gameState.minBlockValue)-\(viewModel.gameState.maxBlockValue) брони на ход, стоимость 1 очко энергии) Усиление" : "Блок (добавить \(viewModel.gameState.minBlockValue)-\(viewModel.gameState.maxBlockValue) брони на ход, стоимость 1 очко энергии)") {
							viewModel.block()
						}
						.foregroundStyle(
							viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? (viewModel.gameState.didUseFlaskEmpowerForDefensive ? .orange : .blue) : (.gray))
					}
					
					if isEnglish() {
						
						Button(viewModel.gameState.didUseFlaskEmpowerForDefensive ? "Heal (\(viewModel.gameState.healMinValue + viewModel.gameState.hero.spellPower)-\(viewModel.gameState.healMaxValue + viewModel.gameState.hero.spellPower) HP, cost 10 MP) Empowered" : "Heal (\(viewModel.gameState.healMinValue + viewModel.gameState.hero.spellPower)-\(viewModel.gameState.healMaxValue + viewModel.gameState.hero.spellPower) HP, cost 10 MP)") {
							viewModel.heal()
						}
						.foregroundStyle(
							viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? (viewModel.gameState.didUseFlaskEmpowerForDefensive ? .orange : .blue) : (.gray))
						
					} else {
						
						Button(viewModel.gameState.didUseFlaskEmpowerForDefensive ? "Лечение (\(viewModel.gameState.healMinValue + viewModel.gameState.hero.spellPower)-\(viewModel.gameState.healMaxValue + viewModel.gameState.hero.spellPower) здоровья, стоимость \(viewModel.gameState.spellManaCost) маны) Усиление" : "Лечение (\(viewModel.gameState.healMinValue + viewModel.gameState.hero.spellPower)-\(viewModel.gameState.healMaxValue + viewModel.gameState.hero.spellPower) здоровья, стоимость \(viewModel.gameState.spellManaCost) маны)") {
							viewModel.heal()
						}
						.foregroundStyle(
							viewModel.gameState.hero.currentEnergy > 0 && viewModel.gameState.isHeroTurn ? (viewModel.gameState.didUseFlaskEmpowerForDefensive ? .orange : .blue) : (.gray))
						
					}
					
					// MARK: Flask
					
					if isEnglish() {
						
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
						
					} else {
						
						if viewModel.gameState.didFindFlask {
							
							if viewModel.gameState.hero.flask.actionsToResetCD == 0 {
								
								Button(viewModel.gameState.hero.flask.battleMode == .defensive ? "Исцелиться на \(viewModel.gameState.hero.flask.currentHealingValueInPercent)% от максимального здоровья. Заряды (\(viewModel.gameState.hero.flask.currentCharges)/\(viewModel.gameState.hero.flask.currentMaxCharges))" : "Нанести урон на \(viewModel.gameState.hero.flask.currentDamageValueInPercent)% от максимального здоровья противника. Заряды (\(viewModel.gameState.hero.flask.currentCharges)/\(viewModel.gameState.hero.flask.currentMaxCharges))") {
									
									viewModel.useFlaskInBattlePipeline()
								}
								.foregroundColor(viewModel.gameState.hero.flask.currentCharges > 0 && viewModel.gameState.isHeroTurn && viewModel.gameState.hero.flask.actionsToResetCD == 0 ? (viewModel.gameState.hero.flask.battleMode == .defensive ? .green : .red) : .gray)
								.opacity(0.75)
								
							} else {
								
								Text("Ходы до восстановления способностей фляги: \(viewModel.gameState.hero.flask.actionsToResetCD)/\(viewModel.gameState.hero.flask.currentCooldown)")
									.foregroundColor(.gray)
							}
							
							if viewModel.gameState.isHeroTurn && viewModel.gameState.hero.flask.flaskIsReadyToUnleashImpact {
								
								Button(viewModel.gameState.hero.flask.battleMode == .offensive ? "Высвободить эффект (получить 1 очко действий)" : "Высвободить эффект (получить темную энергию)") {
									
									viewModel.unleashFlaskImpactEffect()
								}
								.foregroundStyle(viewModel.gameState.hero.flask.battleMode == .offensive ? .red : .green)
								.opacity(0.75)
							}
						}
					}
					
					// MARK: End Turn
					
					
					Button(isEnglish() ? "End Turn" : "Завершить ход") {
						viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
						viewModel.endHeroTurn()
					}
					.foregroundStyle(viewModel.gameState.isHeroTurn ? .blue : .gray)
				}
				
				// MARK: Navigation
				
				Section(header: Text(isEnglish() ? "Navigation" : "Навигация")) {
					
					Button(isEnglish() ? "Enemy Stats" : "Характеристики противника") {
						viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
						viewModel.goToEnemyStats()
					}
					
					// How to fight Alert Controller
					
					if !viewModel.gameState.didEndDemoLevel {
						Button(isEnglish() ? "How to fight Info" : "О боевке") {
							viewModel.audioManager.playSound(fileName: "openInfo", extensionName: "mp3")
							isCombatInfoAlertOpen = true
						}
						
						.alert(isEnglish() ? "Combat" : "Бой",
							   isPresented: $isCombatInfoAlertOpen) {
							
							Button(isEnglish() ? "Got it" : "Понятно", role: .cancel) {
								viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
								isCombatInfoAlertOpen = false
							}
						} message: {
							if isEnglish() {
								
								Text("""
 You and enemy will act in turns.		
 You have EP (Energy Points), each action usually costs 1 EP.					
 By hitting enemy with Attack button multiple times you will get CP (Combo Points).								
 After getting 3+ you will be able to commit a powerful strike with different effects.
 """)
								
							} else {
								
								Text("""
 Вы и противник будете ходить по очереди.
 Очередность определяется броском монетки (50%).
 Способности требуют энергии для использования.
 При попадении обычной атакой по цели вы получаете комбо очки.
 При наборе 3 и более комбо очков появится возможность нанести усиленную атаку с разными эффектами.
 """)
							}
						}
					}
				}
				
				// MARK: - Testability
				
				Section(header: Text(isEnglish() ? "Testability" : "Тестирование")) {
					
					Button(isEnglish() ? "Instant Enemy Kill" : "Уничтожить врага") {
						viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
						viewModel.testEnemyExecute()
					}
					
					Button(isEnglish() ? "Restore Hero Combo Points" : "Получить 5 комбо очков") {
						viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
						viewModel.testComboPointsRestoration()
					}
					
					Button(isEnglish() ? "Restore Both Targets Stats" : "Исцелить героя и противника") {
						viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
						viewModel.restoreStats()
					}
					
					if viewModel.gameState.didFindFlask {
						
						Button(isEnglish() ? "Reset Flask CD" : "Сбросить время восстановления способностей фляги") {
							viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
							viewModel.testFlaskCDreset()
						}
						
						Button {
							viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
							viewModel.toggleCurrentSoulCollectionStatus()
						} label: {
							if isEnglish() {
								
								Text("Toggle current Soul Collection Status (\(viewModel.gameState.hero.flask.currentSoulCollectionStatus.rawValue))")
							} else {
								
								Text("Переключить текущий статус сбора душ \(viewModel.localizeFlaskSoulCollectionStatus(status: viewModel.gameState.hero.flask.currentSoulCollectionStatus))")
							}
						}
						
						Button(isEnglish() ? "Refill Soul Collection" : "Заполнить хранилище душ") {
							viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
							viewModel.refillSoulCollection()
						}
					}
					
				}
				
			}
			.disabled(!viewModel.gameState.isHeroTurn || viewModel.gameState.isGamePaused)
		}
//		.opacity(viewModel.gameState.isGamePaused ? 0.5 : 1.0)
	}
	}
