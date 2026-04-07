/**
 Problem Summary:
 Design a robot that moves along the perimeter of a rectangle of size `width x height`.
 The robot starts at `(0, 0)` facing East. Each call to `step(num)` moves the robot
 `num` steps clockwise along the border. The robot reports its current position and direction.

 Strategy:
 - Precompute the full perimeter path in clockwise order as:
   bottom edge → right edge → top edge → left edge.
 - For each perimeter cell, also store the direction the robot should face when standing there
   *after moving*.
 - Track the robot’s current index on this perimeter path.
 - Movement is handled by modular arithmetic:
   `currentIndex = (currentIndex + num) % perimeterLength`.

 Key Direction Edge Case:
 - At initialization, the robot is at `(0, 0)` and must face East.
 - However, after the robot completes a full loop and returns to `(0, 0)`, it should face South.
 - To support this, we store the direction at index `0` as South, and use a `hasMoved` flag:
   - Before any movement: return "East"
   - After at least one movement: return the precomputed direction

 Time Complexity:
 - init: O(width + height), because we build the perimeter once.
 - step: O(1)
 - getPos: O(1)
 - getDir: O(1)

 Space Complexity:
 - O(width + height), for storing the perimeter positions and directions.
 */
class Robot {
    // Precomputed perimeter positions in clockwise order.
    private let perimeterPositions: [(x: Int, y: Int)]

    // Direction at each perimeter position after movement:
    // 0 = East, 1 = North, 2 = West, 3 = South
    private let perimeterDirections: [Int]

    private let directionNames = ["East", "North", "West", "South"]

    // Current index on the perimeter path.
    private var currentIndex: Int = 0

    // Tracks whether step(_) has ever been called.
    private var hasMoved: Bool = false

    init(_ width: Int, _ height: Int) {
        // Build bottom edge (moving East): (0,0) -> (width-1,0)
        let bottomEdge = (0..<width).map { x in ((x, 0), 0) }

        // Build right edge (moving North): (width-1,1) -> (width-1,height-1)
        let rightEdge = (1..<height).map { y in ((width - 1, y), 1) }

        // Build top edge (moving West): (width-2,height-1) -> (0,height-1)
        let topEdge = (0..<(width - 1)).reversed().map { x in ((x, height - 1), 2) }

        // Build left edge (moving South): (0,height-2) -> (0,1)
        let leftEdge = (1..<(height - 1)).reversed().map { y in ((0, y), 3) }

        // Combine all perimeter segments into one cyclic path.
        let perimeter = bottomEdge + rightEdge + topEdge + leftEdge

        // Separate positions and directions for faster access.
        let positions = perimeter.map { $0.0 }
        var directions = perimeter.map { $0.1 }

        // At (0,0), after completing a loop, the robot should face South.
        // We handle the initial "East" direction using `hasMoved`.
        if !directions.isEmpty {
            directions[0] = 3
        }

        self.perimeterPositions = positions
        self.perimeterDirections = directions
    }

    func step(_ num: Int) {
        hasMoved = true

        // Move forward `num` steps around the perimeter cyclically.
        currentIndex = (currentIndex + num) % perimeterPositions.count
    }

    func getPos() -> [Int] {
        let position = perimeterPositions[currentIndex]
        return [position.x, position.y]
    }

    func getDir() -> String {
        // Before any movement, the robot must report East.
        if !hasMoved {
            return "East"
        }

        return directionNames[perimeterDirections[currentIndex]]
    }
}

/**
 * Your Robot object will be instantiated and called as such:
 * let obj = Robot(width, height)
 * obj.step(num)
 * let ret_2: [Int] = obj.getPos()
 * let ret_3: String = obj.getDir()
 */