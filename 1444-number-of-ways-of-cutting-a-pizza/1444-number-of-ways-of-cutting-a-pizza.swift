class Solution {
    func ways(_ pizza: [String], _ k: Int) -> Int {
        let M = 1000000007
        let m = pizza.count, n = pizza[0].count
        var dp = Array(repeating: Array(repeating: Array(repeating: 0, count: k + 1), count: n), count: m)
        var grid = Array(repeating: Array(repeating: 0, count: n), count: m)
        var cnt = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
        for i in 0..<m {
            let row = pizza[i]
            for j in 0..<n {
                if row[row.index(row.startIndex, offsetBy: j)] == "A" {
                    grid[i][j] = 1
                }
            }
        }
        
        for i in (0..<m).reversed() {
            for j in (0..<n).reversed() {
                cnt[i][j] = cnt[i + 1][j] + grid[i][j] + cnt[i][j + 1] - cnt[i + 1][j + 1]
            }
        }
        
        func dfs(_ k: Int, _ x: Int, _ y: Int) {
            if k == 1 && cnt[x][y] > 0 {
                dp[x][y][k] = 1
                return
            }
            
            if cnt[x][y] < k || k < 1 { return }
            
            if dp[x][y][k] != 0 { return }
            
            let m = grid.count, n = grid[0].count
            for i in x + 1..<m {
                if cnt[x][y] - cnt[i][y] == 0 { continue }
            
                dfs(k - 1, i, y)
                dp[x][y][k] += dp[i][y][k - 1]
            }
            
            for j in y + 1..<n {
                if cnt[x][y] - cnt[x][j] == 0 { continue }
                dfs(k - 1, x, j)
                dp[x][y][k] += dp[x][j][k - 1]
            }
            
            dp[x][y][k] %= M
        }
        
        
        dfs(k, 0, 0)
        return dp[0][0][k]
    }
}