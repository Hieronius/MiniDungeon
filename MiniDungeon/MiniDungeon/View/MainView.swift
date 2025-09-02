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
		
		Spacer()
		
		getDungeonMap()
		
		Spacer()
		
		List {
			
			Section(header: Text("Navigation")) {
				
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
	
	// MARK: Get Dungeon Map

	@ViewBuilder
	func getDungeonMap() -> some View {

		VStack {

			ForEach(viewModel.gameState.dungeonMap.indices, id: \.self) { row in

				HStack {

					ForEach(viewModel.gameState.dungeonMap[row].indices, id: \.self) { col in

						let tile = viewModel.gameState.dungeonMap[row][col]

						getTileButton(tile: tile) {

							viewModel.handleTappedDirection(row, col)

							print("taped the tile")

						}
					}
				}
			}
		}
	}

	// TODO: Transform to struct TileView
	// MARK: Tile Button View

	func getTileButton(tile: Tile, action: @escaping () -> Void) -> some View {

		// If starting point is empty it should not be the starting point

		let originalBackgroundColor: Color = tile.isExplored ? .gray : .white
		let isHeroPosition = tile.isHeroPosition(viewModel.gameState.heroPosition)
		let tileColor: Color = isHeroPosition ? .orange : originalBackgroundColor
		var title: String
		var opacityRatio: CGFloat = 1.0

		// Just turn this property to 0 for complete hidden state of the button

		if tile.type == .empty { opacityRatio = 0.1 }

		switch tile.type {
		case .room:
			title = "R"
		case .corridor:
			title = "C"
		case .empty:
			title = "E"
		}

		return Button(title, action: action)
			.frame(width: 50, height: 50)
			.buttonStyle(.bordered)
			.font(.title2)
			.foregroundColor(tileColor)
			.opacity(opacityRatio)
	}
}

struct TileView: View {

	let row: Int
	let column: Int
	let isExplored: Bool
	let heroPosition: Bool

	var body: some View {

		Button("Tile") { print("Tile pressed") }
			.buttonStyle(.bordered)
			.font(.title2)
			.foregroundColor(.white)
		
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

