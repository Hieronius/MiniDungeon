import SwiftUI

// MARK: - Dungeon Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildDungeonView() -> some View {
		
		Spacer()
		
		VStack {
			
			HStack {
				Spacer()
				Text("Dungeon Level: \(viewModel.gameState.currentDungeonLevel + 1)")
				Spacer()
				Text("Battles won: \(viewModel.gameState.battlesWon)")
				Spacer()
			}
			
			HStack {
				
				Spacer()
				Text("Dark Energy: \(viewModel.gameState.heroDarkEnergy)")
				Spacer()
				Text("Gold: \(viewModel.gameState.heroGold)")
				Spacer()
			}
			
			HStack {
				
				Spacer()
				Text("Hero lvl: \(viewModel.gameState.hero.heroLevel)")
				Spacer()
				Text("Hero XP: \(viewModel.gameState.hero.currentXP)/\(viewModel.gameState.hero.maxXP)")
				Spacer()
			}
			
			HStack {
				Spacer()
				Text("HP: \(viewModel.gameState.hero.currentHP)/\(viewModel.gameState.hero.maxHP)")
				Spacer()
				Text("MP: \(viewModel.gameState.hero.currentMana)/\(viewModel.gameState.hero.maxMana)")
				Spacer()
			}
			
			HStack {
				Spacer()
				Text("Rooms explored: \(viewModel.countMapRooms().0)/\(viewModel.countMapRooms().1)")
				Spacer()
				Text("Flask XP: \(viewModel.gameState.hero.flask.currentXP)/\(viewModel.gameState.hero.flask.expToLevelUP)")
				Spacer()
			}
			buildShadowFlaskView()
			
		}
		
		Spacer()
		
		Spacer()
		
		// MARK: Trap Defusion Mini Game With Outcome
		
		if viewModel.gameState.isTrapDefusionMiniGameIsOn {
			
			TrapDefusionMiniGameView { success in
				// this property seems to be duplicated
				viewModel.gameState.isTrapDefusionMiniGameSuccessful = success
				print(success)
				// TODO: Probably should be inside the method in ViewModel
				DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
					viewModel.gameState.isTrapDefusionMiniGameIsOn = false
					viewModel.calculateTrapDefusionResult(success)
					viewModel.gameState.didEncounterTrap = false
					
					// place to erase tile character to "" to reflect that an event has been completed
					let position = viewModel.gameState.heroPosition
//					viewModel.gameState.dungeonMap[position.row][position.col].events = []
					viewModel.gameState.dungeonMap[position.row][position.col].type = .corridor
					
					// with this one
					viewModel.gameState.didTrapDefusionIsSuccess = success
					viewModel.goToRewards()
					
					
				}
			}
		
		// MARK: Lock Picking Mini Game
			
		} else if viewModel.gameState.isLockPickingMiniGameIsOn {
			
			ChestLockPickingMiniGameView { success in
				// this property seems to be duplicated
				viewModel.gameState.isLockPickingMiniGameIsSuccess = success
				print(success)
				// TODO: Probably should be inside the method in ViewModel
				DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
					viewModel.gameState.isLockPickingMiniGameIsOn = false
					viewModel.calculateChestLockPickingResult(success)
					viewModel.gameState.didEncounterChest = false
					// with this one
					viewModel.gameState.didChestLockPickingIsSuccess = success
					
					// place to erase tile character to "" to reflect that an event has been completed
					let position = viewModel.gameState.heroPosition
//					viewModel.gameState.dungeonMap[position.row][position.col].events = []
					viewModel.gameState.dungeonMap[position.row][position.col].type = .corridor
					
				}
			}
			
			 
		// MARK: Dungeon Map
			 
		} else if !(viewModel.gameState.isTrapDefusionMiniGameIsOn || viewModel.gameState.isLockPickingMiniGameIsOn ||
					viewModel.gameState.isHeroStatsScreenOpen ||
					viewModel.gameState.isInventoryScreenOpen) {
		 	getDungeonMap()
			
		}
		
		Spacer()
		
		List {
			
			// MARK: Actions
			
			// if encountered any type of events such as a trap or shrine
			
			if viewModel.gameState.didEncounterTrap && !viewModel.gameState.isTrapDefusionMiniGameIsOn || viewModel.gameState.didEncounterRestorationShrine || viewModel.gameState.didEncounterDisenchantShrine || viewModel.gameState.didEncounterChest {
				
				Section(header: Text("Actions")) {
					
					// MARK: Trap Actions
					
					if viewModel.gameState.didEncounterTrap && !viewModel.gameState.isTrapDefusionMiniGameIsOn {
						
						Button("Inspect the Trap") {
							viewModel.startTrapDefusionMiniGame()
						}
						.foregroundStyle(.orange)
						
					// MARK: Restoration Shrine Actions
						
					} else if viewModel.gameState.didEncounterRestorationShrine &&  !viewModel.gameState.dealtWithRestorationShrine {
						
						Button("Get Health and Mana Restoration") {
							viewModel.applyEffect(for: .restoreHealthManaWithSmallChanceToGetDamage, item: nil)
						}
						.foregroundStyle(.orange)
						
						Button("Get Shadow Flask Charge") {
							viewModel.applyEffect(for: .getFlaskCharge, item: nil)
						}
						.foregroundStyle(.orange)
						
					// MARK: Disenchant Shrine Actions
						
					} else if viewModel.gameState.didEncounterDisenchantShrine && !viewModel.gameState.dealtWithDisenchantShrine {
						
						Button("Disenchant an Item") {
							viewModel.goToInventory()
						}
						.foregroundStyle(.orange)
						
					// MARK: Chest Tile Actions
						
					} else if viewModel.gameState.didEncounterChest && !viewModel.gameState.dealthWithChest {
						
						Button("Lock-pick the Chest") {
							viewModel.applyEffect(for: .lockPickChest, item: nil)
							// viewModel.lockPickChest() -> LockPickingView()
						}
						.foregroundStyle(.orange)
						
						// add amount of keys in inventory like "(keys: 5)"
						Button("Unlock with key (\(viewModel.displayKeys()))") {
							viewModel.applyEffect(for: .unlockChestWithKey, item: nil)
							
						}
						.foregroundStyle(.orange)
					}
					
				}
			}
			
			// MARK: Navigation
			
			Section(header: Text("Navigation")) {
				
				// if hero has negative HP
				if viewModel.gameState.hero.currentHP <= 0 {
					Button("You are dead -> Start New Game") {
						viewModel.setupNewGame()
					}
					.foregroundStyle(.red)
				}
				
				if viewModel.countMapRooms().0 == viewModel.countMapRooms().1 {
					Button("Summon Level Boss") {
						viewModel.summonBoss()
					}
					.foregroundStyle(.purple)
				}
				
				Button("Stats") {
					viewModel.goToHeroStats()
				}
				Button("Inventory") {
					viewModel.goToInventory()
				}
			}
		}
	}
	
	// MARK: Get Dungeon Map

	@ViewBuilder
	func getDungeonMap() -> some View {

		VStack(spacing: 20) {

			ForEach(viewModel.gameState.dungeonMap.indices, id: \.self) { row in

				HStack(spacing: 20) {

					ForEach(viewModel.gameState.dungeonMap[row].indices, id: \.self) { col in

						let tile = viewModel.gameState.dungeonMap[row][col]

						getTileButton(tile: tile) {
							
							// Junk code to be sure that you handle tapped tile and remove it from the grid to avoid tapping tiles too far from the hero

							viewModel.handleTappedDirection(row, col)
							viewModel.gameState.tappedTile = tile
							
							DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
								self.viewModel.gameState.tappedTile = Tile(coordinate: Coordinate(row: 998, col: 998), type: .empty, isExplored: false, events: [.empty])
								self.viewModel.gameState.tappedTilePosition = Coordinate(row: 999, col: 999)
							}

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
		let neighbours = viewModel.checkForHeroTileNeighbours(includeDiagonals: false)
		let tileColor: Color = isHeroPosition ? .orange : originalBackgroundColor
		var title: String
		var opacityRatio: CGFloat = 1.0
		let wasTapped = tile.wasTapped
		
		// MARK: Just comment all checks to manage map generation

		
		// 1. If not a hero Position and is not explored - create the fog of war

		if isHeroPosition == false && tile.isExplored == false  { opacityRatio = 0.01 }
		
		
		// 2. Hero can see through a single tile around him
		
		if neighbours.contains(tile) {
			opacityRatio = 1.0
		}
		
		// 3. If Tile being explored display it's type
		
		if tile.isExplored {
			
			switch tile.type {
			case .room: title = "R"
			case .corridor: title = ""
			case .chest: title = "L"
			case .trap: title = "T"
			case .restoration: title = "H"
			case .empty: title = "E"
			case .disenchant: title = "D"
			default: title = ""
			}
			
			// Otherwise keep it hidden
			
		} else {
			title = "?"
		}
		
		// 4. For empty tiles provide full opacity but if player encounter secret by tapping on non explored empty tile highlight it a little
		
		if tile.type == .empty && !tile.events.contains(.secret) {
			opacityRatio = 0.01
			
		} else if tile.type == .empty && tile.events.contains(.secret) {
			opacityRatio = 0.5
			title = "S"
		}
		
		return Button(action: action) {
			Text(title == "" ? (isHeroPosition ? "M" : "") : title)
				.frame(width: 15, height: 25) // Fixes internal content size
				.font(wasTapped ? .none : .title2)
		}
		.buttonStyle(.bordered)
		.font(wasTapped ? .none : .title2)
		.foregroundColor(tileColor)
		.opacity(viewModel.gameState.tappedTile == tile && neighbours.contains(tile) ? 0.5 : opacityRatio)
	}
}
