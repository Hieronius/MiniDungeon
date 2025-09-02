import SwiftUI

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
