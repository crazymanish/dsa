class Solution {
    /**
     Problem Summary:
     Given a 2D grid containing characters 'X' and 'Y',
     count the number of submatrices (ending at each cell)
     where the number of 'X' and 'Y' are equal and non-zero.

     Strategy:
     - Traverse the grid row by row.
     - Maintain a column-wise prefix accumulator:
       For each column, store cumulative counts of ('X', 'Y').
     - For each row:
         - Maintain a running prefix count for the current row.
         - Update the column accumulator by adding row prefix.
         - At each cell, check if total X == total Y and non-zero.

     Key Insight:
     Each (i, j) represents a submatrix from (0,0) → (i,j).
     By accumulating row prefixes into column prefixes,
     we effectively compute counts for all such submatrices.

     Time Complexity:
     O(n * m)

     Space Complexity:
     O(m)
     */
    func numberOfSubmatrices(_ grid: [[Character]]) -> Int {
        let columnCount = grid[0].count

        // Stores cumulative counts of (X, Y) for each column
        var columnPrefixCounts = Array(repeating: (xCount: 0, yCount: 0), count: columnCount)

        var validSubmatrixCount = 0

        // Iterate through each row
        for row in grid {
            // Running count of (X, Y) for current row prefix
            var rowPrefixCounts = (xCount: 0, yCount: 0)

            for columnIndex in 0..<columnCount {
                // Update row prefix counts
                if row[columnIndex] == "X" {
                    rowPrefixCounts.xCount += 1
                } else if row[columnIndex] == "Y" {
                    rowPrefixCounts.yCount += 1
                }

                // Accumulate into column prefix
                columnPrefixCounts[columnIndex].xCount += rowPrefixCounts.xCount
                columnPrefixCounts[columnIndex].yCount += rowPrefixCounts.yCount

                // Check if submatrix has equal non-zero counts
                let totalX = columnPrefixCounts[columnIndex].xCount
                let totalY = columnPrefixCounts[columnIndex].yCount

                if totalX == totalY && totalX != 0 {
                    validSubmatrixCount += 1
                }
            }
        }

        return validSubmatrixCount
    }
}