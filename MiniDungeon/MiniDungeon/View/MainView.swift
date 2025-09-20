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
			
		case .stats:
			
			buildStats()
			
		case .inventory:
			
			buildInventory()
			
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
			}
		}
	}
}

// MARK: - Stats Screen (View)

extension MainView {
	
	/// Try to collect all stats/skills and such into structs inside Hero class so you can use something like Lise(gameState.hero.Stats.\.self
	@ViewBuilder
	func buildStats() -> some View {
		
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

// MARK: - Inventory Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildInventory() -> some View {
		
		// TODO: Remove the gap between item info section and items
		
		List {
			
			Section(header: Text("Item Info")) {
				
				Text("Item Name - \(viewModel.gameState.itemToDisplay?.label ?? "")")
				Text("Item Level - \(viewModel.gameState.itemToDisplay?.itemLevel ?? 0)")
				Text("Description - \(viewModel.gameState.itemToDisplay?.description ?? "")")
			}
			
		}
		
		
		List {
			
			Section(header: Text("Weapons")) {
				
				ForEach(viewModel.gameState.hero.weapons) { weapon in
					Button(weapon.label) {
						viewModel.gameState.itemToDisplay = weapon
					}
				}
			}
			
			Section(header: Text("Armors")) {
				
				ForEach(viewModel.gameState.hero.armors) { armor in
					Button(armor.label) {
						viewModel.gameState.itemToDisplay = armor
					}
				}
			}
			
			Section(header: Text("Items")) {
				
				ForEach(viewModel.gameState.hero.inventory) { item in
					Button(item.label) {
						viewModel.gameState.itemToDisplay = item
					}
				}
			}
			
			Section(header: Text("Navigation")) {
				
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


