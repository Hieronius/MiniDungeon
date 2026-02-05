import SwiftUI

// MARK: - Menu Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildMenuView() -> some View {
		
		List {
			
			Section(header: Text("Menu")) {
				
				Button("Dungeon") {
					viewModel.goToDungeon()
				}
				// MARK: Uncomment to Erase and Insert a new Game State
//				Button("Erase Game State") {
//					let flask = Flask()
//					let hero = Hero(flask: flask)
//					let newState = GameState(hero: hero)
//					viewModel.gameState = newState
//					viewModel.swiftDataManager.saveGameState(newState)
//					viewModel.generateMap()
//					viewModel.spawnHero()
//				}
				
			}
		}
	}
}
