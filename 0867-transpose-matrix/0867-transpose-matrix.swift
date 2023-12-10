class Solution {
    func transpose(_ matrix: [[Int]]) -> [[Int]] {
        var transposedMatrix = [[Int]]()
        let rowCount = matrix.count
        let columnCount = matrix[0].count

        for columnIndex in 0..<columnCount {
            var matrixRow = [Int]()
            for rowIndex in 0..<rowCount {
                matrixRow.append(matrix[rowIndex][columnIndex])
            }
            transposedMatrix.append(matrixRow)
        }

        return transposedMatrix
    }
}