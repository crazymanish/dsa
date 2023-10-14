class Solution {
    func paintWalls(_ cost: [Int], _ time: [Int]) -> Int {
        let n = cost.count
        
        // The initial state of DP represents that
        // it costs nothing to paint no walls.
        var dp: [Int] = Array(repeating: 500_000_000, count: n + 1)
        dp[0] = 0
        
        // Wall by wall, decide the lowest cost at which remaining
        // walls can be painted.
        for i in (0..<n).reversed() {
            let previousDP = dp
            for remain in 1...n {
                // Try both cases where we either pay or don't for the wall at i.
                let remainingAfterPaint = max(0, remain-1-time[i])
                let paint = cost[i] + previousDP[remainingAfterPaint]
                let skip = previousDP[remain]
                dp[remain] = min(paint, skip)
            }
        }
        
        // The initial state for painting is when we have n walls to paint.
        return dp[n]
    }
}