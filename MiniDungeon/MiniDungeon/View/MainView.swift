import SwiftUI

struct MainView: View {
	
	// MARK: - Dependencies
	
	@StateObject var viewModel: MainViewModel
	
	// MARK: - Initialization
	
	init(viewModel: MainViewModel) {
		_viewModel = StateObject(wrappedValue: viewModel)
	}
	
	// MARK: - Body
	
    var body: some View {
        
		switch viewModel.gameScreen {
			
		case .menu:
			
			buildMenu()
			
		case .battle:
			
			buildBattle()
			
		case .dungeon:
			
			buildDungeon()
		
		case .town:
			
			buildTown()
		}
    }
}

// MARK: - Menu Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildMenu() -> some View {
		
		List {
			
			Section(header: Text("It's a Menu")) {
				
				Button("Go To Battle") {
					viewModel.goToBattle()
				}
				Button("Go To Dungeon") {
					viewModel.goToDungeon()
				}
				Button("Go To Town") {
					viewModel.goToTown()
				}
			}
		}
	}
}

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
				
				Text("HP - \(viewModel.gameState.hero.heroCurrentHP) / \(viewModel.gameState.hero.heroMaxHP)")
				Text("MP - \(viewModel.gameState.hero.currentMana) / \(viewModel.gameState.hero.maxMana)")
				Text("EP - \(viewModel.gameState.hero.currentEnergy) / \(viewModel.gameState.hero.maxEnergy)")
				Rectangle()
					.frame(width: 80, height: 80)
			}
			
			Spacer()
			
			VStack {
				
				Text("HP - \(viewModel.gameState.enemy.enemyCurrentHP) / \(viewModel.gameState.enemy.enemyMaxHP)")
				Text("MP - \(viewModel.gameState.enemy.currentMana) / \(viewModel.gameState.enemy.maxMana)")
				Text("EP - \(viewModel.gameState.enemy.currentEnergy) / \(viewModel.gameState.enemy.maxEnergy)")
				Rectangle()
					.frame(width: 80, height: 80)
			}
			
			Spacer()
		}
		
		Spacer()
		
		// MARK: Actions
		
		List {
			
			Section(header: Text("Actions")) {
				
				Button("Attack") {
					viewModel.attack()
				}
				
				Button("Block") {
					
				}
				
				Button("Heal") {
					
				}
				
			}
			
			Section(header: Text("Utility")) {
				
				Button("End Turn") {
					viewModel.endTurn()
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

// MARK: - Dungeon Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildDungeon() -> some View {
		
		Spacer()
		
		VStack {
			
			HStack {
				
				Spacer()
				Text("Battles won - \(viewModel.gameState.battlesWon)")
				Spacer()
				Text("Gold - \(viewModel.gameState.heroGold)")
				Spacer()
			}
			
			HStack {
				
				Spacer()
				Text("Hero's lvl - \(viewModel.gameState.hero.heroLevel)")
				Spacer()
				Text("XP - \(viewModel.gameState.heroCurrentXP) / \(viewModel.gameState.heroMaxXP)")
				Spacer()
			}
		}
		
		Spacer()
		
		Spacer()
		
		getDungeonMap()
		
		Spacer()
		
		List {
			
			Section(header: Text("Navigation")) {
				
				Button("Go To Battle") {
					viewModel.goToBattle()
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
	
	// MARK: Get Dungeon Map

	@ViewBuilder
	func getDungeonMap() -> some View {

		VStack {

			ForEach(viewModel.gameState.dungeonMap.indices, id: \.self) { row in

				HStack {

					ForEach(viewModel.gameState.dungeonMap[row].indices, id: \.self) { col in

						let tile = viewModel.gameState.dungeonMap[row][col]

						getTileButton(tile: tile) {

							viewModel.handleTappedDirection(row, col)

							print("taped the tile")

						}
					}
				}
			}
		}
	}

	// TODO: Transform to struct TileView
	// MARK: Tile Button View

	func getTileButton(tile: Tile, action: @escaping () -> Void) -> some View {

		// If starting point is empty it should not be the starting point

		let originalBackgroundColor: Color = tile.isExplored ? .gray : .white
		let isHeroPosition = tile.isHeroPosition(viewModel.gameState.heroPosition)
		let tileColor: Color = isHeroPosition ? .orange : originalBackgroundColor
		var title: String
		var opacityRatio: CGFloat = 1.0

		// Just turn this property to 0 for complete hidden state of the button

		if tile.type == .empty { opacityRatio = 0.1 }

		switch tile.type {
		case .room:
			title = "R"
		case .corridor:
			title = "C"
		case .empty:
			title = "E"
		}

		return Button(title, action: action)
			.frame(width: 50, height: 50)
			.buttonStyle(.bordered)
			.font(.title2)
			.foregroundColor(tileColor)
			.opacity(opacityRatio)
	}
}

// MARK: - Town Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildTown() -> some View {
		
		List {
			
			Section(header: Text("Town")) {
				Text("Available Skill Points - \(viewModel.gameState.hero.skillPoints)")
				Text("Hero's Gold - \(viewModel.gameState.heroGold)")
			}
			
			Section(header: Text("Training Center")) {
				
				Button("Upgrade Damage - 10G") {
					viewModel.gameState.hero.upgradeDamage()
					viewModel.gameState.heroGold -= 10
				}
				Button("Upgrade Health - 10G") {
					viewModel.gameState.hero.upgradeHP()
					viewModel.gameState.heroGold -= 10
				}
				Button("Upgrade Defence - 10G") {
					viewModel.gameState.hero.upgradeDefence()
					// gold probably should be in Hero struct
					viewModel.gameState.heroGold -= 10
				}
			}
			
			Section(header: Text("Market")) {
				
				Button("Buy Health Potion") {
					//
				}
				Button("Buy Steal Sword") {
					//
				}
			}
			
			Section(header: Text("Navigation")) {
				
				Button("Go To Battle") {
					viewModel.goToBattle()
				}
				Button("Go To Dungeon") {
					viewModel.goToDungeon()
				}
				Button("Go To Menu") {
					viewModel.goToMenu()
				}
			}
		}
	}
}

