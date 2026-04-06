class Solution {
    /**
     Problem Summary:
     A robot starts at (0, 0) facing north. It receives a list of commands:
     - Positive integers: move forward that many steps
     - -1: turn right (90°)
     - -2: turn left (90°)
     
     The robot must avoid obstacles. If it encounters one, it stops moving for that command.
     Return the maximum Euclidean distance squared from the origin reached at any point.

     Strategy:
     - Represent direction as a vector (dx, dy)
     - Use a Set to store obstacles for O(1) lookup
     - Process each command:
        - Rotate direction for -1 / -2
        - Move step-by-step for forward commands, checking obstacles at each step
     - Track the maximum distance squared after each command

     Time Complexity:
     O(N + K), where:
     - N = number of commands
     - K = total steps moved (sum of forward commands)

     Space Complexity:
     O(M), where M = number of obstacles
     */

    func robotSim(_ commands: [Int], _ obstacles: [[Int]]) -> Int {
        // Convert obstacles into a set for fast lookup
        let obstacleSet = Set(obstacles)

        // Robot starts at origin facing north
        var position = [0, 0]
        var direction = [0, 1] // (dx, dy)

        var maxDistanceSquared = 0

        for command in commands {
            switch command {

            case -2:
                // Rotate left: (dx, dy) -> (-dy, dx)
                direction = [-direction[1], direction[0]]

            case -1:
                // Rotate right: (dx, dy) -> (dy, -dx)
                direction = [direction[1], -direction[0]]

            default:
                // Move forward step-by-step
                for _ in 0..<command {
                    let nextPosition = [
                        position[0] + direction[0],
                        position[1] + direction[1]
                    ]

                    // Stop if obstacle is encountered
                    if obstacleSet.contains(nextPosition) {
                        break
                    }

                    // Update position
                    position = nextPosition
                }
            }

            // Update max distance squared from origin
            let distanceSquared = position[0] * position[0] + position[1] * position[1]
            maxDistanceSquared = max(maxDistanceSquared, distanceSquared)
        }

        return maxDistanceSquared
    }
}