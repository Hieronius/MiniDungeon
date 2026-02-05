import SwiftUI
import SwiftData

@main
struct MiniDungeonApp: App {
	
	@Environment(\.scenePhase) private var scenePhase
	
	var modelContainer: ModelContainer
	var swiftDataManager: SwiftDataManager
	
	@State var viewModel: MainViewModel
	
	init() {
		
		do {
			let container = try ModelContainer(for: GameState.self,
													 Hero.self,
											   Flask.self)
			
			self.modelContainer = container
			
			let manager = SwiftDataManager(context: container.mainContext)
			self.swiftDataManager = manager
			
			let gameState: GameState
			
			if let fetchedState = swiftDataManager.loadGameState() {
				gameState = fetchedState
				gameState.isFreshSession = false
				print("Game State has been load from the disc")
				
			} else {
				
				let flask = Flask()
				let hero = Hero(flask: flask)
				
				let freshGameState = GameState(hero: hero)
				gameState = freshGameState
				gameState.isFreshSession = true
				swiftDataManager.saveGameState(gameState)
				print("Fresh Game State has been started")
			}
			
			let dungeonGenerator = DungeonGenerator()
			let gameScreen = GameScreen.menu
			
			let viewModel = MainViewModel(
				swiftDataManager: manager,
				dungeonGenerator: dungeonGenerator,
				gameState: gameState,
				gameScreen: gameScreen
			)
			
			_viewModel = State(initialValue: viewModel)
			
		} catch {
			fatalError("Failed to initialise ModelContainer")
		}
	}
	
    var body: some Scene {
        WindowGroup {
			MainView(viewModel: viewModel)
			
				// MARK: Debug Method to Track App Life Cycle
			
				.onChange(of: scenePhase) { oldPhase, newPhase in
					switch newPhase {
					case .background:
						print("SchenePhase: Background from \(oldPhase)")
						
						// This code store current DungeonMap State (which is @Transient) to duplicate property in GameState which is being totally tracked and saved
						// TODO: Probably should be duplicated in .inactive state
						viewModel.gameState.dungeonMapInMemory = viewModel.gameState.dungeonMap
						swiftDataManager.saveGameState(viewModel.gameState)
						print("YES WE DID SAVE DUNGEON MAP TO DUPLICATE PROPERTY")
						
					case .inactive:
						print("SchenePhase: Inactive from \(oldPhase)")
						
					case .active:
						print("SchenePhase: Active/Foreground from \(oldPhase)")
						
					@unknown default:
						print("SchenePhase: Unknown scene phase \(newPhase) from \(oldPhase)")
					}
				}
        }
		
    }
}
