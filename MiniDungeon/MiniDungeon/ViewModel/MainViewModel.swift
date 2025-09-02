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
	
	// MARK: - Combat
	
	func attack() {
		
		gameState.isHeroTurn ?
		(gameState.enemyCurrentHP -= gameState.heroDamage) :
		(gameState.heroCurrentHP -= gameState.enemyDamage)
		print(!gameState.isHeroTurn ? "\(gameState.heroCurrentHP)" : "\(gameState.enemyCurrentHP)")
		
	}
	
	func endTurn() {
		gameState.isHeroTurn.toggle()
		print(gameState.isHeroTurn ? "Now is Hero Turn" : "Now is Enemy Turn")
	}
	
	func restoreStats() {
		
		gameState.heroCurrentHP = gameState.heroMaxHP
		gameState.enemyCurrentHP = gameState.enemyMaxHP
	}
	
	
}
