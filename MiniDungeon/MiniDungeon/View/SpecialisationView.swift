import SwiftUI

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
				
				Section(header: Text("Specialisation")) {
					ForEach(viewModel.gameState.specsToChooseAtStart, id: \.self) { spec in
						Button(spec.name) {
							viewModel.gameState.specToDisplay = spec
						}
					}
				}
				
				if viewModel.gameState.specWasSelected {
					Section(header: Text("Description")) {
						Text("Name: \(viewModel.gameState.specToDisplay?.name ?? "")")
							.bold()
						Text("Description: \(viewModel.gameState.specToDisplay?.description ?? "")")
						Button("Choose") {
							viewModel.applySpecialisation(viewModel.gameState.specToDisplay)
						}
					}
				}
			}
		}
	}
}
