class Solution {
    func countPaths(_ grid: [[Int]]) -> Int {
        let mod = 1000000007
        let dirs = [[0,1], [0,-1], [1,0], [-1,0]]
        let m = grid.count
        let n = grid[0].count
        
        var cache = Array(repeating: Array(repeating: 0, count: n), count: m)
        var res = 0
        
        func helper(_ row: Int, _ col: Int, _ preVal: Int) -> Int {
            if row < 0 || row >= m || col < 0 || col >= n || grid[row][col] <= preVal { return 0 }
            if cache[row][col] > 0 { return cache[row][col] }
            var count = 0
            for d in dirs {
                let x = row + d[0]
                let y = col + d[1]
                count += helper(x, y, grid[row][col]) % mod
            }
            count += 1
            cache[row][col] = count
            return count
        }
        
        for i in 0..<m {
            for j in 0..<n {
                res += helper(i, j, 0) % mod
                res = res % mod
            }
        }
        return res % mod
    }
}