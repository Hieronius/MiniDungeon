import Foundation

// MARK: - DungeonGenerator

/// An entity to parse an existing dungeon level scheme or generate a unique set of tiles for each dungeon level
struct DungeonGenerator {
	
	// MARK: - Methods
	
	
	
	// MARK: - Parsing of DungeonScheme
	
	
	
	// MARK: ParseDungeonLevel
	
	/// Method to get a predefined level scheme and convert into real dungeon level
	func parseDungeonLevel(_ levelScheme: [[String]]) -> [[Tile]] {
		
		let rows = levelScheme.count
		let cols = levelScheme[0].count
		
		let defaultTile = Tile(
			row: 0,
			col: 0,
			type: .empty,
			isExplored: false,
			events: []
		)
		
		var level: [[Tile]] = Array(repeating: Array(repeating: defaultTile,
													 count: cols),
									count: rows)
		
		for row in 0..<rows {
			
			for col in 0..<cols {
				
				let tileType = levelScheme[row][col]
				level[row][col] = generateTile(row, col, tileType)
			}
		}
		
		return level
	}
	
	// MARK: GenerateTile
	
	/// Method to get an exact coordinates and tile type to generate a complete Tile
	func generateTile(_ row: Int, _ col: Int, _ type: String) -> Tile {
		
		switch type {
			
		case "R": return Tile(row: row,
							  col: col,
							  type: .room,
							  isExplored: false,
							  events: [.enemy])
			
		case "C": return Tile(row: row,
							  col: col,
							  type: .corridor,
							  isExplored: false,
							  events: [])
			
		case "E": return Tile(row: row,
							  col: col,
							  type: .empty,
							  isExplored: false,
							  events: [])
			
		default: return Tile(row: row,
							 col: col,
							 type: .empty,
							 isExplored: false,
							 events: [])
			
		}
	}
}
