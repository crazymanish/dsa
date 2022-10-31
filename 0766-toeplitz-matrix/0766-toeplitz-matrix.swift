class Solution {
    func isToeplitzMatrix(_ matrix: [[Int]]) -> Bool {
        for row in 0..<matrix.count-1 {
            for column in 0..<matrix[row].count-1 {
                if (matrix[row][column] != matrix[row+1][column+1]){
                    return false
                }
            }
        }
        
        return true
    }
}