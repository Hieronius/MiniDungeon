import Foundation

/// Single Game Tile of the DungeonMap
struct Tile: Codable {

	var coordinate: Coordinate

	/// Corridor or Room or any other types we create in the future
	var type: TileType

	/// Should be marked if the hero already been here
	var isExplored: Bool

	/// A single or multiple events such as Enemy -> Quest -> Reward
	var events: [EventType]
	
	/// This property should be the flag to provide an animation when it change to true
	var wasTapped = false
}

// MARK: removeAllEvents

extension Tile {
	
	mutating func removeAllEvents() {
		self.events = []
	}
}

// MARK: isHeroPosition

extension Tile {
	
	func isHeroPosition(_ heroPosition: Coordinate) -> Bool {
		return (self.coordinate.row == heroPosition.row) &&
		self.coordinate.col == heroPosition.col
	}
}

// MARK: isUnknownTilePosition

extension Tile {
	
	func isUnknownTilePosition(_ tilePosition: Coordinate) -> Bool {
		return (self.coordinate.row == tilePosition.row) &&
		self.coordinate.col == tilePosition.col
	}
}

extension Tile: Equatable {
	
	static func ==(lhs: Tile, rhs: Tile) -> Bool {
		return lhs.coordinate.row == rhs.coordinate.row &&
		lhs.coordinate.col == rhs.coordinate.col
		
	}
}
