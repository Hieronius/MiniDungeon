import Foundation

/// Data type to describe object (hero) position on the map matrix
/// Example: heroPosition = Coordinate(row: 0, col: 1)
struct Coordinate: Codable {
	
	var row: Int
	var col: Int
}
