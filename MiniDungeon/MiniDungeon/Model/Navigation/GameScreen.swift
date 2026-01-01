import Foundation

/// Entity to define all possible screens in the game
enum GameScreen: Codable {
	
	case menu
	case battle
	case dungeon
	case town
	case heroStats
	case enemyStats
	case inventory
	case rewards
	case options
	case combatMiniGame
	case trapDefusionMiniGame
	case chestLockPickingMiniGame
	case specialisation
	case merchant
	case levelBonus
}
