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
			
			buildStats()
			
		case .inventory:
			
			buildInventory()
			
		case .options:
			
			buildOptions()
			
		case .rewards:
			
			buildRewards()
			
		case .miniGame:
			
			MiniGameView { success in
				viewModel.gameState.isMiniGameSuccessful = success
				print(success)
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
					self.viewModel.goToBattle()
				}
			}
			
		case .specialisation:
			
			buildSpecialisation()
			
		case .enemyStats:
			
			buildEnemyStats()
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
				Button("Go To Hero Stats") {
					viewModel.goToHeroStats()
				}
				Button("Go To Inventory") {
					viewModel.goToInventory()
				}
				Button("Go To Town") {
					viewModel.goToTown()
				}
				Button("Go To Options") {
					viewModel.goToOptions()
				}
				Button("Go To Mini Game") {
					viewModel.goToMiniGame()
				}
				Button("Go To Specialisation") {
					viewModel.goToSpecialisation()
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
				Text("Gold - \(viewModel.gameState.goldLootToDisplay)")
				Text("Experience - \(viewModel.gameState.expLootToDisplay)")
			}
			
			Section(header: Text("Loot")) {
				
				ForEach(viewModel.gameState.lootToDisplay, id: \.self) { item in
					Text(item)
				}
				
			}
			
//			Section(header: Text("Upgrades")) {
//				
//				
//			}
//			
//			Section(header: Text("Items to Buy")) {
//				
//				
//			}
			
			Button("Got it") {
				viewModel.getRewardsAndCleanTheScreen()
			}
		}
	}
}

// MARK: - LevelComplete Screen (View)


