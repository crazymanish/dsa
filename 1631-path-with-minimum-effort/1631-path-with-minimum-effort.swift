class Solution {
    func minimumEffortPath(_ heights: [[Int]]) -> Int {
        let (rows, cols) = (heights.count, heights[0].count)
        var dp = heights.map {$0.map{ _ in Int.max}}
        dp[0][0] = 0
        var bfs = [(0,0)]
        
        while bfs.isEmpty == false {
            let (x,y) = bfs.removeFirst()
            let moves = [(0,1), (0,-1), (1,0), (-1,0)].lazy.map{(x+$0.0, y+$0.1)}
            
            for (newX, newY) in moves where 0..<cols ~= newX && 0..<rows ~= newY {
                let effort = max(dp[y][x], abs(heights[y][x] - heights[newY][newX]))
                guard dp[newY][newX] > effort else { continue }
                
                dp[newY][newX] = effort
                bfs.append((newX, newY))
            }
        }
        
        return dp.last!.last!
    }
}