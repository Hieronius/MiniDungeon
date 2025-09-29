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

// MARK: - Stats Screen (View)

extension MainView {
	
	/// Try to collect all stats/skills and such into structs inside Hero class so you can use something like Lise(gameState.hero.Stats.\.self
	@ViewBuilder
	func buildStats() -> some View {
		
		List {
			
			Section(header: Text("Hero Stats")) {
				
				Text("Current HP - \(viewModel.gameState.hero.currentHP)")
				Text("Max HP - \(viewModel.gameState.hero.maxHP)")
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

// MARK: - Specialisation Screen (View)

extension MainView {
	
	/*
	 Method to generate specialisation
	 Method to choose 3 of random ones
	 Method to apply one to the hero
	 
	 View should get a text and an image probably to describe it's value
	 */
	
	func buildSpecialisation() -> some View {
		
		VStack {
			
			List {
				Text("Name - \(viewModel.gameState.specToDisplay?.name ?? "")")
				Text("Description - \(viewModel.gameState.specToDisplay?.description ?? "")")
			}
			
			List {
				
				ForEach(SpecialisationManager.getThreeRandomSpecialisations(), id: \.self) { spec in
					
					Button(spec.name) {
						viewModel.applySpecialisation(spec)
						viewModel.goToMenu()
					}
				}
			}
		}
	}
}

// MARK: - LevelComplete Screen (View)


