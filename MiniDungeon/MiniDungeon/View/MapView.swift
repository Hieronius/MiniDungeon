import SwiftUI

// MARK: - Dungeon Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildDungeon() -> some View {
		
		Spacer()
		
		VStack {
			
			HStack {
				Spacer()
				Text("Dungeon Level: \(viewModel.gameState.currentDungeonLevel + 1)")
				Spacer()
				Text("Battles won: \(viewModel.gameState.battlesWon)")
				Spacer()
			}
			
			HStack {
				
				Spacer()
				Text("Dark Energy: \(viewModel.gameState.heroDarkEnergy)")
				Spacer()
				Text("Gold: \(viewModel.gameState.heroGold)")
				Spacer()
			}
			
			HStack {
				
				Spacer()
				Text("Hero's lvl: \(viewModel.gameState.hero.heroLevel)")
				Spacer()
				Text("XP: \(viewModel.gameState.hero.currentXP) / \(viewModel.gameState.hero.maxXP)")
				Spacer()
			}
			
		}
		
		Spacer()
		
		Spacer()
		
		getDungeonMap()
		
		Spacer()
		
		List {
			
			Section(header: Text("Navigation")) {
				
				// If Hero has 0 dark energy it's a game over
				if viewModel.gameState.heroDarkEnergy <= 0 {
					Button("No More Dark Energy To Move - Start Over") {
						viewModel.setupNewGame()
					}
					.foregroundStyle(.red)
				}
				
				if viewModel.checkMapForAllEventsToBeExplored() {
					Button("Summon Level Boss") {
						viewModel.summonBoss()
					}
					.foregroundStyle(.purple)
				}
				
				Button("Stats") {
					viewModel.goToHeroStats()
				}
				Button("Inventory") {
					viewModel.goToInventory()
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
		let neighbours = viewModel.checkForHeroTileNeighbours()
		let tileColor: Color = isHeroPosition ? .orange : originalBackgroundColor
		var title: String
		var opacityRatio: CGFloat = 1.0
		
		// MARK: Just comment all checks to manage map generation

		
		// 1. If not a hero Position and is not explored - create the fog of war

		if isHeroPosition == false && tile.isExplored == false  { opacityRatio = 0.01 }
		
		// 2. Hero can see through a single tile around him
		
		if neighbours.contains(tile) {
			opacityRatio = 1.0
		}
		
		// 3. Because empty tiles mean "Empty" make them totally opaque
		
		if tile.type == .empty { opacityRatio = 0.01 }

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
