/**
 Problem Summary:
 ----------------
 Given a 2D grid of integers, count the number of submatrices that start at (0, 0)
 and end at any position (i, j), such that the sum of elements in the submatrix
 is less than or equal to k.

 Strategy:
 ---------
 - Use a prefix sum approach compressed to 1D.
 - For each row:
    - Maintain a running `rowPrefixSum` (sum of elements from column 0 to j in current row).
    - Maintain a `columnPrefixSums[j]` which represents the sum of all elements
      in the rectangle from (0, 0) to (i, j).
 - For each cell (i, j), the value of `columnPrefixSums[j]` is exactly the sum
   of the submatrix from (0, 0) to (i, j).
 - If this sum is ≤ k, increment the count.

 Time Complexity:
 ----------------
 O(n * m)

 Space Complexity:
 -----------------
 O(m) — for the prefix array
 */
class Solution {
    func countSubmatrices(_ grid: [[Int]], _ k: Int) -> Int {
        let rowCount = grid.count
        let columnCount = grid[0].count

        // Stores prefix sum of submatrix from (0,0) to current row for each column
        var columnPrefixSums = Array(repeating: 0, count: columnCount)

        var validSubmatrixCount = 0

        // Iterate through each row
        for row in 0..<rowCount {
            var rowPrefixSum = 0 // Running sum for current row

            for column in 0..<columnCount {
                // Update row prefix sum (sum from column 0 to current column)
                rowPrefixSum += grid[row][column]

                // Accumulate into column prefix to form full submatrix sum
                columnPrefixSums[column] += rowPrefixSum

                // Check if submatrix (0,0) to (row,column) satisfies condition
                if columnPrefixSums[column] <= k {
                    validSubmatrixCount += 1
                }
            }
        }

        return validSubmatrixCount
    }
}