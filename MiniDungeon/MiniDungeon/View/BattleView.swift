import SwiftUI

// MARK: - Battle Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildBattle() -> some View {
		
		// MARK: UI
		
		Spacer()
		
		Text("Dark Energy: \(viewModel.gameState.heroDarkEnergy)")
		Text(viewModel.gameState.isHeroTurn ? "Hero Turn" : "Enemy Turn")
		
		Spacer()
		
		HStack {
			
			Spacer()
			
			VStack {
				
				Text("HP: \(viewModel.gameState.hero.currentHP) / \(viewModel.gameState.hero.maxHP)")
				Text("MP: \(viewModel.gameState.hero.currentMana) / \(viewModel.gameState.hero.maxMana)")
				Text("EP: \(viewModel.gameState.hero.currentEnergy) / \(viewModel.gameState.hero.maxEnergy)")
				Text("CP: \(viewModel.gameState.comboPoints) / 5")
				ZStack {
					
					Rectangle()
						.frame(width: 80, height: 80)
						.foregroundColor(Color.black)
						.border(Color.white, width: 5)
					Text("Hero")
						.frame(width: 80)
						.multilineTextAlignment(.center)
				}
				Text(viewModel.gameState.didHeroUseBlock ? "Armor ⬆️" : "      ")
			}
			
			Spacer()
			
			VStack {
				
				Text("HP: \(viewModel.gameState.enemy.enemyCurrentHP) / \(viewModel.gameState.enemy.enemyMaxHP)")
				Text("MP: \(viewModel.gameState.enemy.currentMana) / \(viewModel.gameState.enemy.maxMana)")
				Text("EP: \(viewModel.gameState.enemy.currentEnergy) / \(viewModel.gameState.enemy.maxEnergy)")
				Text("EMPTY LINE")
					.foregroundStyle(.background)
				ZStack {
					
					Rectangle()
						.frame(width: 80, height: 80)
						.foregroundColor(Color.black)
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
					
					Button("Attack (Hit Chance \(viewModel.gameState.hero.hitChance)%)") {
						viewModel.startMiniGame()
					}
					
					if viewModel.gameState.comboPoints == 3 {
						Button("Combo (+50% extra damage)") {
							viewModel.comboAttack()
						}
						.foregroundStyle(.orange)
					}
					
					if viewModel.gameState.comboPoints == 4 {
						Button("Combo (Ignore armor + 75% damage)") {
							viewModel.comboAttack()
						}
						.foregroundStyle(.purple)
					}
					
					if viewModel.gameState.comboPoints == 5 {
						Button("Combo (100% crit + 100% damage)") {
							viewModel.comboAttack()
						}
						.foregroundStyle(.red)
					}
					
					Button("Block (Adds \(viewModel.gameState.blockValue) Armor for the turn)") {
						viewModel.block()
					}
					
					Button("Heal (Restores \(viewModel.gameState.hero.spellPower) Heath Points)") {
						viewModel.heal()
					}
					
					Button("End Turn") {
						viewModel.endHeroTurn()
					}
					
				}
				
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
					
				}
				
				// MARK: Navigation
				
				Section(header: Text("Navigation")) {
					
					Button("Enemy Stats") {
						viewModel.goToEnemyStats()
					}
				}
			}
		}
	}
