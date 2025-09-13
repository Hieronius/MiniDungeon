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
			
		case .heroStats:
			
			buildHeroStats()
			
		case .options:
			
			buildOptions()
			
		case .rewards:
			
			buildRewards()
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
				Button("Go To Hero Stats") {
					viewModel.goToHeroStats()
				}
				Button("Go To Options") {
					viewModel.goToOptions()
				}
			}
		}
	}
}

// MARK: - HeroStats Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildHeroStats() -> some View {
		
		List {
			
			Section(header: Text("Hero Stats")) {
				
				Text("Current HP - \(viewModel.gameState.hero.heroCurrentHP)")
				Text("Max HP - \(viewModel.gameState.hero.heroMaxHP)")
				Text("Current MP - \(viewModel.gameState.hero.currentMana)")
				Text("Max MP - \(viewModel.gameState.hero.maxMana)")
				Button("Go To Menu") {
					viewModel.goToMenu()
				}
			}
		}
	}
}

// MARK: - Options Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildOptions() -> some View {
		
		List {
			
			Section(header: Text("Game Options")) {
				
				// Difficulty
				// Speed
				// Other Twicks
			}
		}
	}
}

// MARK: - Rewards Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildRewards() -> some View {
		
		List {
			
			Section(header: Text("Rewards")) {
				
				
			}
			
			Section(header: Text("Upgrades")) {
				
				
			}
		}
	}
}


