import SwiftUI

// MARK: - Menu Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildMenu() -> some View {
		
		List {
			
			Section(header: Text("It's a Menu")) {
				
				Button("Dungeon") {
					viewModel.goToDungeon()
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
}
