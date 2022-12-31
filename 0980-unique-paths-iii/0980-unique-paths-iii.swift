class Solution {
    func uniquePathsIII(_ grid: [[Int]]) -> Int {
        if grid.count == 0 { return 0 }
        
        var uniquePath:Int = 0
        var grid = grid
        var startingPoint = (x:0, y:0)
        var total = 0
        for i in 0..<grid.count{
            for j in 0..<grid[0].count{
                if grid[i][j] == 1 { startingPoint = (i,j) }
                if grid[i][j] != -1 { total += 1 }
            }
        }
        
        func dfsHelper(_ i: Int, _ j: Int, _ total: Int) {
            guard i >= 0 && i<grid.count else { return }
        
            guard j >= 0 && j<grid[0].count else { return }
        
            if grid[i][j] == 2{
                if total == 1 { uniquePath += 1 }
                return
            } else if grid[i][j] == -1 { 
                return 
            }
            
            let currentValue = grid[i][j]
            grid[i][j] = -1
            dfsHelper(i+1, j, total-1)
            dfsHelper(i-1, j, total-1)
            dfsHelper(i, j+1, total-1)
            dfsHelper(i, j-1, total-1)
            grid[i][j] = currentValue
        }
        
        dfsHelper(startingPoint.x, startingPoint.y,total)
        
        return uniquePath
    }
}