import Foundation

/// Data type to define what level of quality an event, bonus or item can appear at the game
enum Rarity: Codable {
	
	case common
	case rare
	case epic
	case legendary
}
