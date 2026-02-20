import Foundation

/// Data type to describe object (hero) position on the map matrix
/// Example: heroPosition = Coordinate(row: 0, col: 1)
struct Coordinate: Codable, Equatable {
	
	var row: Int
	var col: Int
}

//extension Coordinate: Equatable {
//	
//	func =(_ lft: Coordinate, _ rht: Coordinate) {
//		
//		return lft.row == rht.row && lft.col == rht.col
//	}
//}
