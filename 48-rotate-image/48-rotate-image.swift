class Solution {
    func rotate(_ matrix: inout [[Int]]) {
        for row in 0..<matrix.count {
            for column in row+1..<matrix[row].count {
                let temp = matrix[row][column]
                matrix[row][column] = matrix[column][row]
                matrix[column][row] = temp
            }
            matrix[row].reverse()
        }
    }
}