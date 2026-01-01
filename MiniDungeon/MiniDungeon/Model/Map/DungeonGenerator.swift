import Foundation

/*
 MARK: Characters Transcription

 "M" - Hero Position
 "R" - Room
 "C" - Corridor
 "E" - Empty Spot
 "H" - Restoration Shrine
 "L" - Chest
 "S" - Secret
 "T" - Trap
 
 Types to add:
 
 "F" - Fight with Enemy
 "G" - Item/Gold/Chest
 "Q" - Quest/Riddle
 
 // MARK: LEVEL COMPOSITION
 
 11 level - 7 x 7 = 49 tiles
 let dungeonLevel11: [[String]] = [
 
	 ["E", "R", "R", "C", "E", "R", "C"],
	 ["R", "C", "E", "C", "C", "R", "C"],
	 ["E", "E", "E", "E", "E", "C", "R"],
	 ["C", "R", "C", "C", "E", "C", "C"],
	 ["C", "E", "E", "C", "C", "R", "C"],
	 ["R", "C", "C", "E", "E", "E", "R"],
	 ["E", "E", "R", "E", "E", "E", "E"]
 ]
 
 MARK: IPHONE 15 PRO CAN'T STORE 64 TILES
 12 level - 8 x 8 = 64 tiles
 let dungeonLevel12: [[String]] = [
 
	 ["E", "R", "R", "C", "E", "R", "C", "E"],
	 ["R", "C", "E", "C", "C", "R", "C", "R"],
	 ["E", "E", "E", "E", "E", "C", "R", "E"],
	 ["C", "R", "C", "C", "E", "C", "C", "C"],
	 ["C", "E", "E", "C", "C", "R", "E", "E"],
	 ["R", "C", "C", "E", "E", "E", "R", "R"],
	 ["E", "E", "R", "E", "E", "E", "E", "E"],
	 ["E", "R", "R", "C", "E", "R", "C", "R"],
 ]
 
 */

// MARK: - DungeonGenerator

/// An entity to parse an existing dungeon level scheme or generate a unique set of tiles for each dungeon level
struct DungeonGenerator {
	
	// MARK: ParseDungeonLevel
	
	/// Method to get a predefined level scheme and convert into real dungeon level
	func parseDungeonLevel(_ levelScheme: [[String]]) -> [[Tile]] {
		
		let rows = levelScheme.count
		let cols = levelScheme[0].count
		
		let defaultTile = Tile(
			coordinate: Coordinate(row: 0, col: 0),
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
	/// If you need to add a shrine, shop or any other event - use this method
	func generateTile(_ row: Int, _ col: Int, _ type: String) -> Tile {
		
		switch type {
			
		case "R": return Tile(coordinate: Coordinate(row: row,
													 col: col),
							  type: .room,
							  isExplored: false,
							  events: [.enemy])
			
		case "C": return Tile(coordinate: Coordinate(row: row,
													 col: col),
							  type: .corridor,
							  isExplored: false,
							  events: [])
			
		case "L": return Tile(coordinate: Coordinate(row: row,
													 col: col),
							 type: .chest,
							 isExplored: false,
							 events: [.chest])
			
		case "T": return Tile(coordinate: Coordinate(row: row,
													 col: col),
							  type: .trap,
							  isExplored: false,
							  events: [.trap])
			
		case "H": return Tile(coordinate: Coordinate(row: row,
													 col: col),
							  type: .restoration,
							  isExplored: false,
							  events: [.restoration])
			
		case "E": return Tile(coordinate: Coordinate(row: row,
													 col: col),
							  type: .empty,
							  isExplored: false,
							  events: [])
			
		case "D": return Tile(coordinate: Coordinate(row: row,
													 col: col),
							  type: .disenchant,
							  isExplored: false,
							  events: [.disenchant])
			
		default: return Tile(coordinate: Coordinate(row: row,
													col: col),
							 type: .empty,
							 isExplored: false,
							 events: [])
			
		}
	}
}
