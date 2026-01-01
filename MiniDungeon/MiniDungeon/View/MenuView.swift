import SwiftUI

// MARK: - Menu Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildMenu() -> some View {
		
		List {
			
			Section(header: Text("Menu")) {
				
				Button("Dungeon") {
					viewModel.goToDungeon()
				}
				Button("Stats") {
					viewModel.goToHeroStats()
				}
				Button("Inventory") {
					viewModel.goToInventory()
				}
				// MARK: Uncomment to Erase and Insert a new Game State
//				Button("Erase Game State") {
//					let newState = GameState()
//					viewModel.gameState = newState
//					viewModel.swiftDataManager.saveGameState(newState)
//					viewModel.generateMap()
//					viewModel.spawnHero()
//				}
			}
		}
	}
}
