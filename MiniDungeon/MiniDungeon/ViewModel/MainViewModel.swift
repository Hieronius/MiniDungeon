import SwiftUI

class MainViewModel: ObservableObject {
	
	// MARK: - Dependencies
	
	var dungeonGenerator: DungeonGenerator
	var dungeonScheme: DungeonScheme
	
	// MARK: - Properties
	
	@Published var gameState: GameState
	@Published var gameScreen: GameScreen
	
	// MARK: - Initialization
	
	init(dungeonGenerator: DungeonGenerator,
		 dungeonScheme: DungeonScheme,
		 gameState: GameState,
		 gameScreen: GameScreen) {
		
		self.dungeonGenerator = dungeonGenerator
		self.dungeonScheme = dungeonScheme
		self.gameState = gameState
		self.gameScreen = gameScreen
		
		generateMap()
		spawnHero()
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
	
	func goToHeroStats() {
		gameScreen = .heroStats
	}
	
	func goToOptions() {
		gameScreen = .options
	}
	
	func goToRewards() {
		gameScreen = .rewards
	}
}
