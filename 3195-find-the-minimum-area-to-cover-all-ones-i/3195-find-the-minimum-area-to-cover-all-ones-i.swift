// Time Complexity: O(M * N)
//   - M: The number of rows in the grid.
//   - N: The number of columns in the grid.
// The algorithm requires a single pass over every cell in the grid to find the
// boundaries of the `1`s. The work done at each cell is constant time.
//
// Space Complexity: O(1)
// The solution uses a fixed number of variables to store the boundary coordinates.
// The amount of extra space used is constant and does not scale with the input grid size.
class Solution {
    /**
     * Finds the area of the smallest rectangle that can enclose all the '1's in a binary grid.
     *
     * The strategy is to find the bounding box of all the '1's. This box is defined by the
     * minimum and maximum row and column indices where a '1' appears.
     * - `topMost`: The smallest row index of any '1'.
     * - `bottomMost`: The largest row index of any '1'.
     * - `leftMost`: The smallest column index of any '1'.
     * - `rightMost`: The largest column index of any '1'.
     * The area is then the height (`bottomMost - topMost + 1`) multiplied by the width
     * (`rightMost - leftMost + 1`).
     *
     * - Parameter grid: A 2D array of integers (0s and 1s).
     * - Returns: The area of the minimum bounding rectangle.
     */
    func minimumArea(_ grid: [[Int]]) -> Int {
        // Handle empty or invalid grid input.
        guard let firstRow = grid.first, !firstRow.isEmpty else {
            return 0
        }
        
        let rowCount = grid.count
        let colCount = firstRow.count

        // Initialize boundaries. Using Int.max/Int.min is a robust way to
        // start a search for min/max values and helps detect if no '1's were found.
        var topMost = Int.max
        var bottomMost = Int.min
        var leftMost = Int.max
        var rightMost = Int.min

        // Iterate through every cell to find the extremal coordinates of the '1's.
        for r in 0..<rowCount {
            for c in 0..<colCount {
                if grid[r][c] == 1 {
                    // If a '1' is found, update the four boundary variables.
                    topMost = min(topMost, r)
                    bottomMost = max(bottomMost, r)
                    leftMost = min(leftMost, c)
                    rightMost = max(rightMost, c)
                }
            }
        }

        // Edge Case: If no '1's were found in the grid, the initial values
        // of the boundaries will remain unchanged. In this case, the area is 0.
        if topMost == Int.max {
            return 0
        }

        // Calculate the height and width of the bounding box.
        // We add 1 because the indices are 0-based (e.g., from row 2 to 3 is 3-2+1=2 rows).
        let height = bottomMost - topMost + 1
        let width = rightMost - leftMost + 1

        return height * width
    }
}