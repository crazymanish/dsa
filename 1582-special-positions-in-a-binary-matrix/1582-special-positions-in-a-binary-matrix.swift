class Solution {
    func numSpecial(_ mat: [[Int]]) -> Int {
        let rows = mat.count
        let columns = mat[0].count
        
        var rowsDict: [Int: Int] = [:]
        var columnsDict: [Int: Int] = [:]
        
        for row in 0..<rows {
            for column in 0..<columns {
                if mat[row][column] == 1 {
                    rowsDict[row, default: 0] += 1
                    columnsDict[column, default: 0] += 1
                }
            }
        }
        
        var result = 0
        
        for row in 0..<rows {
            for column in 0..<columns {
                if mat[row][column] == 1 && rowsDict[row] == 1 && columnsDict[column] == 1 {
                    result += 1
                }
            }
        }
        
        return result
    }
}