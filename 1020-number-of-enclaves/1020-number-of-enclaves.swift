class Solution {
    func numEnclaves(_ grid: [[Int]]) -> Int {
        let rows = grid.count
        let columns = grid[0].count
        var grid = grid
        
        // idea is that we will turn all the paths from the edges to 0 so we end up with the non reachable 1s, and then we just count them
        func dfs(_ row: Int, _ column: Int) {
            guard
                row >= 0, column >= 0, 
                row < rows, column < columns,
                grid[row][column] != 0
            else { return }
        
            grid[row][column] = 0
        
            dfs(row+1, column)
            dfs(row-1, column)
            dfs(row, column+1)
            dfs(row, column-1)
        }
    
        func isOnEdge(_ row: Int, _ column: Int) -> Bool {
            row == 0 || column == 0 || row == rows-1 || column == columns-1
        }
        
        for row in 0..<rows {
            for column in 0..<columns where isOnEdge(row,column) {
                dfs(row, column)
            }
        }
        
        return grid.flatMap { $0 }.filter { $0 == 1 }.count
    }
}