import SwiftUI

// MARK: - Menu Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildMenuView() -> some View {
		
		List {
			
			Section(header: Text("Menu")) {
				
				Button("Dungeon") {
//					viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
					viewModel.goToDungeon()
				}
				
//				Button("Joystick View") {
//					
//					viewModel.goToJoystickView()
//				}
				
//				Button("CoinFlipMiniGame") {
//					
//					viewModel.goToCoinFlipMiniGame()
//				}
//				
//				Button("Level Perks") {
//					
//					viewModel.goToLevelPerk()
//				}
//				
//				Button("Test Collision View") {
//					
//					viewModel.goToTestCollisionView()
//				}
				
//				Button("Stats Recovery View") {
//					viewModel.goToStatsRecovery()
//				}
//				
//				Button("Merchant View") {
//					viewModel.goToMerchant()
//				}
				
				//				Button("Evasion Mini Game") {
				//					viewModel.goToEvasionMiniGame()
				//				}
				//
//								Button("Build Shadow Mini Game") {
//									viewModel.goToShadowBallMiniGame()
//								}
				
				//				Button("Build Shadow Flask") {
				//					viewModel.goToFlask()
				//				}
				// MARK: Uncomment to Erase and Insert a new Game State
				//				Button("Erase Game State") {
				//					let flask = Flask()
				//					let hero = Hero(flask: flask)
				//					let newState = GameState(hero: hero)
				//					viewModel.gameState = newState
				//					viewModel.swiftDataManager.saveGameState(newState)
				//					viewModel.generateMap()
				//					viewModel.spawnHero()
				//				}
				
				//				Button("Test Chest Lock Picking Mini Game") {
				//					viewModel.goToChestLockPickingMiniGame()
				//				}
				
				//				Button("Test Combat Mini Game") {
				//					viewModel.goToCombatMiniGame()
				//				}
				
				//				Button("Test Trap Defusion Mini Game") {
				//					viewModel.goToTrapDefusionMiniGame()
				//				}
				
				//				Button("Test Shadow Ball Mini Game") {
				//					viewModel.goToShadowBallMiniGame()
				//				}
				
				//				Button("Test Battle Screen") {
				//					viewModel.goToBattle()
				//				}
				
//								Button("Test Timeline View") {
//									viewModel.goToTestTimelineView()
//								}
				
			}
		}
	}
}
