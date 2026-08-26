import SwiftUI

struct MainView: View {
	
	// TODO: Test property
	@Environment(\.scenePhase) private var scenePhase
	
	// MARK: - Dependencies
	
	let viewModel: MainViewModel
	
	// MARK: - State Properties
	
	@State var didEventOccured = false
	
	@State var itemToDisplay: (any ItemProtocol)? = nil
	@State var weaponToDisplay: Weapon? = nil
	@State var armorToDisplay: Armor? = nil
	@State var shrineToDisplay: Shrine? = nil
	@State var didFlaskGotLevelUP = false
	
	// Alert Controllers
	
	@State var isTrapDefusionInfoAlertOpen = false
	@State var isRestorationShrineInfoAlertOpen = false
	@State var isDisenchantShrineInfoAlertOpen = false
	@State var isChestLockPickingInfoAlertOpen = false
	@State var isSecretRoomInfoAlertOpen = false
	@State var isCombatInfoAlertOpen = false
	@State var isFlaskInfoAlertOpen = false
	@State var isDemoLevelCompletionAlertOpen = false
	
	// place for flask/battle/... other
	
	/// Custom Property when being toggled by tapping the flask view to change it's battle mode will force SwiftUI rerender an entire UI. Otherwise you chance flask battle mode under the hood correctly but UI won't change
	/// An explanation of this is that to trigger UI you need to use one of MainView properties inside it's other views or ViewBuilders as i did with BuildShadowFlask()
	/// I just used flaskBeingTapped as Ternary Operator Argument to change flask view width from 40 to 40, so in SwiftUI View Tree Structure will observe it's change automatically
	@State var flaskBeingTapped = false
	
	// MARK: - Initialization
	
	init(viewModel: MainViewModel) {
		self.viewModel = viewModel
		// AI told me that this property won't be listen to but and that i should use viewModel.gameState.didFlaskGetLevelUP directly. But i won't believe it until i test
		didFlaskGotLevelUP = viewModel.gameState.didFlaskGetLevelUP
		itemToDisplay = nil
		weaponToDisplay = nil
		armorToDisplay = nil
	}
	
	// MARK: - Body
	
	var body: some View {
		
		// It is a debug option to print property which causes a View rerendering update
		let _ = Self._printChanges()
		
		Group {
			
			switch viewModel.gameState.currentGameScreen {
				
			case .menu:
				
				buildMenuView()
				
			case .battle:
				
				// When CoinFlipMiniGame is visible on the screen user should not be able to press any buttons
				buildBattleView()
					.allowsHitTesting(!viewModel.gameState.isCoinFlipMiniGameOn)
					.allowsHitTesting(viewModel.gameState.didBossFightSoundEnd)
				
			case .dungeon:
				
				buildDungeonView()
				
			case .town:
				
				buildTownView()
				
			case .heroStats:
				
				buildHeroStatsView()
				
			case .inventory:
				
				buildInventoryView()
				
			case .options:
				
				buildOptionsView()
				
			case .rewards:
				
				buildRewardsView()
				
			case .combatMiniGame:
				
				// Probably made for testing purposes
				
				//				CombatMiniGameView { success in
				//					viewModel.gameState.isCombatMiniGameSuccessful = success
				//					DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
				//						self.viewModel.goToBattle()
				//					}
				//				}
				VStack {
					
				}
				
			case .trapDefusionMiniGame:
				
				//				buildTrapDefusionMiniGameView(audioManager: viewModel.audioManager)
				
				VStack {
					
				}
				
			case .chestLockPickingMiniGame:
				
				//				buildChestLockPickingMiniGameView(audioManager: viewModel.audioManager)
				
				VStack {
					
				}
				
			case .specialisation:
				
				buildSpecialisation()
				
			case .enemyStats:
				
				buildEnemyStatsView()
				
			case .merchant:
				
				buildMerchantView()
				
			case .heroLevelBonus:
				
				buildHeroLevelBonusView()
				
			case .flask:
				
				buildShadowFlaskView()
				
			case .flaskTalants:
				
				buildFlaskTalantsView()
				
			case .flaskLevelBonus:
				
				buildFlaskLevelBonusView()
				
				
			case .shadowBallMiniGame:
				
				VStack { }
				//				buildShadowBallMiniGameView()
				
			case .testTimelineView:
				
				buildTestTimelineView()
				
			case .evasionMiniGame:
				
				buildEvasionMiniGame()
				
			case .statsRecovery:
				
				VStack {
					// we have a direct call of the struct from battle view
				}
				
			case .coinFlipMiniGame:
				
				//				buildCoinFlipMiniGame()
				VStack { }
				//				print("If you want a separate button to open coin flip view")
				
			case .levelPerk:
				
				buildLevelPerkView()
				
			case .testCollisionView:
				
				TestCollisionView()
				
			case .joystickView:
				
				JoystickView() { direction in
					print(direction)
				}
				
			case .damageBoostMiniGameView:
				
				DamageBoostMiniGameView(isEnglish: isEnglish(), isGamePaused: isGamePaused()) { result in
					print(result)
				}
			}
			
			if !isGamePaused() {
				VStack {
					Button("PAUSE") {
						viewModel.gameState.isGamePaused.toggle()
					}
					.foregroundStyle(.red)
					.frame(width: 100, height: 30)
					//				.border(.red, width: 1)
					//				.font(.largeTitle)
					if viewModel.gameState.currentGameScreen == .dungeon {
						Rectangle()
							.frame(height: 50)
							.opacity(0.0)
					}
				}
			}
		
		
		
	}
		.disabled(isGamePaused())
		.overlay(alignment: .center) {
			
			// MARK: PAUSE label
			
			if isGamePaused() {
				
				ZStack {
					Color.black
						.opacity(0.9) // Adjust this value for darkness level
						.ignoresSafeArea() // Covers the entire screen
					
					VStack {
						
						Text(isEnglish() ? "PAUSED" : "ПАУЗА")
							.foregroundStyle(.red)
							.frame(width: 250, height: 100)
							.border(.white, width: 5)
							.background(.black)
							.font(.largeTitle)
						
						Text(isEnglish() ? "CONTINUE" : "ПРОДОЛЖИТЬ")
							.foregroundStyle(.blue)
							.frame(width: 300, height: 100)
							.border(.white, width: 5)
							.background(.black)
							.font(.largeTitle)
							.onTapGesture {
								viewModel.gameState.isGamePaused.toggle()
							}
					}
				}
				
			}
		}
}
}

extension MainView {
	
	/// Small method to use in View to cut the name of call chain to this property
	func isEnglish() -> Bool {
		viewModel.gameState.isEnglishLocalisation
	}
	
	/// We use this small method to decrease amount of code when we pass isGamePaused to mini games and other view elements
	func isGamePaused() -> Bool {
		viewModel.gameState.isGamePaused
	}
}



