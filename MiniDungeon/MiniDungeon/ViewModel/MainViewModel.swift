import SwiftUI

class MainViewModel: ObservableObject {
	
	// MARK: - Dependencies
	
	@Published var gameState: GameState
	@Published var gameScreen: GameScreen
	
	// MARK: - Initialization
	
	init(gameState: GameState,
		 gameScreen: GameScreen) {
		
		self.gameState = gameState
		self.gameScreen = gameScreen
	}
	
	// MARK: - Navigation
	
	func goToMenu() {
		gameScreen = .menu
	}
	
	func goToBattle() {
		gameScreen = .battle
	}
	
	func goToDungeon() {
		gameScreen = .dungeon
	}
	
	func goToTown() {
		gameScreen = .town
	}
	
	
}
