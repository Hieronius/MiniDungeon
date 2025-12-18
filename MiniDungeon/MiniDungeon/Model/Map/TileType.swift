import Foundation

/// A type of the game tile in the dungeon map
/// Codable conformance for SwiftData Models possible use
enum TileType: Codable {

	/// Square one and probably should be used to put enemies
	case room

	/// Rectangle one for small events like quests, riddles, traps or rewards
	case corridor
	
	/// An event to try to defuse the trap
	case trap
	
	/// Event to host Shrine of Recovery (health + mana/some damage/shadow flask charge)
	case restoration
	
	/// Event to disenchant an item (not potion) to dark energy in a specific rate
	case disenchant

	/// We use it to create black spots on the map matrix so user can't enter them
	case empty
	
	/// Case for a tile with Chest or Loot option
	case chest
	
	/// Case for encountering Secret Rooms
	case secret
}
