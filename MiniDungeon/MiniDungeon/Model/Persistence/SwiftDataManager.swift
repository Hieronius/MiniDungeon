import SwiftData

/// Entity to handle SwiftData and saving GameState to the user's device memory disc (ssd)
final class SwiftDataManager {
	
	var context: ModelContext
	
	init(context: ModelContext) {
		self.context = context
	}
	
	// MARK: CRUD for GameState
	
	func deleteGameState() {
		
		
	}
	
	/// We want to use this method to reset game state to default one
	func resetGameState(_ state: GameState) {
		
		do {
			try context.delete(model: GameState.self)
		} catch {
			fatalError("failed to delete Game State")
		}
		
		do {
			try context.save()
		} catch {
			fatalError("failed to save an empty context")
		}
		
		Task {
			try await Task.sleep(for: .seconds(1))
			saveGameState(state)
			print("Saved a new game state")
		}
	}
	
	/// If there is no game state object in SwiftData -> add it and save it
	func saveGameState(_ state: GameState) {
		
		let fetchedState = loadGameState()
		
		if fetchedState == nil {
			context.insert(state)
			print("Got a new state to save")
		}
		
		do {
			try context.save()
			
		} catch {
			fatalError("Failed to save Game State")
		}
	}
	
	/// Attempt to safely load GameState or return nil otherwise
	func loadGameState() -> GameState? {
		
		do {
			// Ask SwiftData to look for an exact data type to fetch
			let descriptor = FetchDescriptor<GameState>()
			let result = try context.fetch(descriptor)
			print("breakpoint 1")
			guard let state = result.first else { return nil }
			print("breakpoint 2")
			return state
			
		} catch {
			fatalError("Failed to Load Main State")
		}
	}
}
