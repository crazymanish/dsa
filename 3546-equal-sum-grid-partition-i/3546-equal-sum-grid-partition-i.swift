class Solution {
    /**
     Problem Summary:
     Determine whether a grid can be split into two parts (either by rows or columns)
     such that both parts have equal sum.

     Strategy:
     1. Compute total sum of all elements.
     2. If total sum is odd → early return false (cannot split equally).
     3. Compute row sums and column sums.
     4. Check if any prefix sum equals totalSum / 2.
     5. Return true if either row or column split works.

     Key Insight:
     Equal partition requires totalSum to be even, and a prefix must reach totalSum / 2.

     Time Complexity:
     O(m * n)

     Space Complexity:
     O(m + n)
     */

    func canPartitionGrid(_ grid: [[Int]]) -> Bool {
        let numberOfRows = grid.count
        let numberOfColumns = grid[0].count
        
        // Compute total sum of all elements
        let totalSum = grid.flatMap { $0 }.reduce(0, +)
        
        // Optimization: If total sum is odd, equal partition is impossible
        if totalSum % 2 != 0 {
            return false
        }
        
        let target = totalSum / 2
        
        // Compute row sums
        let rowSums = grid.map { row in
            row.reduce(0, +)
        }
        
        // Compute column sums
        let columnSums = (0..<numberOfColumns).map { columnIndex in
            grid.reduce(0) { partialSum, row in
                partialSum + row[columnIndex]
            }
        }
        
        // Check if any prefix sum equals target
        func canSplit(_ values: [Int]) -> Bool {
            var prefixSum = 0
            
            for value in values {
                prefixSum += value
                
                if prefixSum == target {
                    return true
                }
            }
            
            return false
        }
        
        return canSplit(rowSums) || canSplit(columnSums)
    }
}