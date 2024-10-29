class Solution {
    func maxMoves(_ grid: [[Int]]) -> Int {
        let (m, n) = (grid.count, grid[0].count)
        var queue = Set(0..<m)
        var col = 0

        while !queue.isEmpty {
            queue = Set(queue.flatMap { children($0, col) })
            col += 1
        }

        return col - 1

        func children(_ row: Int, _ col: Int) -> [Int] {
            if col == n - 1 { return [] }

            var res = [Int]()
            if row > 0 && grid[row][col] < grid[row - 1][col + 1] { res.append(row - 1) }
            
            if grid[row][col] < grid[row][col + 1] { res.append(row) }
            
            if row < m - 1 && grid[row][col] < grid[row + 1][col + 1] { res.append(row + 1) }
            
            return res
        }
    }
}