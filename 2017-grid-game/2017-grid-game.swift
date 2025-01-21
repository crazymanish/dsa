class Solution {
    func gridGame(_ grid: [[Int]]) -> Int {
        let n = grid[0].count
        
        // Create prefix sums for both rows for O(1) range sum queries
        var topSum = Array(repeating: 0, count: n + 1)
        var bottomSum = Array(repeating: 0, count: n + 1)
        
        // Calculate prefix sums left to right
        for i in 0..<n {
            topSum[i + 1] = topSum[i] + grid[0][i]
            bottomSum[i + 1] = bottomSum[i] + grid[1][i]
        }
        
        var result = Int.max
        
        // Try each possible turning point for robot 1
        for i in 0..<n {
            // Robot 2's choices:
            // 1. Take remaining numbers in top row right of robot 1's turn
            // 2. Take numbers in bottom row left of robot 1's turn
            let top = topSum[n] - topSum[i+1]    // Sum of remaining top row
            let bottom = bottomSum[i]              // Sum of bottom row until turn
            
            // Robot 2 will take maximum of these two paths
            let robot2Score = max(top, bottom)
            
            // We want minimum of all robot 2's maximum scores
            result = min(result, robot2Score)
        }
        
        return result
    }
}