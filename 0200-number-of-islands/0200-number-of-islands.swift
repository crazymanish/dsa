struct Cell: Hashable {
    var row: Int
    var column: Int
    init(_ row: Int, _ column: Int) {
        self.row = row
        self.column = column
    }
}

class Solution {
    func numIslands(_ grid: [[Character]]) -> Int {
        var visited = Set<Cell>()
        
        func dfs(_ row: Int, _ column: Int) {
            visited.insert(Cell(row, column))
            
            let allDirectionRowsColumns = [
                (row + 1, column), 
                (row - 1, column), 
                (row, column + 1), 
                (row, column - 1)
            ]
            
            for (currentRow, currentColumn) in allDirectionRowsColumns {
                guard 0 <= currentRow && 
                    currentRow < grid.count &&
                    0 <= currentColumn && 
                    currentColumn < grid[0].count else {
                    continue
                }
                
                if grid[currentRow][currentColumn] == "1" && !visited.contains(Cell(currentRow, currentColumn)) {
                    dfs(currentRow, currentColumn)
                }
            }
        }
        
        var result = 0
        for row in 0..<grid.count {
            for column in 0..<grid[0].count {
                if grid[row][column] == "1" && !visited.contains(Cell(row, column)) {
                    result += 1
                    dfs(row, column)
                }
            }
        }
        return result
    }
}