/**
 Problem Summary:
 You are given a box represented as a 2D grid where:
 - '#' represents a stone
 - '*' represents an obstacle
 - '.' represents empty space

 The box is rotated 90 degrees clockwise. Before rotation, stones fall to the right
 due to gravity, stopping at obstacles or other stones.

 Strategy:
 1. Simulate gravity row by row:
    - Traverse from right to left.
    - Use a pointer (`emptySlotIndex`) to track where the next stone should fall.
    - When encountering:
        - '.' → skip
        - '*' → reset the empty slot pointer
        - '#' → move it to the `emptySlotIndex`
 2. Rotate the processed box 90° clockwise.

 Time Complexity:
 O(m * n) — each cell is visited a constant number of times.

 Space Complexity:
 O(m * n) — for the result matrix.
 */

class Solution {
    func rotateTheBox(_ box: [[Character]]) -> [[Character]] {
        let rowCount = box.count
        let columnCount = box[0].count
        
        // Copy to simulate gravity before rotation
        var gravityAppliedBox = box
        
        // Step 1: Apply gravity (stones fall to the right)
        for row in 0..<rowCount {
            var emptySlotIndex = columnCount - 1  // Rightmost available position
            
            // Traverse from right to left
            for currentColumn in stride(from: columnCount - 1, through: 0, by: -1) {
                let currentCell = gravityAppliedBox[row][currentColumn]
                
                if currentCell == "." {
                    // Empty space → nothing to do
                    continue
                } else if currentCell == "*" {
                    // Obstacle → reset the empty slot just before it
                    emptySlotIndex = currentColumn - 1
                } else { // currentCell == "#"
                    // Move stone to the rightmost available position
                    gravityAppliedBox[row][currentColumn] = "."
                    gravityAppliedBox[row][emptySlotIndex] = "#"
                    emptySlotIndex -= 1
                }
            }
        }
        
        // Step 2: Rotate the box 90° clockwise
        var rotatedBox = Array(
            repeating: Array(repeating: Character("."), count: rowCount),
            count: columnCount
        )
        
        for row in 0..<rowCount {
            for col in 0..<columnCount {
                // Mapping: (row, col) → (col, rowCount - 1 - row)
                rotatedBox[col][rowCount - 1 - row] = gravityAppliedBox[row][col]
            }
        }
        
        return rotatedBox
    }
}