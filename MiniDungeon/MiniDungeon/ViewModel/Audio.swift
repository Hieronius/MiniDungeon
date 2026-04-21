import Foundation

enum GameMusic: Codable, CaseIterable {
	
	case none
	case dungeon
	case battle
	case town
}

extension MainViewModel {
	
	// MARK: - playAttackSound
	
	func playAttackSound(didMissHit: Bool) {
		
		if didMissHit {
			audioManager.playSound(fileName: "hitMissSound2", extensionName: "mp3")
			print("miss sound")
			
		} else {
			
			let soundRoll = Int.random(in: 1...3)
			
			switch soundRoll {
				
			case 1:
				audioManager.playSound(fileName: "swordSound", extensionName: "mp3")
				print("case 1 - sword sound")
				
			case 2:
				audioManager.playSound(fileName: "meleeSound", extensionName: "mp3")
				print("case 2 - melee sound")
				
			case 3:
				audioManager.playSound(fileName: "animalSound", extensionName: "mp3")
				print("case 3 - animal sound")
				
			default:
				audioManager.playSound(fileName: "swordSound", extensionName: "mp3")
				print("default case - sword sound")
			}
		}
	}
}
