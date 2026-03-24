import SwiftUI

/// Data type to define what level of quality an event, bonus or item can appear at the game
enum Rarity: Codable {
	
	case common
	case rare
	case epic
	case legendary
	
	/// Dynamic property to define to what color we want to highlight our item/talant/perk
	var color: Color {
		
		switch self {
		case .common: return .white
		case .rare: return .blue
		case .epic: return .purple
		case .legendary: return .orange
		}
	}
}
