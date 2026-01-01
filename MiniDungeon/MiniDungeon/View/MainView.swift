import SwiftUI

struct MainView: View {
	
	// TODO: Test property
	@Environment(\.scenePhase) private var scenePhase
	
	// MARK: - Dependencies
	
	@StateObject var viewModel: MainViewModel
	@State var itemToDisplay: (any ItemProtocol)? = nil
	
	// MARK: - Initialization
	
	init(viewModel: MainViewModel) {
		_viewModel = StateObject(wrappedValue: viewModel)
	}
	
	// MARK: - Body
	
	var body: some View {
		
		// It is a debug option to print property which causes a View rerendering update
		let _ = Self._printChanges()
		
		switch viewModel.gameState.gameScreen {
			
		case .menu:
			
			buildMenu()
			
		case .battle:
			
			buildBattle()
			
		case .dungeon:
			
			buildDungeon()
			
		case .town:
			
			buildTown()
			
		case .heroStats:
			
			buildHeroStats()
			
		case .inventory:
			
			buildInventory()
			
		case .options:
			
			buildOptions()
			
		case .rewards:
			
			buildRewards()
			
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
			
			buildEnemyStats()
			
		case .merchant:
			
			buildMerchant()
			
		case .levelBonus:
			
			buildLevelBonus()
		}
		
	}
}


