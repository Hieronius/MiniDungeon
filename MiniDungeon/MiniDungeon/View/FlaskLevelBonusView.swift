/*
 This view should mirror the same logic as HeroLevelBonus
 
 - Throw 3 different bonuses to choose each level up of the flask
 - Remove at the start of each session
 */


import SwiftUI

// MARK: - FlaskLevelBonusView

extension MainView {
	
	@ViewBuilder
	func buildFlaskLevelBonusView() -> some View {
		
		VStack {
			
			List {
				
				Section(header: Text("Flask Level Bonus")) {
					
					ForEach(viewModel.gameState.flaskLevelBonusesToChoose.compactMap { $0 }) { bonus in
						Button(bonus.name) {
							viewModel.gameState.flaskLevelBonusToDisplay = bonus
						}
					}
				}
				
				if viewModel.gameState.flaskLevelBonusToDisplay != nil {
					Section(header: Text("Description")) {
						Text("Name - \(viewModel.gameState.flaskLevelBonusToDisplay?.name ?? "")")
							.bold()
						Text("Description:  \(viewModel.gameState.flaskLevelBonusToDisplay?.bonusDescription ?? "")")
						Button("Choose") {
							viewModel.applyFlaskLevelBonus(viewModel.gameState.flaskLevelBonusToDisplay)
						}
					}
					}
				}
			}
		}
	}
