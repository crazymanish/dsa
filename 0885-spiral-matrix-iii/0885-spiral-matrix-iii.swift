class Solution {
    func spiralMatrixIII(_ rows: Int, _ cols: Int, _ rStart: Int, _ cStart: Int) -> [[Int]] {
        // Directions: right (0, 1), down (1, 0), left (0, -1), up (-1, 0)
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        var result = [[Int]]()
        
        // Starting position
        var r = rStart
        var c = cStart
        
        // Initial step count and direction index
        var step = 1
        var dir = 0
        
        // Add the starting position to the result
        result.append([r, c])
        
        // Continue until we have visited all cells in the grid
        while result.count < rows * cols {
            // We need to move in the current direction for `step` times, twice (once in each direction pair)
            for _ in 0..<2 {
                for _ in 0..<step {
                    // Move to the next cell in the current direction
                    r += directions[dir].0
                    c += directions[dir].1
                    
                    // If the new position is within the grid boundaries, add it to the result
                    if r >= 0 && r < rows && c >= 0 && c < cols {
                        result.append([r, c])
                    }
                }
                // Change to the next direction in the sequence
                dir = (dir + 1) % 4
            }
            // After moving in two directions, increment the step count
            step += 1
        }
        
        // Return the list of visited positions
        return result
    }
}