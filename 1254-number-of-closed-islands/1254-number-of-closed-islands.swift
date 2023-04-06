class Solution {
    func closedIsland(_ grid: [[Int]]) -> Int {
        var grid = grid
        let rows = grid.count
        let columns = grid[0].count
        
        func isClosedIslandUsingDFS(_ row: Int, _ column: Int) -> Int {
            if row < 0 || row >= rows || column < 0 || column >= columns { return 0 }
            if grid[row][column] == 1 { return 1 }
            
            grid[row][column] = 1
            
            var isClosedIsland = 1
            isClosedIsland = isClosedIsland & isClosedIslandUsingDFS(row, column+1)
            isClosedIsland = isClosedIsland & isClosedIslandUsingDFS(row, column-1)
            isClosedIsland = isClosedIsland & isClosedIslandUsingDFS(row+1, column)
            isClosedIsland = isClosedIsland & isClosedIslandUsingDFS(row-1, column)
            return isClosedIsland
        }
        
        var closedIslands = 0
        for row in 0..<rows {
            for column in 0..<columns {
                if grid[row][column] == 0 && isClosedIslandUsingDFS(row, column) == 1 {
                    closedIslands += 1
                }
            }
        }
        
        return closedIslands
    }
}