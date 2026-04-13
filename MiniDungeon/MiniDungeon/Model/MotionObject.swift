/*
 
 File Contains:
 `enum Direction`
 `struct MotionController`
 `struct MovementScheme`
 
 Purpose of the file construct is to define any motion objects to create mini games in the App like such:
 - Chest LockPicking Mini Game
 - ShadowBallMiniGame
 
 TODO: Create size scheme as well
 TODO: Create predefined animation property for MotionObject
 */

import SwiftUI

// MARK: - Direction

/// Entity to define the direction of the movement
enum Direction {
	
	case top
	case bottom
	case right
	case left
}

/// Position of the object or it's edge/angle on the parent X/Y axis coordinate
struct CGFloatCoordinates {
	
	var coordinateX: CGFloat
	var coordinateY: CGFloat
}

// MARK: - MotionController

/// Entity to define properties of the motion object (Current Object)
struct MotionController {
	
	/// Personal ID to identify what object has been stoped successfully
	var id: Int
	
	/// is object on the move or not
	var isMoving = false
	
	/// Property to track collision with any other objects
	var didCollide = false
	
	/// Is object going up or down
	var direction: Direction = .bottom
	
	var coordinateY: CGFloat = 0.0
	
	var coordinateX: CGFloat = 0.0
	
	/// Points per timer's tick movement object moves
	var velocity: CGFloat = 0.0
	
	/// Start position of the object to move at the Y Axis
	var minRangeY: CGFloat = 0.0
	
	/// End position of the object to move at the Y Axis
	var maxRangeY: CGFloat = 0.0
	
	/// Start position of the object to move at the X Axis
	var minRangeX: CGFloat = 0.0
	
	/// End position of the object to move at the Y Axis
	var maxRangeX: CGFloat = 0.0
	
	var width: CGFloat = 0.0
	
	var height: CGFloat = 0.0
	
	var color: Color = .white
	
	// MARK: Object Angles/Edges coordinate in X/Y axis of the parent view
	
	var leftTopAngleCoordinateX: CGFloat {
		coordinateX - (width / 2)
	}
	
	var rightTopAngleCoordinateX: CGFloat {
		coordinateX + (width / 2)
	}
	
	var leftTopAngleCoordinateY: CGFloat {
		coordinateY - (height / 2)
	}
	
	var rightTopAngleCoordinateY: CGFloat {
		coordinateY + (height / 2)
	}
	
	var leftBottomAngleCoordinateY: CGFloat {
		coordinateY + (height / 2)
	}
	
	var rightBottomAngleCoordinateY: CGFloat {
		coordinateY + (height / 2)
	}
	
	var leftBottomAngleCoordinateX: CGFloat {
		coordinateX - (width / 2)
	}
	
	var rightBottomAngleCoordinateX: CGFloat {
		coordinateX + (width / 2)
	}
	
	var leftTopAngleCoordinates: CGFloatCoordinates {
		
		CGFloatCoordinates(
			coordinateX: leftTopAngleCoordinateX,
			coordinateY: leftTopAngleCoordinateY
		)
	}
	
	var rightTopAngleCoordinate: CGFloatCoordinates {
		
		CGFloatCoordinates(
			coordinateX: rightTopAngleCoordinateX,
			coordinateY: rightTopAngleCoordinateY
		)
	}
	
	var leftBottomAngleCoordinates: CGFloatCoordinates {
		
		CGFloatCoordinates(
			coordinateX: leftBottomAngleCoordinateX,
			coordinateY: leftBottomAngleCoordinateY
		)
	}
	
	var rightBottomAngleCoordinate: CGFloatCoordinates {
		
		CGFloatCoordinates(
			coordinateX: rightBottomAngleCoordinateX,
			coordinateY: rightBottomAngleCoordinateY
		)
	}
}

// MARK: - MovementScheme

/// A single scheme for each motion object moving at the chest lock-picking view (Protocol of how to act)
struct MovementScheme {
	
	/// Is bar will move accordingly to this scheme
	var isMoving: Bool
	
	/// Bar speed to increment/decrement bar's `timeRemaining` property
	var velocity: CGFloat
	
	var coordinateX: CGFloat = 0.0
	
	var coordinateY: CGFloat = 0.0
	
	/// Placed motion object should start from this coordinate of Y Axis
	var minRangeY: CGFloat = 0.0
	
	/// Placed motion object should end at this coordinate of Y Axis
	var maxRangeY: CGFloat = 0.0
	
	/// Placed motion object should start moving at this coordinate of X Axis
	var minRangeX: CGFloat = 0.0
	
	/// Placed motion object should end moving at this coordinate of X Axis
	var maxRangeX: CGFloat = 0.0
}
