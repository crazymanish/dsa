class Solution {
    func champagneTower(_ poured: Int, _ query_row: Int, _ query_glass: Int) -> Double {
        if poured == 0 { return 0 }
    
        var dpGrid = [[Double(poured)]]
    
        for row in 0..<query_row {
            dpGrid.append(Array(repeating: 0, count: row+2))
        
            for glass in 0..<dpGrid[row].count {
                if dpGrid[row][glass] > 1 {
                    let excess = (dpGrid[row][glass] - 1)/2
                    dpGrid[row+1][glass] += excess
                    dpGrid[row+1][glass+1] += excess
                }
            }
        }
    
        return min(1, dpGrid[query_row][query_glass])
    }
}