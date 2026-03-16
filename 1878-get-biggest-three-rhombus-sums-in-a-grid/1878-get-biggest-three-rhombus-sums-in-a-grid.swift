/**
 Problem Summary:
 Given a 2D grid of integers, a *rhombus* is defined by selecting a center-top
 cell and expanding diagonally to form a diamond shape. The rhombus **sum**
 is the sum of its border elements only (not the interior).

 The task is to return the **three largest distinct rhombus border sums**
 that can be formed anywhere in the grid.

 Strategy:
 1. Iterate through every cell in the grid and treat it as the **top vertex**
    of a potential rhombus.
 2. Determine the maximum rhombus size that can fit from that position
    without leaving grid boundaries.
 3. For each possible size:
      - Size 0 represents a single cell rhombus.
      - Larger sizes trace the rhombus border in four diagonal directions:
            down-left
            down-right
            up-right
            up-left
 4. Accumulate the border values for each rhombus and store them in a Set
    to keep only distinct sums.
 5. After evaluating all rhombi, return the top three largest sums.

 Time Complexity:
 O(n * m * k)
 where:
 - n = number of rows
 - m = number of columns
 - k = maximum rhombus size (bounded by grid dimensions)

 Space Complexity:
 O(U)
 where U is the number of distinct rhombus sums stored in the set.
*/

class Solution {

    func getBiggestThree(_ grid: [[Int]]) -> [Int] {

        let rowCount = grid.count
        let columnCount = grid[0].count

        // Stores unique rhombus border sums
        var uniqueSums = Set<Int>()

        /**
         Calculates all rhombus border sums whose top vertex
         is located at (row, col).
        */
        func computeRhombusSums(topRow: Int, topCol: Int) {

            // Maximum rhombus size allowed without exceeding boundaries
            let maxRadius = min(
                topCol + 1,                     // space to the left
                columnCount - topCol,           // space to the right
                (rowCount - topRow + 1) / 2     // vertical space
            )

            for radius in 0..<maxRadius {

                // Radius 0 → single cell rhombus
                if radius == 0 {
                    uniqueSums.insert(grid[topRow][topCol])
                    continue
                }

                var sum = 0
                var row = topRow
                var col = topCol

                // Edge 1: move down-left
                for _ in 0..<radius {
                    sum += grid[row][col]
                    row += 1
                    col -= 1
                }

                // Edge 2: move down-right
                for _ in 0..<radius {
                    sum += grid[row][col]
                    row += 1
                    col += 1
                }

                // Edge 3: move up-right
                for _ in 0..<radius {
                    sum += grid[row][col]
                    row -= 1
                    col += 1
                }

                // Edge 4: move up-left
                for _ in 0..<radius {
                    sum += grid[row][col]
                    row -= 1
                    col -= 1
                }

                uniqueSums.insert(sum)
            }
        }

        // Try every cell as a potential rhombus top vertex
        for row in 0..<rowCount {
            for col in 0..<columnCount {
                computeRhombusSums(topRow: row, topCol: col)
            }
        }

        // Return the three largest distinct sums
        return uniqueSums
            .sorted(by: >)
            .prefix(3)
            .map { $0 }
    }
}