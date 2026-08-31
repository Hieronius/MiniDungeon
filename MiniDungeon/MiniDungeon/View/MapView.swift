import SwiftUI

// MARK: - Dungeon Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildDungeonView() -> some View {
		
		VStack {
			
//			Rectangle()
//				// if ran on small devices make this invisible object higher, otherwise smaller. <= 830 mean all mini classes
//				.frame(height: UIScreen.main.bounds.height <= 830 ? 75 : 50)
//				.foregroundStyle(.black)
			
//			VStack {
//				
//				HStack {
//					
//					Spacer()
//					
//					if isEnglish() {
//						Text("Dungeon Level: \(viewModel.gameState.currentDungeonLevel)")
//					} else {
//						Text("Уровень подземелья: \(viewModel.gameState.currentDungeonLevel)")
//					}
//					
//					Spacer()
//					
//					if isEnglish() {
//						Text("Battles won: \(viewModel.gameState.battlesWon)")
//					} else {
//						Text("Битв: \(viewModel.gameState.battlesWon)")
//					}
//					
//					Spacer()
//				}
//				
//				HStack {
//					
//					Spacer()
//					
//					if isEnglish() {
//						Text("Dark Energy: \(viewModel.gameState.heroDarkEnergy)")
//					} else {
//						Text("Темная энергия: \(viewModel.gameState.heroDarkEnergy)")
//					}
//					
//					Spacer()
//					
//					if isEnglish() {
//						Text("Gold: \(viewModel.gameState.heroGold)")
//					} else {
//						Text("Золото: \(viewModel.gameState.heroGold)")
//					}
//					Spacer()
//				}
//				
//				HStack {
//					
//					Spacer()
//					if isEnglish() {
//						Text("Hero lvl: \(viewModel.gameState.hero.heroLevel)")
//					} else {
//						Text("Уровень героя: \(viewModel.gameState.hero.heroLevel)")
//					}
//					Spacer()
//					
//					if isEnglish() {
//						Text("Hero XP: \(viewModel.gameState.hero.currentXP)/\(viewModel.gameState.hero.maxXP)")
//					} else {
//						Text("Опыт героя: \(viewModel.gameState.hero.currentXP)/\(viewModel.gameState.hero.maxXP)")
//					}
//					Spacer()
//				}
//				
//				HStack {
//					Spacer()
//					
//					if isEnglish() {
//						Text("HP: \(viewModel.gameState.hero.currentHP)/\(viewModel.gameState.hero.maxHP)")
//					} else {
//						Text("Здоровье: \(viewModel.gameState.hero.currentHP)/\(viewModel.gameState.hero.maxHP)")
//					}
//					Spacer()
//					
//					if isEnglish() {
//						Text("MP: \(viewModel.gameState.hero.currentMana)/\(viewModel.gameState.hero.maxMana)")
//					} else {
//						Text("Мана: \(viewModel.gameState.hero.currentMana)/\(viewModel.gameState.hero.maxMana)")
//					}
//					Spacer()
//				}
//				
//				HStack {
//					Spacer()
//					
//					if isEnglish() {
//						Text("Rooms explored: \(viewModel.countMapRooms().0)/\(viewModel.countMapRooms().1)")
//					} else {
//						Text("Комнат открыто: \(viewModel.countMapRooms().0)/\(viewModel.countMapRooms().1)")
//					}
//					Spacer()
//					
//					if viewModel.gameState.didFindFlask {
//						
//						if isEnglish() {
//							Text("Flask XP: \(viewModel.gameState.hero.flask.currentXP)/\(viewModel.gameState.hero.flask.expToLevelUP)")
//						} else {
//							Text("Опыт фляги: \(viewModel.gameState.hero.flask.currentXP)/\(viewModel.gameState.hero.flask.expToLevelUP)")
//						}
//					}
//					Spacer()
//				}
//				
//			}
			
//			Spacer()
			
			// MARK: Trap Defusion Mini Game With Outcome
			
			if viewModel.gameState.isTrapDefusionMiniGameIsOn {
				
				TrapDefusionMiniGameView(
					audioManager: viewModel.audioManager,
					isEnglish: isEnglish()) { success in
						
					viewModel.handleTrapDefusionMiniGameResult(success)
				}
				
				// MARK: Chest Lock Picking Mini Game
				
			} else if viewModel.gameState.isLockPickingMiniGameIsOn {
				
				ChestLockPickingMiniGameView(
					audioManager: viewModel.audioManager,
					isEnglish: isEnglish(),
					isGamePaused: isGamePaused()
				) { lockPickingResult in
						
					viewModel.handleChestLockPickingMiniGameResult(lockPickingResult)
				}
				
				// MARK: Dungeon Map
				
			} else if !(viewModel.gameState.isTrapDefusionMiniGameIsOn || viewModel.gameState.isLockPickingMiniGameIsOn ||
						viewModel.gameState.isHeroStatsScreenOpen ||
						viewModel.gameState.isInventoryScreenOpen) {
				
				getDungeonMap()
					.frame(width: UIScreen.main.bounds.width,
						   height: UIScreen.main.bounds.height <= 830 ? 325 : 350)
					.onTapGesture(count: 3) {
						viewModel.goToMenu()
					}
			}
			
			// MARK: Navigation/Movement bars
			
			HStack() {
				
				VStack {
					
					Button(
						action: {
							viewModel.gameState.isNavigationOpen = true
						}, label: {
							Text(isEnglish() ? "Navigation" : "Навигация")
								.font(viewModel.gameState.isNavigationOpen ? .title2 : .body)
								.frame(width: 150, height: 35)
								.foregroundStyle(viewModel.gameState.isNavigationOpen ? .white : .gray)
								.backgroundStyle(.black)
								.border(viewModel.gameState.isNavigationOpen ? .white : .gray, width: 3)
							
						}
					)
					
					Button(
						action: {
							viewModel.goToHeroStats()
						}, label: {
							Text(isEnglish() ? "Hero Stats" : "О герое")
								.font(.body)
								.frame(width: 150, height: 35)
								.foregroundStyle(.gray)
								.backgroundStyle(.black)
								.border(.white, width: 3)
							
						}
					)
				}
				
				VStack {
					
					// MARK: Shadow Flask
					
					if viewModel.gameState.didFindFlask && viewModel.gameState.isFlaskViewOpen {
						buildShadowFlaskView()
					} else {
						buildShadowFlaskView()
							.opacity(0)
					}
					
					// MARK: Localisation
					
					Button(isEnglish() ? "EN" : "RU") {
						viewModel.gameState.isEnglishLocalisation.toggle()
						viewModel.gameState.hero.flask.isEnglish = viewModel.gameState.isEnglishLocalisation
						viewModel.audioManager.playSound(
							fileName: "click",
							extensionName: "mp3"
						)
					}
					.frame(width: 50, height: 50)
					.foregroundStyle(.white)
					.border(.white, width: 3)
					
				}
				
				VStack {
					
					Button(
						action: {
							viewModel.gameState.isNavigationOpen = false
						}, label: {
							Text(isEnglish() ? "Movement" : "Движение")
								.font(!viewModel.gameState.isNavigationOpen ? .title2 : .body)
								.frame(width: 150, height: 35)
								.foregroundStyle(!viewModel.gameState.isNavigationOpen ? .white : .gray)
								.backgroundStyle(.black)
								.border(!viewModel.gameState.isNavigationOpen ? .white : .gray, width: 3)
							
						}
					)
					
					Button(
						action: {
							viewModel.goToInventory()
						}, label: {
							Text(isEnglish() ? "Inventory" : "Инвентарь")
								.font(.body)
								.frame(width: 150, height: 35)
								.foregroundStyle(.gray)
								.backgroundStyle(.black)
								.border(.white, width: 3)
							
						}
					)
					
				}
			}
			
			if viewModel.gameState.isNavigationOpen {
				
				List {
					
					// MARK: Actions
					
					// if encountered any type of events such as a trap or shrine
					
					if viewModel.gameState.didEncounterTrap && !viewModel.gameState.isTrapDefusionMiniGameIsOn || viewModel.gameState.didEncounterRestorationShrine || viewModel.gameState.didEncounterDisenchantShrine || viewModel.gameState.didEncounterChest ||
						viewModel.gameState.didFindFlask {
						
						Section(header: Text(isEnglish() ? "Actions" : "Действия")) {
							
							// MARK: Trap Actions
							
							if viewModel.gameState.didEncounterTrap && !viewModel.gameState.isTrapDefusionMiniGameIsOn {
								
								Button(isEnglish() ? "Inspect the Trap" : "Исследовать ловушку") {
									viewModel.startTrapDefusionMiniGame()
								}
								.foregroundStyle(.orange)
								
								// Trap Alert Controller
								
								if !viewModel.gameState.didEndDemoLevel {
									
									if isEnglish() {
										
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
										
									} else {
										
										Button("Как обезвредить ловушку") {
											viewModel.audioManager.playSound(fileName: "openInfo", extensionName: "mp3")
											isTrapDefusionInfoAlertOpen = true
										}
										
										.alert("Обезвреживание ловушки",
											   isPresented: $isTrapDefusionInfoAlertOpen) {
											
											Button("Понятно", role: .cancel) {
												viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
												isTrapDefusionInfoAlertOpen = false
											}
										} message: {
											Text("Ваша задача запомнить первоначальные позиции стрелок и установить их в то же положение, чтобы успешно обезвредить ловушку")
										}
									}
								}
								
								// MARK: Restoration Shrine Actions
								
							} else if viewModel.gameState.didEncounterRestorationShrine &&  !viewModel.gameState.dealtWithRestorationShrine {
								
								if isEnglish() {
									
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
								} else {
									
									Button("Восстановить ману и здоровье") {
										viewModel.applyEffect(for: .restoreHealthManaWithSmallChanceToGetDamage, item: nil)
									}
									.foregroundStyle(.orange)
									
									Button("Восстановить заряд фляги") {
										viewModel.applyEffect(for: .getFlaskCharge, item: nil)
									}
									.foregroundStyle(.orange)
									
									// Restoration Shrine Alert Controller
									
									if !viewModel.gameState.didEndDemoLevel {
										Button("О алтаре восстановления") {
											viewModel.audioManager.playSound(fileName: "openInfo", extensionName: "mp3")
											isRestorationShrineInfoAlertOpen = true
										}
										
										.alert("Алтарь восстановления",
											   isPresented: $isRestorationShrineInfoAlertOpen) {
											
											Button("Понятно", role: .cancel) {
												viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
												isRestorationShrineInfoAlertOpen = false
											}
										} message: {
											Text("Вы можете восстановить небольшое количество здоровья и маны или получить заряд фляги, который можно использовать в бою")
										}
									}
								}
								
								// MARK: Disenchant Shrine Actions
								
							} else if viewModel.gameState.didEncounterDisenchantShrine && !viewModel.gameState.dealtWithDisenchantShrine {
								
								if isEnglish()  {
									
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
									
								} else {
									
									Button("Распылить предмет") {
										viewModel.goToInventory()
									}
									.foregroundStyle(.orange)
									
									if !viewModel.gameState.didEndDemoLevel {
										Button("О алтаре снятия чар") {
											viewModel.audioManager.playSound(fileName: "openInfo", extensionName: "mp3")
											isDisenchantShrineInfoAlertOpen = true
										}
										
										// Disenchant Shrine Alert Controller
										
										.alert("Алтарь снятия чар",
											   isPresented: $isDisenchantShrineInfoAlertOpen) {
											
											Button("Понятно", role: .cancel) {
												viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
												isDisenchantShrineInfoAlertOpen = false
											}
										} message: {
											Text("Вы можете выбрать броню или оружие из вашего инвентаря и разрушить предмет в обмен на небольшое количество темной энергии")
										}
									}
								}
								
								
								// MARK: Chest Tile Actions
								
							} else if viewModel.gameState.didEncounterChest && !viewModel.gameState.dealthWithChest {
								
								if isEnglish() {
									
									Button("Lock-pick the Chest") {
										viewModel.applyEffect(for: .lockPickChest, item: nil)
									}
									.foregroundStyle(.orange)
									
									// add amount of keys in inventory like "(keys: 5)"
									Button("Unlock with key (\(viewModel.displayKeys()))") {
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
								} else {
									
									Button("Взломать сундук") {
										viewModel.applyEffect(for: .lockPickChest, item: nil)
									}
									.foregroundStyle(.orange)
									
									// add amount of keys in inventory like "(keys: 5)"
									Button("Открыть ключом (\(viewModel.displayKeys()))") {
										viewModel.audioManager.playSound(fileName: "openChest", extensionName: "mp3")
										viewModel.applyEffect(for: .unlockChestWithKey, item: nil)
										
									}
									.foregroundStyle(.orange)
									
									// Chest Lockpicking Alert Controller
									
									if !viewModel.gameState.didEndDemoLevel {
										Button("Как взломать сундук") {
											viewModel.audioManager.playSound(fileName: "openInfo", extensionName: "mp3")
											isChestLockPickingInfoAlertOpen = true
										}
										
										.alert("Взлом сундука",
											   isPresented: $isChestLockPickingInfoAlertOpen) {
											
											Button("Понятно", role: .cancel) {
												viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
												isChestLockPickingInfoAlertOpen = false
											}
										} message: {
											Text("Ваша задача словить все двигающиеся элементы, когда они находятся в зеленой зоне игрового поля")
										}
									}
								}
								
								// MARK: Flask Actions
								
							} else if viewModel.gameState.didFindFlask {
								
								Button(isEnglish() ? "Open/Hide Flask" : "Открыть/скрыть флягу") {
									viewModel.gameState.isFlaskViewOpen.toggle()
									viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
								}
							}
							
							
							// MARK: - Did Found Scripted Secret Room
							
							if !viewModel.gameState.didEndDemoLevel &&
								!viewModel.gameState.shouldMeetPredefinedSecretRoom &&
								viewModel.gameState.heroPosition == Coordinate(row: 3, col: 5) {
								
								if isEnglish() {
									
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
								} else {
									
									Button("Вы нашли секретную комнату!") {
										viewModel.audioManager.playSound(fileName: "openInfo", extensionName: "mp3")
										
										isSecretRoomInfoAlertOpen = true
									}
									.alert("Секретная комната (\"S\")",
										   isPresented: $isSecretRoomInfoAlertOpen) {
										
										Button("Понятно", role: .cancel) {
											viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
											isSecretRoomInfoAlertOpen = false
										}
									} message : {
										Text("""
 В секретных комнатах вы можете добыть предметы, золото и темную энергию.
 Чтобы найти секретные комнаты ("S" символ на карте) проверяйте все соседние комнаты от текущей позиции героя.
 Комнаты никак не отображаются на карте. Они покрыты туманом войны.
 """)
									}
								}
							}
							
							if viewModel.gameState.didEndDemoLevel &&
								viewModel.gameState.shouldThrowDemoCompletionAlert {
								
								if isEnglish() {
									
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
								} else {
									
									Button("Вы завершили первый уровень!") {
										viewModel.audioManager.playSound(fileName: "openInfo", extensionName: "mp3")
										isDemoLevelCompletionAlertOpen = true
									}
									.alert("Поздравляем!", isPresented: $isDemoLevelCompletionAlertOpen) {
										
										Button("Понятно", role: .cancel) {
											viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
											isDemoLevelCompletionAlertOpen = false
											viewModel.gameState.shouldThrowDemoCompletionAlert = false
										}
									} message: {
										Text("""
  Вы успешно завершили ваш первый уровень подземелья! В качестве награды вы получаете +1 к максимальному уровню зарядов фляги. Используйте ее с умом.
  """)
									}
								}
							}
							
							
							// MARK: - Did Found Flask Alert Controller
							
							if !viewModel.gameState.didEndDemoLevel &&
								viewModel.gameState.didFindFlask &&
								viewModel.gameState.heroPosition == Coordinate(row: 3, col: 1) {
								
								if isEnglish() {
									
									
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
								} else {
									
									Button("Вы нашли Теневую Флягу!") {
										viewModel.audioManager.playSound(fileName: "openInfo", extensionName: "mp3")
										isFlaskInfoAlertOpen = true
									}
									.alert("Теневая Фляги", isPresented: $isFlaskInfoAlertOpen) {
										
										Button("Понятно", role: .cancel) {
											viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
											isFlaskInfoAlertOpen = false
										}
									} message: {
										Text("""
   Теневая фляга может вбирать в себя темную энергию, полученную из различных событий, таких как битвы или ловушки.		
  В бою вы можете использовать один из зарядов фляги для специальных способностей, либо наполнять флягу различными способами (полученный урон/лечение/эффект блока) для высвобождения дополнительных эффектов.					
  Эффект фляги будет зависеть от боевого/защитного режима фляги. Нажмите по фляге для смены режима. 								 Фляга будет с вами на протяжении всех забегов и позволит не только собирать темную энергию, но и сохранить ее даже после поражения в текущем забеге.
  """)
									}
								}
								
							}
						}
					}
					
					
					// MARK: Navigation
					
					if viewModel.gameState.hero.currentHP <= 0 || viewModel.wereAllLevelEventsExplored() {
						
						Section(header: Text(isEnglish() ? "Special Actions" : "Специальные действия")) {
							
							if isEnglish() {
								
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
								
							} else {
								
								// if hero has negative HP
								if viewModel.gameState.hero.currentHP <= 0 {
									
									Button("Вы погибли -> начать новую игру") {
										viewModel.setupNewGame()
									}
									.foregroundStyle(.red)
								}
								
								if viewModel.wereAllLevelEventsExplored() {
									
									Button("Призвать босса уровня") {
										viewModel.summonBoss()
									}
									.foregroundStyle(.purple)
								}
							}
							
							
						}
					}
				}
//				.frame(height: UIScreen.main.bounds.height <= 830 ? 180 : 180)
				.frame(height: 250)
				
			} else if !viewModel.gameState.isNavigationOpen {
				
				
				// MARK: Joystick View
				
				JoystickView() { direction in
					viewModel.handleUserMovement(for: direction)
				}
				.scaleEffect(UIScreen.main.bounds.height <= 830 ? 1.0 : 1.0)
				.frame(height: 250)
			}
		}
		.frame(height: UIScreen.main.bounds.height - 45)
		
	}
	
}
extension MainView {
	
	// MARK: Get Dungeon Map
	
	@ViewBuilder
	func getDungeonMap() -> some View {
		
		ZStack {
			
			Image("Dungeon")
				.resizable()
//				.aspectRatio(contentMode: .fit)
				.opacity(0.5)
			
			
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
	}
}

extension MainView {
			
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
		/// without this explicitly called property you will get a complete circle shaped buttons in all iphones with iOS 26+
		.buttonBorderShape(.roundedRectangle(radius: 8))
		.font(wasTapped ? .none : .title2)
		.foregroundColor(tileColor)
		.background()
		.opacity(viewModel.gameState.tappedTile == tile && neighbours.contains(tile) ? 0.5 : opacityRatio)
	}
}
