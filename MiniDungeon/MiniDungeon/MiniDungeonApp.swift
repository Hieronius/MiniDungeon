import SwiftUI

@main
struct MiniDungeonApp: App {
	
    var body: some Scene {
        WindowGroup {
			buildMainView()
        }
    }
	
	// MARK: Build Main View
	
	func buildMainView() -> MainView {
		
		let dungeonGenerator = DungeonGenerator()
		let dungeonScheme = DungeonScheme()
		let gameState = GameState()
		let gameScreen = GameScreen.menu
		
		let viewModel = MainViewModel(
			dungeonGenerator: dungeonGenerator,
			dungeonScheme: dungeonScheme,
			gameState: gameState,
			gameScreen: gameScreen
		)
		
		let view = MainView(
			viewModel: viewModel
		)
		return view
	}
}
