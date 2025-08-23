// Time Complexity: O((R*C)^2)
//   - Let R and C be the number of rows and columns.
//   - The `getBoundingBoxArea` function iterates over a subgrid, taking up to O(R*C) time.
//   - The `getMinSumForHorizontalCuts` function has two main loops:
//     - One iterates through O(R*C) partition points, calling `getBoundingBoxArea` three times. This is O(R*C * R*C) = O((R*C)^2).
//     - Another iterates through O(R^2) partition lines, also taking O(R^2 * R*C).
//   - The dominant factor is O((R*C)^2). The rotation takes O(R*C).
//
// Space Complexity: O(R*C)
//   - The primary space usage comes from creating the rotated grid, which requires O(R*C) space.
class Solution {
    /**
     * Finds the minimum total area of three non-overlapping rectangles that cover all `1`s in the grid.
     *
     * The strategy is to check all 6 possible ways to partition a rectangle into three smaller ones.
     * To simplify the code, we implement the 3 patterns that involve horizontal cuts first.
     * Then, we rotate the grid by 90 degrees and run the same logic again. A horizontal cut on a
     * rotated grid is equivalent to a vertical cut on the original grid. This covers all 6 patterns.
     *
     * - Parameter grid: A 2D array of integers (0s and 1s).
     * - Returns: The minimum possible sum of the three bounding box areas.
     */
    func minimumSum(_ grid: [[Int]]) -> Int {
        // Calculate the minimum sum for patterns involving horizontal cuts.
        let minSumHorizontal = getMinSumForHorizontalCuts(grid)
        
        // Rotate the grid to handle vertical cuts using the same logic.
        let rotatedGrid = rotateGridCounterClockwise(grid)
        let minSumVertical = getMinSumForHorizontalCuts(rotatedGrid)
        
        // The overall minimum is the minimum of the two sets of patterns.
        return min(minSumHorizontal, minSumVertical)
    }

    /**
     * Calculates the minimum sum of areas for the 3 partition patterns involving horizontal cuts.
     */
    private func getMinSumForHorizontalCuts(_ grid: [[Int]]) -> Int {
        let n = grid.count
        guard let m = grid.first?.count else { return 0 }

        var minTotalArea = Int.max

        // --- Pattern 1 & 2: One horizontal cut, then one vertical cut on either the top or bottom part ---
        for i in 0..<n - 1 { // `i` is the row index for the horizontal cut
            for j in 0..<m - 1 { // `j` is the column index for the vertical cut
                
                // Pattern 1: One top rectangle, two bottom rectangles
                // +-----------+
                // |     A     |
                // +-----+-----+
                // |  B  |  C  |
                // +-----+-----+
                let areaSum1 = getBoundingBoxArea(in: grid, 0, i, 0, m - 1) +
                               getBoundingBoxArea(in: grid, i + 1, n - 1, 0, j) +
                               getBoundingBoxArea(in: grid, i + 1, n - 1, j + 1, m - 1)
                
                // Pattern 2: Two top rectangles, one bottom rectangle
                // +-----+-----+
                // |  A  |  B  |
                // +-----+-----+
                // |     C     |
                // +-----------+
                let areaSum2 = getBoundingBoxArea(in: grid, 0, i, 0, j) +
                               getBoundingBoxArea(in: grid, 0, i, j + 1, m - 1) +
                               getBoundingBoxArea(in: grid, i + 1, n - 1, 0, m - 1)

                minTotalArea = min(minTotalArea, areaSum1, areaSum2)
            }
        }

        // --- Pattern 3: Two horizontal cuts, creating three horizontal rectangles ---
        // +-----------+
        // |     A     |
        // +-----------+
        // |     B     |
        // +-----------+
        // |     C     |
        // +-----------+
        for i in 0..<n - 2 { // First horizontal cut at row `i`
            for j in i + 1..<n - 1 { // Second horizontal cut at row `j`
                let areaSum3 = getBoundingBoxArea(in: grid, 0, i, 0, m - 1) +
                               getBoundingBoxArea(in: grid, i + 1, j, 0, m - 1) +
                               getBoundingBoxArea(in: grid, j + 1, n - 1, 0, m - 1)
                minTotalArea = min(minTotalArea, areaSum3)
            }
        }

        return minTotalArea
    }

    /**
     * Calculates the area of the minimum bounding box covering all `1`s within a specified subgrid.
     *
     * - Parameters: `grid`, and boundaries `top`, `bottom`, `left`, `right`.
     * - Returns: The area of the bounding box. Returns a large value if the subgrid contains no `1`s.
     */
    private func getBoundingBoxArea(in grid: [[Int]], _ top: Int, _ bottom: Int, _ left: Int, _ right: Int) -> Int {
        var minRow = Int.max, maxRow = Int.min
        var minCol = Int.max, maxCol = Int.min

        for r in top...bottom {
            for c in left...right {
                if grid[r][c] == 1 {
                    minRow = min(minRow, r)
                    maxRow = max(maxRow, r)
                    minCol = min(minCol, c)
                    maxCol = max(maxCol, c)
                }
            }
        }

        // If no `1` was found in the subgrid, return a large penalty value.
        // `Int.max / 3` is used to avoid overflow when summing three such values.
        if minRow == Int.max {
            return Int.max / 3
        }

        return (maxRow - minRow + 1) * (maxCol - minCol + 1)
    }

    /**
     * Rotates the grid 90 degrees counter-clockwise.
     */
    private func rotateGridCounterClockwise(_ grid: [[Int]]) -> [[Int]] {
        guard let firstRow = grid.first else { return [] }
        let n = grid.count
        let m = firstRow.count
        var rotated = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)

        for r in 0..<n {
            for c in 0..<m {
                rotated[m - 1 - c][r] = grid[r][c]
            }
        }
        return rotated
    }
}