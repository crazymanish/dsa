class Solution {
    func shortestPathBinaryMatrix(_ grid: [[Int]]) -> Int {
        let R = grid.count, C = grid[0].count
        if grid[0][0] == 1 || grid[R-1][C-1] == 1 { return -1 }

        var grid = grid
        var points: Set<[Int]> = [[0, 0]]
        var res = 0
        while !points.isEmpty {
            res += 1
            points.forEach { grid[$0[0]][$0[1]] = 2 }

            var nexts = Set<[Int]>()
            for point in points {
                let x = point[0], y = point[1]
                if x == R - 1 && y == C - 1 { return res }
                
                for dx in -1...1 { for dy in -1...1 {
                    let nx = x + dx, ny = y + dy
                    if nx >= 0 && nx < R && ny >= 0 && ny < C
                       && grid[nx][ny] == 0 {
                        nexts.insert([nx, ny])
                    }
                }}
            }
            points = nexts
        }
        
        return -1
    }
}