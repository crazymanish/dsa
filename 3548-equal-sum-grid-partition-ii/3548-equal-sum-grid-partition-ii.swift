class Solution {
    /**
     Problem Summary:
     Determine whether a grid can be partitioned into two parts such that the sum
     of elements in both parts is equal. The partition can be horizontal or vertical,
     and we also consider reversed directions to simulate splitting from both ends.

     Strategy:
     - Compute total sum of the grid.
     - Try splitting row-wise and column-wise.
     - For each orientation:
         - Maintain a running prefix sum (`currentSum`).
         - Track all seen values using a set.
         - Compute difference `diff = currentSum - (total - currentSum)`.
         - Check:
             1. Exact split (`diff == 0`)
             2. Edge element removal cases
             3. If a previously seen value equals `diff` (valid adjustment)
     - Also test reversed grid to simulate splitting from bottom/right.

     Time Complexity:
     O(m * n) — each element is processed a constant number of times.

     Space Complexity:
     O(m * n) — due to the set storing visited elements.
     */
    func canPartitionGrid(_ grid: [[Int]]) -> Bool {
        let totalSum = grid.flatMap { $0 }.reduce(0, +)

        // Checks whether a valid partition exists for a given orientation
        func canSplit(_ matrix: [[Int]]) -> Bool {
            var seenValues = Set<Int>()
            var currentSum = 0

            for rowIndex in matrix.indices {

                // Add current row values into the set
                seenValues.formUnion(matrix[rowIndex])

                // Update prefix sum
                currentSum += matrix[rowIndex].reduce(0, +)

                // Difference between two partitions
                let difference = currentSum - (totalSum - currentSum)

                // Case 1: Perfect equal split
                if difference == 0 {
                    return true
                }

                // Case 2: Removing a boundary element fixes imbalance
                if difference == matrix[0][0] ||                    // top-left
                   difference == matrix[0].last! ||                // top-right
                   difference == matrix[rowIndex][0] {             // current row leftmost
                    return true
                }

                // Case 3: Internal adjustment using seen values
                // Only valid when more than 1 column and not first row
                if matrix[0].count > 1 && rowIndex > 0 && seenValues.contains(difference) {
                    return true
                }
            }

            return false
        }

        // Transpose grid for column-wise checks
        let transposedGrid = (0..<grid[0].count).map { col in
            grid.map { $0[col] }
        }

        // Try all 4 orientations
        return canSplit(grid) ||
               canSplit(grid.reversed()) ||
               canSplit(transposedGrid) ||
               canSplit(transposedGrid.reversed())
    }
}