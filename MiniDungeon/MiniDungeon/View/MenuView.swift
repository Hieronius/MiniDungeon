import SwiftUI

// MARK: - Menu Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildMenuView() -> some View {
		
		List {
			
			Section(header: Text(isEnglish() ? "Menu" : "Меню")) {
				
				Button(isEnglish() ? "Dungeon" : "Подземелье") {
					viewModel.goToDungeon()
				}
				
			}
			
			Section(header: Text(isEnglish() ? "Options": "Настройки")) {
				
				Button(isEnglish() ? "Start New Game" : "Начать Новую Игру") {
					viewModel.resetGameStateToDefault()
					viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
				}
			}
		}
	}
}
