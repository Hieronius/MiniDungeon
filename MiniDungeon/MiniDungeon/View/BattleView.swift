import SwiftUI

// MARK: - Battle Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildBattle() -> some View {
		
		// MARK: UI
		
		Spacer()
		
		Text(viewModel.gameState.isHeroTurn ? "Hero Turn" : "Enemy Turn")
		
		Spacer()
		
		HStack {
			
			Spacer()
			
			VStack {
				
				Text("HP - \(viewModel.gameState.hero.currentHP) / \(viewModel.gameState.hero.maxHP)")
				Text("MP - \(viewModel.gameState.hero.currentMana) / \(viewModel.gameState.hero.maxMana)")
				Text("EP - \(viewModel.gameState.hero.currentEnergy) / \(viewModel.gameState.hero.maxEnergy)")
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
				
				Text("HP - \(viewModel.gameState.enemy.enemyCurrentHP) / \(viewModel.gameState.enemy.enemyMaxHP)")
				Text("MP - \(viewModel.gameState.enemy.currentMana) / \(viewModel.gameState.enemy.maxMana)")
				Text("EP - \(viewModel.gameState.enemy.currentEnergy) / \(viewModel.gameState.enemy.maxEnergy)")
				ZStack {
					Rectangle()
						.frame(width: 80, height: 80)
						.foregroundColor(Color.black)
						.border(Color.white, width: 5)
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
		
		if viewModel.gameState.isMiniGameOn {
			
			// MARK: Call Mini Game and get it's result
			MiniGameView { success in
				viewModel.gameState.isMiniGameSuccessful = success
				print(success)
				DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
					viewModel.gameState.isMiniGameOn = false
					viewModel.continueAttackAfterMiniGame(success: success)
				}
			}
		}

			List {
				
				Section(header: Text("Actions")) {
					
					Button("Attack (Hit Chance \(viewModel.gameState.hero.hitChance)%)") {
						viewModel.startMiniGame()
					}
					
					Button("Fireball") {
						viewModel.fireball()
					}
					
					Button("Block") {
						viewModel.block()
					}
					
					Button("Heal") {
						viewModel.heal()
					}
					
				}
				
				Section(header: Text("Utility")) {
					
					Button("End Turn") {
						viewModel.endHeroTurn()
					}
					
					Button("Restore Stats") {
						viewModel.restoreStats()
					}
				}
				
				// MARK: Navigation
				
				Section(header: Text("Navigation")) {
					
					Button("Go To Dungeon") {
						viewModel.goToDungeon()
					}
					Button("Go To Hero Stats") {
						viewModel.goToHeroStats()
					}
					Button("Go To Enemy Stats") {
						viewModel.goToEnemyStats()
					}
					Button("Go To Inventory") {
						viewModel.goToInventory()
					}
					Button("Go To Town") {
						viewModel.goToTown()
					}
					Button("Go To Menu") {
						viewModel.goToMenu()
					}
				}
			}
		}
	}
