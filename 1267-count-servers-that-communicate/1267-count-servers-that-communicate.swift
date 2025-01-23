class Solution {
    func countServers(_ grid: [[Int]]) -> Int {
        let rows = grid.count
        let cols = grid[0].count
        
        // Arrays to store the count of servers in each row and column
        var rowCount = Array(repeating: 0, count: rows)
        var colCount = Array(repeating: 0, count: cols)
        
        // First pass: Count the number of servers in each row and column
        for row in 0..<rows {
            for col in 0..<cols {
                if grid[row][col] == 1 {
                    rowCount[row] += 1
                    colCount[col] += 1
                }
            }
        }
        
        var result = 0
        
        // Second pass: Count servers that can communicate
        for row in 0..<rows {
            for col in 0..<cols {
                if grid[row][col] == 1 && (rowCount[row] > 1 || colCount[col] > 1) {
                    result += 1
                }
            }
        }
        
        return result
    }
}