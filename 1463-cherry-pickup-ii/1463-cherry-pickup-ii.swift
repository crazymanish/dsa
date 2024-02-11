class Solution {
    func cherryPickup(_ grid: [[Int]]) -> Int {
        let rows = grid.endIndex
        let columns = grid[0].endIndex
        var dict = [[Int]: Int]()
        
        func dfs(_ row: Int, _ column1: Int, _ column2: Int) -> Int {
            if column1 < 0 || column1 == columns || column2 < 0 || column2 == columns { return Int.min }
            if dict[[row, column1, column2]] != nil { return dict[[row, column1, column2]]! }
            
            var result = grid[row][column1]
            if column1 != column2 { result += grid[row][column2] }
            
            if row+1 < rows {
                var currentResult = Int.min
                
                for newColumn1 in column1-1...column1+1 {
                    for newColumn2 in column2-1...column2+1 {
                        currentResult = max(currentResult, dfs(row+1, newColumn1, newColumn2))
                    }
                }
                result += currentResult
            }
            
            dict[[row, column1, column2]] = result
            return result
        }
		
        return dfs(0,0,columns-1)
    }
}