class Solution {
    func diagonalSum(_ mat: [[Int]]) -> Int {
        let rowsCount = mat.count
        let midIndex = rowsCount % 2 == 0 ? -1 : rowsCount / 2
        var result = 0
        
        for rowIndex in 0..<rowsCount {
            result += mat[rowIndex][rowIndex]
            
            guard rowIndex != midIndex else { continue }
            
            let columnIndex = rowsCount-(rowIndex+1)
            result += mat[rowIndex][columnIndex]
        }
        
        return result
    }
}