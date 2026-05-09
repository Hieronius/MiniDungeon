import Foundation
import SwiftData

/*
 Discussion
 
 1. Initial State (stack = [.menu])
 currentScreen = .menu
 previousScreen = .menu
 
 2. User clicked "Dungeon" button (stack.append(.dungeon))
 currentScreen = .dungeon
 previousScreen = .menu
 
 3. User have two options to choose (.stats/.inventory)
 
 */

/// Entity to create and control Navigation Schemes inside the game
@Model
class NavigationStack {
	
	private var stack: [GameScreen]
	
	init() {
		self.stack = [.menu]
	}
	
	func pushScreen(_ screen: GameScreen) {
		stack.append(screen)
	}
	
	func popScreen() -> GameScreen? {
		stack.popLast()
	}
}
