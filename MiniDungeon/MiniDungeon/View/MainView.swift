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
			
		case .heroStats:
			
			buildHeroStats()
			
		case .inventory:
			
			buildInventory()
			
		case .options:
			
			buildOptions()
			
		case .rewards:
			
			buildRewards()
			
		case .miniGame:
			
			MiniGameView { success in
				viewModel.gameState.isMiniGameSuccessful = success
				print(success)
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
					self.viewModel.goToBattle()
				}
			}
			
		case .specialisation:
			
			buildSpecialisation()
			
		case .enemyStats:
			
			buildEnemyStats()
			
		case .merchant:
			
			buildMerchant()
		}
		
	}
}

// MARK: - LevelComplete Screen (View)


