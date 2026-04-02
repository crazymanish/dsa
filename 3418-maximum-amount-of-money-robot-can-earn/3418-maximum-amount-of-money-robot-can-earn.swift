class Solution {
    /**
     Problem Summary:
     You are given a grid of coins where each cell contains a positive or negative value.
     Starting from the top-left corner, you can move only right or down to reach the bottom-right corner.
     You are allowed to "neutralize" (ignore) up to 2 negative cells (i.e., treat them as 0 instead of negative).
     The goal is to maximize the total sum collected along the path.

     Strategy:
     - Use DFS + Memoization (Top-Down DP).
     - State: dp[row][col][remainingNeutralizations]
         → maximum profit from (row, col) to bottom-right.
     - At each cell:
         1. Move right or down normally (add current value).
         2. If current cell is negative and we still have neutralizations:
            → Optionally neutralize it (treat value as 0).
     - Take the maximum of all valid choices.

     Time Complexity:
     O(n * m * k)
     where k = number of neutralizations (constant = 3 here)

     Space Complexity:
     O(n * m * k) for DP recursion + memoization
     */

    func maximumAmount(_ coins: [[Int]]) -> Int {
        let rowCount = coins.count
        let colCount = coins[0].count
        let maxNeutralizations = 2
        
        // 3D DP array:
        // dp[row][col][remainingNeutralizations]
        var memo = Array(
            repeating: Array(
                repeating: Array(repeating: Int.min, count: maxNeutralizations + 1),
                count: colCount
            ),
            count: rowCount
        )
        
        func dfs(_ row: Int, _ col: Int, _ remainingNeutralizations: Int) -> Int {
            // Out of bounds → invalid path
            if row >= rowCount || col >= colCount {
                return Int.min
            }
            
            // Base case: reached bottom-right cell
            if row == rowCount - 1 && col == colCount - 1 {
                // If negative and we can neutralize → choose 0
                if coins[row][col] < 0 && remainingNeutralizations > 0 {
                    return 0
                }
                return coins[row][col]
            }
            
            // Return cached result if already computed
            if memo[row][col][remainingNeutralizations] != Int.min {
                return memo[row][col][remainingNeutralizations]
            }
            
            // Explore moving right and down WITHOUT neutralizing
            let rightProfit = dfs(row, col + 1, remainingNeutralizations)
            let downProfit = dfs(row + 1, col, remainingNeutralizations)
            
            // Add current cell value
            var bestProfit = coins[row][col] + max(rightProfit, downProfit)
            
            // If current cell is negative, try neutralizing it
            if coins[row][col] < 0 && remainingNeutralizations > 0 {
                let neutralizeRight = dfs(row, col + 1, remainingNeutralizations - 1)
                let neutralizeDown = dfs(row + 1, col, remainingNeutralizations - 1)
                
                // Neutralizing means we don't add the negative value
                bestProfit = max(bestProfit, max(neutralizeRight, neutralizeDown))
            }
            
            // Store result in memo table
            memo[row][col][remainingNeutralizations] = bestProfit
            return bestProfit
        }
        
        return dfs(0, 0, maxNeutralizations)
    }
}