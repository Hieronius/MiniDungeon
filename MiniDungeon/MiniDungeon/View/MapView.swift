import SwiftUI

// MARK: - Dungeon Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildDungeon() -> some View {
		
		Spacer()
		
		VStack {
			
			HStack {
				
				Spacer()
				Text("Battles won - \(viewModel.gameState.battlesWon)")
				Spacer()
				Text("Gold - \(viewModel.gameState.heroGold)")
				Spacer()
			}
			
			HStack {
				
				Spacer()
				Text("Hero's lvl - \(viewModel.gameState.hero.heroLevel)")
				Spacer()
				Text("XP - \(viewModel.gameState.heroCurrentXP) / \(viewModel.gameState.heroMaxXP)")
				Spacer()
			}
			
			Text("Orbs - \(viewModel.gameState.orbesCollected) / \(viewModel.gameState.orbesCollected)")
		}
		
		Spacer()
		
		Spacer()
		
		getDungeonMap()
		
		Spacer()
		
		List {
			
			Section(header: Text("Navigation")) {
				
				Button("Go To Next Level") {
					viewModel.checkForMapBeingExplored()
				}
				Button("Go To Rewards") {
					viewModel.goToRewards()
				}
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
