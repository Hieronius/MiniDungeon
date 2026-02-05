import SwiftUI

struct MainView: View {
	
	// TODO: Test property
	@Environment(\.scenePhase) private var scenePhase
	
	// MARK: - Dependencies
	
	@StateObject var viewModel: MainViewModel
	@State var itemToDisplay: (any ItemProtocol)? = nil
	@State var shrineToDisplay: Shrine? = nil
	@State var didFlaskGotLevelUP = false
	
	/// Custom Property when being toggled by tapping the flask view to change it's battle mode will force SwiftUI rerender an entire UI. Otherwise you chance flask battle mode under the hood correctly but UI won't change
	/// An explanation of this is that to trigger UI you need to use one of MainView properties inside it's other views or ViewBuilders as i did with BuildShadowFlask()
	/// I just used flaskBeingTapped as Ternary Operator Argument to change flask view width from 40 to 40, so in SwiftUI View Tree Structure will observe it's change automatically
	@State var flaskBeingTapped = false
	
	/// It's a flask "ghost position" property which holds X and Y coordinates as Width and Height
	/// When you drag the Flask it's actual "inMemory" coordinates are the same, only this property changes
	/// When you drop the view, this property will be added to initial flask coordinates as a difference between start and end position
	/// IMPORTANT: IF YOU IGNORE THIS PROPERTY AND JUST INCREMENT VIEW COORDINATES WHILE DRAGGING, IT WILL FLY OUT OF THE SCREEN
	@State var dragFlaskTemporaryTranslationPositionOnScreen: CGSize = .zero
	
	// MARK: - Initialization
	
	init(viewModel: MainViewModel) {
		_viewModel = StateObject(wrappedValue: viewModel)
		didFlaskGotLevelUP = viewModel.gameState.didFlaskGetLevelUP
		itemToDisplay = nil
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
				
				buildBattleView()
				
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
				
				CombatMiniGameView { success in
					viewModel.gameState.isCombatMiniGameSuccessful = success
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
						self.viewModel.goToBattle()
					}
				}
				
			case .trapDefusionMiniGame:
				
				buildTrapDefusionMiniGameView()
				
			case .chestLockPickingMiniGame:
				
				buildChestLockPickingMiniGameView()
				
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
				
			}
		}
//		.overlay(alignment: .topLeading) {
//			
//			// MARK: Put conditions to not display flask in Menu and other statistic screens here
//			
//			if viewModel.gameState.currentGameScreen != .menu && viewModel.gameState.currentGameScreen != .options &&
//				viewModel.gameState.currentGameScreen != .heroStats &&
//				viewModel.gameState.currentGameScreen != .enemyStats &&
//				viewModel.gameState.currentGameScreen != .inventory &&
//				viewModel.gameState.currentGameScreen != .heroLevelBonus &&
//				viewModel.gameState.currentGameScreen != .merchant &&
//				viewModel.gameState.currentGameScreen != .rewards &&
//				viewModel.gameState.currentGameScreen != .town &&
//				viewModel.gameState.currentGameScreen != .flaskTalants &&
//				viewModel.gameState.currentGameScreen != .flaskLevelBonus &&
//				viewModel.gameState.currentGameScreen != .dungeon {
//				
//				buildShadowFlaskView()
//			}
//		}
			
			
		}
		
	}



