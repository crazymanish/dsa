/**
 Problem Summary:
 Given a 2D grid where each cell contains a value:
 - Moving from top-left (0,0) to bottom-right (m-1,n-1)
 - You can only move right or down
 - Each non-zero cell consumes 1 unit from a limited budget `k`
 - Maximize the total score (sum of visited cell values) without exceeding cost `k`

 Strategy:
 - Use 3D Dynamic Programming:
   dp[row][col][cost] = maximum score achievable at (row, col) using exactly `cost`
 - For each cell:
   - Transition from top (row-1, col) and left (row, col-1)
   - Add current cell's value to score
   - Increase cost if cell value is non-zero
 - Keep only valid states where cost ≤ k

 Time Complexity:
 O(m * n * k)

 Space Complexity:
 O(m * n * k)
 */
class Solution {
    func maxPathScore(_ grid: [[Int]], _ maxCost: Int) -> Int {
        let rowCount = grid.count
        let colCount = grid[0].count
        
        // dp[row][col][cost] = max score at (row, col) using 'cost'
        var dp = Array(
            repeating: Array(
                repeating: Array(repeating: -1, count: maxCost + 1),
                count: colCount
            ),
            count: rowCount
        )
        
        // Starting point: no cost used, no score yet
        dp[0][0][0] = 0
        
        for row in 0..<rowCount {
            for col in 0..<colCount {
                let cellValue = grid[row][col]
                
                // Cost increases if cell is non-zero
                let additionalCost = cellValue == 0 ? 0 : 1
                
                for usedCost in 0...maxCost {
                    var bestPreviousScore = -1
                    
                    // Special handling for starting cell
                    if row == 0 && col == 0 {
                        bestPreviousScore = (usedCost == 0) ? 0 : -1
                    } else {
                        // Transition from top cell
                        if row > 0 {
                            bestPreviousScore = max(bestPreviousScore, dp[row - 1][col][usedCost])
                        }
                        
                        // Transition from left cell
                        if col > 0 {
                            bestPreviousScore = max(bestPreviousScore, dp[row][col - 1][usedCost])
                        }
                    }
                    
                    // Skip invalid states
                    guard bestPreviousScore >= 0 else { continue }
                    
                    let newCost = usedCost + additionalCost
                    
                    // Only update if within allowed cost
                    if newCost <= maxCost {
                        dp[row][col][newCost] = max(
                            dp[row][col][newCost],
                            bestPreviousScore + cellValue
                        )
                    }
                }
            }
        }
        
        // Result is the maximum score at destination across all valid costs
        return dp[rowCount - 1][colCount - 1].max() ?? -1
    }
}