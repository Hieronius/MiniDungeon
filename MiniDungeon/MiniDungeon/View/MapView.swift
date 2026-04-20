import SwiftUI

// MARK: - Dungeon Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildDungeonView() -> some View {
		
		VStack {
			
			HStack {
				Spacer()
				Text("Dungeon Level: \(viewModel.gameState.currentDungeonLevel)")
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
				
				if viewModel.gameState.didFindFlask {
					Text("Flask XP: \(viewModel.gameState.hero.flask.currentXP)/\(viewModel.gameState.hero.flask.expToLevelUP)")
				}
				Spacer()
			}
			
			// MARK: Flask View (YOU WORK HERE)
			// A little height of the flask ruins an entire dungeon layout
			
//			Rectangle()
//				.fill(Color.clear)
//				.frame(height: 1)
//			
//			if viewModel.gameState.didFindFlask {
//				buildShadowFlaskView()
//			}
			
		}
		
		Spacer()
		
		// MARK: Trap Defusion Mini Game With Outcome
		
		if viewModel.gameState.isTrapDefusionMiniGameIsOn {
			
			TrapDefusionMiniGameView(audioManager: viewModel.audioManager) { success in
				viewModel.handleTrapDefusionMiniGameResult(success)
			}
			
			// MARK: Chest Lock Picking Mini Game
			
		} else if viewModel.gameState.isLockPickingMiniGameIsOn {
			
			ChestLockPickingMiniGameView(audioManager: viewModel.audioManager) { lockPickingResult in
				viewModel.handleChestLockPickingMiniGameResult(lockPickingResult)
			}
			
			// MARK: Dungeon Map
			
		} else if !(viewModel.gameState.isTrapDefusionMiniGameIsOn || viewModel.gameState.isLockPickingMiniGameIsOn ||
					viewModel.gameState.isHeroStatsScreenOpen ||
					viewModel.gameState.isInventoryScreenOpen) {
			
			getDungeonMap()
				.frame(width: UIScreen.main.bounds.width)
			
			// MARK: Flask View via Overlay
				.overlay(alignment: .top) {
					
					HStack {
						
						Rectangle()
							.fill(Color.clear)
							.frame(height: 1)
						
						if viewModel.gameState.didFindFlask && viewModel.gameState.isFlaskViewOpen {
							buildShadowFlaskView()
						}
						Spacer()
						Spacer()
						Spacer()
					}
				}
			
		}
		
		// MARK: Navigation/Movement bars
		
		HStack() {
			
			Button(
				action: {
					viewModel.gameState.isNavigationOpen = true
				}, label: {
					Text("Navigation")
						.font(viewModel.gameState.isNavigationOpen ? .title2 : .body)
						.frame(width: 125, height: 35)
						.foregroundStyle(viewModel.gameState.isNavigationOpen ? .white : .gray)
						.backgroundStyle(.black)
						.border(viewModel.gameState.isNavigationOpen ? .white : .gray, width: 3)
					
				}
			)
			
			Button(
				action: {
					viewModel.gameState.isNavigationOpen = false
				}, label: {
					Text("Movement")
						.font(!viewModel.gameState.isNavigationOpen ? .title2 : .body)
						.frame(width: 125, height: 35)
						.foregroundStyle(!viewModel.gameState.isNavigationOpen ? .white : .gray)
						.backgroundStyle(.black)
						.border(!viewModel.gameState.isNavigationOpen ? .white : .gray, width: 3)
					
				}
			)
		}
		
		if viewModel.gameState.isNavigationOpen {
		
		List {
			
			// MARK: Actions
			
				// if encountered any type of events such as a trap or shrine
				
				if viewModel.gameState.didEncounterTrap && !viewModel.gameState.isTrapDefusionMiniGameIsOn || viewModel.gameState.didEncounterRestorationShrine || viewModel.gameState.didEncounterDisenchantShrine || viewModel.gameState.didEncounterChest ||
					viewModel.gameState.didFindFlask {
					
					Section(header: Text("Actions")) {
						
						// MARK: Trap Actions
						
						if viewModel.gameState.didEncounterTrap && !viewModel.gameState.isTrapDefusionMiniGameIsOn {
							
							Button("Inspect the Trap") {
								viewModel.startTrapDefusionMiniGame()
							}
							.foregroundStyle(.orange)
							
							// Trap Alert Controller
							
							if !viewModel.gameState.didEndDemoLevel {
								Button("Get Info about Trap Defusion") {
									viewModel.audioManager.playSound(fileName: "openInfo", extensionName: "mp3")
									isTrapDefusionInfoAlertOpen = true
								}
								
								.alert("Trap Defusion Mini Game",
									   isPresented: $isTrapDefusionInfoAlertOpen) {
									
									Button("Got it", role: .cancel) {
										viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
										isTrapDefusionInfoAlertOpen = false
									}
								} message: {
									Text("Your goal is too memorize initial positions of the arrows and recreate the picture correctly to defuse the trap")
								}
							}
							
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
							
							// Restoration Shrine Alert Controller
							
							if !viewModel.gameState.didEndDemoLevel {
								Button("Get Info about Restoration Shrine") {
									viewModel.audioManager.playSound(fileName: "openInfo", extensionName: "mp3")
									isRestorationShrineInfoAlertOpen = true
								}
								
								.alert("Restoration Shrine",
									   isPresented: $isRestorationShrineInfoAlertOpen) {
									
									Button("Got it", role: .cancel) {
										viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
										isRestorationShrineInfoAlertOpen = false
									}
								} message: {
									Text("You can choose between recovering of small amount of health and mana or getting a single flask charge to use in battle")
								}
							}
							
							// MARK: Disenchant Shrine Actions
							
						} else if viewModel.gameState.didEncounterDisenchantShrine && !viewModel.gameState.dealtWithDisenchantShrine {
							
							Button("Disenchant an Item") {
								viewModel.goToInventory()
							}
							.foregroundStyle(.orange)
							
							if !viewModel.gameState.didEndDemoLevel {
								Button("Get Info about Disenchantment Shrine") {
									viewModel.audioManager.playSound(fileName: "openInfo", extensionName: "mp3")
									isDisenchantShrineInfoAlertOpen = true
								}
								
								// Disenchant Shrine Alert Controller
								
								.alert("Disenchant Shrine",
									   isPresented: $isDisenchantShrineInfoAlertOpen) {
									
									Button("Got it", role: .cancel) {
										viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
										isDisenchantShrineInfoAlertOpen = false
									}
								} message: {
									Text("At this place you can choose an armor or weapon in your inventory to disenchant and get some dark energy.")
								}
							}
							
							
							// MARK: Chest Tile Actions
							
						} else if viewModel.gameState.didEncounterChest && !viewModel.gameState.dealthWithChest {
							
							Button("Lock-pick the Chest") {
								viewModel.applyEffect(for: .lockPickChest, item: nil)
							}
							.foregroundStyle(.orange)
							
							// add amount of keys in inventory like "(keys: 5)"
							Button("Unlock with key (\(viewModel.displayKeys()))") {
								viewModel.audioManager.playSound(fileName: "openChest", extensionName: "mp3")
								viewModel.applyEffect(for: .unlockChestWithKey, item: nil)
								
							}
							.foregroundStyle(.orange)
							
							// Chest Lockpicking Alert Controller
							
							if !viewModel.gameState.didEndDemoLevel {
								Button("Get Info about Chest lockpicking") {
									viewModel.audioManager.playSound(fileName: "openInfo", extensionName: "mp3")
									isChestLockPickingInfoAlertOpen = true
								}
								
								.alert("Chest Lockpicking Mini Game",
									   isPresented: $isChestLockPickingInfoAlertOpen) {
									
									Button("Got it", role: .cancel) {
										viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
										isChestLockPickingInfoAlertOpen = false
									}
								} message: {
									Text("Your goal is to catch motion objects while they are at the green area by tapping circle buttons at the bottom of the board")
								}
							}
							
						} else if viewModel.gameState.didFindFlask {
							
							Button("Open/Hide Flask") {
								viewModel.gameState.isFlaskViewOpen.toggle()
								viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
							}
						}
						
						
						// MARK: - Did Found Scripted Secret Room
						
						if !viewModel.gameState.didEndDemoLevel &&
							!viewModel.gameState.shouldMeetPredefinedSecretRoom &&
							viewModel.gameState.heroPosition == Coordinate(row: 3, col: 5) {
							
							
							Button("You found Secret Room!") {
								viewModel.audioManager.playSound(fileName: "openInfo", extensionName: "mp3")
								
								isSecretRoomInfoAlertOpen = true
							}
							.alert("Secret Room (\"S\")",
								   isPresented: $isSecretRoomInfoAlertOpen) {
								
								Button("Got it", role: .cancel) {
									viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
									isSecretRoomInfoAlertOpen = false
								}
							} message : {
								Text("""
 In secret rooms you can get extra loot or find an enemy.
 To find secret rooms ("S" tile) you should check empty neighbour tiles from your position
 """)
							}
						}
						
						if viewModel.gameState.didEndDemoLevel &&
							viewModel.gameState.shouldThrowDemoCompletionAlert {
							
							Button("You Complete First Level!") {
								viewModel.audioManager.playSound(fileName: "openInfo", extensionName: "mp3")
								isDemoLevelCompletionAlertOpen = true
							}
							.alert("Congratulations!", isPresented: $isDemoLevelCompletionAlertOpen) {
								
								Button("Got it", role: .cancel) {
									viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
									isDemoLevelCompletionAlertOpen = false
									viewModel.gameState.shouldThrowDemoCompletionAlert = false
								}
							} message: {
								Text("""
  You successfully complete your first dungeon level! As reward from killing the boss you get an extra Shadow Flask Charge. Use it wisely.
  """)
							}
						}
						
						
						// MARK: - Did Found Flask Alert Controller
						
						if !viewModel.gameState.didEndDemoLevel &&
							viewModel.gameState.didFindFlask &&
							viewModel.gameState.heroPosition == Coordinate(row: 3, col: 1) {
							
							Button("You found Shadow Flask!") {
								viewModel.audioManager.playSound(fileName: "openInfo", extensionName: "mp3")
								isFlaskInfoAlertOpen = true
							}
							.alert("Shadow Flask", isPresented: $isFlaskInfoAlertOpen) {
								
								Button("Got it", role: .cancel) {
									viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
									isFlaskInfoAlertOpen = false
								}
							} message: {
								Text("""
  Shadow Flask can collect dark energy from events like battles or traps		
 In Battle you can use Flask by using Flask Charges with strong effect and long CD or by collecting combat impact from different actions.					
 Effect will differ accordingly to Flask Battle Mode (click on flask to change).								 Flask will always be with you across different runs and will save all dark energy you get.
 """)
							}
						}
						
					}
				}
				
				
				// MARK: Navigation
				
				if viewModel.gameState.isNavigationOpen { }
				
				Section(header: Text("Screens")) {
					
					// if hero has negative HP
					if viewModel.gameState.hero.currentHP <= 0 {
						Button("You are dead -> Start New Game") {
							viewModel.setupNewGame()
						}
						.foregroundStyle(.red)
					}
					
					if viewModel.wereAllLevelEventsExplored() {
						
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
		.frame(height: 250)
				
				// MARK: Joystick View
			
		} else if !viewModel.gameState.isNavigationOpen {
			
			JoystickView() { direction in
				viewModel.handleUserMovement(for: direction)
			}
			.frame(height: 250)
		}
	}
	
	// MARK: Get Dungeon Map

	@ViewBuilder
	func getDungeonMap() -> some View {

		VStack(spacing: UIScreen.main.bounds.width * 0.04) {

			ForEach(viewModel.gameState.dungeonMap.indices, id: \.self) { row in

				HStack(spacing: UIScreen.main.bounds.width * 0.04) {

					ForEach(viewModel.gameState.dungeonMap[row].indices, id: \.self) { col in

						let tile = viewModel.gameState.dungeonMap[row][col]

						getTileButton(tile: tile) {
							
							print(tile.coordinate)
							
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
			
		} else if tile.type == .secret && tile.events.contains(.secret) {
			opacityRatio = 0.01
			title = "S"
			
		} else if tile.type == .empty && tile.events.contains(.secret) && !viewModel.gameState.shouldMeetPredefinedSecretRoom {
			opacityRatio = 0.5
			title = "S"
			
		}
		
		// Size was calculated based on 15 height and 25 width for different screens
		// We use UIScreen.main.bounds to get this initial size to base on
		return Button(action: action) {
			Text(title == "" ? (isHeroPosition ? "M" : "") : title)
				.frame(width: UIScreen.main.bounds.width * 0.04,
					   height: UIScreen.main.bounds.width * 0.06) // Fixes internal content size to match height around 15 pixels and width around 25 pixes
				.font(wasTapped ? .none : .title2)
		}
		.buttonStyle(.bordered)
		.font(wasTapped ? .none : .title2)
		.foregroundColor(tileColor)
		.opacity(viewModel.gameState.tappedTile == tile && neighbours.contains(tile) ? 0.5 : opacityRatio)
	}
}
