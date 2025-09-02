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
		
		let gameState = GameState()
		let gameScreen = GameScreen.menu
		
		let viewModel = MainViewModel(
			gameState: gameState,
			gameScreen: gameScreen
		)
		
		let view = MainView(
			viewModel: viewModel
		)
		return view
	}
}
