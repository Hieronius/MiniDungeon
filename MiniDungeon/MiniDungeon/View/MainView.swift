import SwiftUI

struct MainView: View {
	
	// MARK: - Dependencies
	
	@StateObject var viewModel: MainViewModel
	
	// MARK: - Initialization
	
	init(viewModel: MainViewModel) {
		_viewModel = StateObject(wrappedValue: viewModel)
	}
	
	// MARK: - Body
	
    var body: some View {
        
		switch viewModel.gameScreen {
			
		case .menu:
			
			buildMenu()
			
		case .battle:
			
			buildBattle()
			
		case .dungeon:
			
			buildDungeon()
		
		case .town:
			
			buildTown()
		}
    }
}

// MARK: - Menu Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildMenu() -> some View {
		
		List {
			
			Section(header: Text("It's a Menu")) {
				
				Button("Go To Battle") {
					viewModel.goToBattle()
				}
				Button("Go To Dungeon") {
					viewModel.goToDungeon()
				}
				Button("Go To Town") {
					viewModel.goToTown()
				}
			}
		}
	}
}

// MARK: - Battle Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildBattle() -> some View {
		
		// MARK: UI
		
		Spacer()
		
		Text(viewModel.gameState.isHeroTurn ? "Hero Turn" : "Enemy Turn")
		
		Spacer()
		
		HStack {
			
			Spacer()
			
			VStack {
				
				Text("\(viewModel.gameState.heroCurrentHP) / \(viewModel.gameState.heroMaxHP)")
				Rectangle()
					.frame(width: 80, height: 80)
			}
			
			Spacer()
			
			VStack {
				
				Text("\(viewModel.gameState.enemyCurrentHP) / \(viewModel.gameState.enemyMaxHP)")
				Rectangle()
					.frame(width: 80, height: 80)
			}
			
			Spacer()
		}
		
		Spacer()
		
		// MARK: Actions
		
		List {
			
			Section(header: Text("Actions")) {
				
				Button("Attack") {
					viewModel.attack()
				}
				
				Button("End Turn") {
					viewModel.endTurn()
				}
				
				Button("Restore Stats") {
					viewModel.restoreStats()
				}
			}
			
			// MARK: Navigation
			
			Section(header: Text("Navigation")) {
				
				Button("Go To Dungeon") {
					viewModel.goToDungeon()
				}
				Button("Go To Town") {
					viewModel.goToTown()
				}
				Button("Go To Menu") {
					viewModel.goToMenu()
				}
			}
		}
	}
}

// MARK: - Dungeon Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildDungeon() -> some View {
		
		List {
			
			Section(header: Text("It's a Dungeon")) {
				
				Button("Go To Battle") {
					viewModel.goToBattle()
				}
				Button("Go To Town") {
					viewModel.goToTown()
				}
				Button("Go To Menu") {
					viewModel.goToMenu()
				}
			}
		}
	}
}

// MARK: - Town Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildTown() -> some View {
		
		List {
			
			Section(header: Text("It's a Town")) {
				
				Button("Go To Battle") {
					viewModel.goToBattle()
				}
				Button("Go To Dungeon") {
					viewModel.goToDungeon()
				}
				Button("Go To Menu") {
					viewModel.goToMenu()
				}
			}
		}
	}
}

