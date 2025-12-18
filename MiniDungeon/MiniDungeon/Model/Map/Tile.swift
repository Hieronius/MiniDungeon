import Foundation

/// Single Game Tile of the DungeonMap
struct Tile {

	/// Row position on the map
	var row: Int

	/// Column position on the map
	var col: Int

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
	
	func isHeroPosition(_ heroPosition: (Int, Int)) -> Bool {
		return (self.row, self.col) == heroPosition
	}
}

extension Tile: Equatable {
	
	static func ==(lhs: Tile, rhs: Tile) -> Bool {
		return lhs.row == rhs.row && lhs.col == rhs.col
		
	}
}
