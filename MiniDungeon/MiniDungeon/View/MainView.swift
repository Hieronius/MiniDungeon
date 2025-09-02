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
			
		case .battle:
			
			List {
				
				Section(header: Text("It's a Battle")) {
					
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
			
		case .dungeon:
			
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
		
		case .town:
			
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
}
