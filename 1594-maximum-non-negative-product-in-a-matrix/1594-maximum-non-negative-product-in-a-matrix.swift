class Solution {

    /**
     Problem Summary:
     Given a grid of integers, find the maximum non-negative product of a path
     from top-left to bottom-right. You can only move right or down.
     Return the result modulo 1e9+7, or -1 if the maximum product is negative.

     Strategy:
     This is a Dynamic Programming problem where each cell maintains:
     - The minimum product reaching that cell
     - The maximum product reaching that cell

     Why both?
     Because multiplying by a negative number flips min ↔ max.

     Transition:
     For each cell (i, j), we consider:
     - Coming from top (i-1, j)
     - Coming from left (i, j-1)

     We compute:
     - minProduct = min(previous mins) * current value
     - maxProduct = max(previous maxes) * current value

     Then ensure ordering (min ≤ max).

     Time Complexity:
     O(n * m)

     Space Complexity:
     O(n * m)
     */

    func maxProductPath(_ grid: [[Int]]) -> Int {

        let rowCount = grid.count
        let colCount = grid[0].count

        // dp[row][col] = (minProduct, maxProduct)
        var dp = Array(
            repeating: Array(repeating: (minProduct: 0, maxProduct: 0), count: colCount),
            count: rowCount
        )

        for row in 0..<rowCount {
            for col in 0..<colCount {

                let currentValue = grid[row][col]

                if row == 0 && col == 0 {
                    // Starting point
                    dp[row][col] = (currentValue, currentValue)

                } else if row == 0 {
                    // First row → can only come from left
                    let previous = dp[row][col - 1].minProduct
                    let product = previous * currentValue
                    dp[row][col] = (product, product)

                } else if col == 0 {
                    // First column → can only come from top
                    let previous = dp[row - 1][col].minProduct
                    let product = previous * currentValue
                    dp[row][col] = (product, product)

                } else {
                    // General case: choose from top or left

                    let top = dp[row - 1][col]
                    let left = dp[row][col - 1]

                    // Compute candidate min and max
                    var minProduct = min(top.minProduct, left.minProduct) * currentValue
                    var maxProduct = max(top.maxProduct, left.maxProduct) * currentValue

                    // If multiplication flipped order (negative value), fix it
                    if minProduct > maxProduct {
                        swap(&minProduct, &maxProduct)
                    }

                    dp[row][col] = (minProduct, maxProduct)
                }
            }
        }

        let result = dp[rowCount - 1][colCount - 1].maxProduct

        // If maximum product is negative, return -1
        if result < 0 {
            return -1
        }

        let mod = Int(1e9 + 7)
        return result % mod
    }
}