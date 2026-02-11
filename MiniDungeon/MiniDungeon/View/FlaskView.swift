import SwiftUI

/*
 MARK: Algorithm to implement DragAndDrop
 
 - Create ViewContainer with an image and text
 - Use dynamic offset for an entire screen to calculate coordinates
 - Put current view coordinates to memory/gameState/ViewModel to persist across sessions
 - Pin FlaskView with simultaneousGesture( _ gesture: Gesture) to allow tapping and dragging at the same time
 - Create local @State property in MainView to track
 - When Flask being droped, increment initial coordinates by ghost coordinates value
 - Set temporary ghost position to .zero to renew it's value and prepare for next dragDrop operation
 */

extension MainView {
	
	@ViewBuilder
	func buildShadowFlaskView() -> some View {

			HStack {
				ZStack {
					
					// YOU DOES NOT NEED A RECT() TO START MAKING A CIRCLE ANYMORE
					Circle()
						.fill(.black )
						.strokeBorder(viewModel.gameState.didFlaskGetLevelUP ? .yellow : .white, lineWidth: viewModel.gameState.didFlaskGetLevelUP ? 5 : 1)
						.frame(width: viewModel.gameState.didFlaskGetLevelUP ? 60 : 50, height: viewModel.gameState.didFlaskGetLevelUP ? 60 : 50)
					
					Button(
						action: {
							// MARK: If isLevelUP && not in combat = false -> change battle mode
							// Otherwise get to level up screen
							if viewModel.gameState.didFlaskGetLevelUP && viewModel.gameState.currentGameScreen != .battle {
								
								// let user know that we dealt with level up
								viewModel.gameState.didFlaskGetLevelUP = false
								viewModel.generateLevelBonusesAfterFlaskLevelUpAndGoToLevelBonusScreen()
								// go to flask level bonus screen
							} else {
								flaskBeingTapped.toggle()
								viewModel.gameState.hero.flask.toggleBattleMode()
								print(viewModel.gameState.hero.flask.battleMode)
							}
						},
						label: {
							Image(systemName: "waterbottle")
								.resizable() // 1. Allow the image to scale
								.aspectRatio(contentMode: .fit) // 2. Keep the bottle shape
								.frame(width: flaskBeingTapped ? 40 : 40, height: 40) // 3. Set the icon size
								.symbolEffect(.bounce.up.byLayer, value: viewModel.gameState.hero.flask.battleMode)
								.foregroundStyle(viewModel.gameState.hero.flask.battleMode == .offensive ? .red : .green)
						}
					)
					.frame(width: 40, height: 40)
				}
				.frame(width: 60)
				.animation(
					.bouncy(), value: viewModel.gameState.didFlaskGetLevelUP
				)
				Text(viewModel.gameState.hero.flask.currentComment.rawValue)
					.frame(width: 150)
			}
	}
}
