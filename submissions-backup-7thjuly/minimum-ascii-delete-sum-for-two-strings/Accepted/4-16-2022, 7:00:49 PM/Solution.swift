// https://leetcode.com/problems/minimum-ascii-delete-sum-for-two-strings

class Solution {
    func minimumDeleteSum(_ s1: String, _ s2: String) -> Int {
        let rows = Array(s1)
        let columns = Array(s2)
        
        let rowsCount = rows.count
        let columnsCount = columns.count
        
        var dpMatrix = Array(repeating: Array(repeating: 0, count: columnsCount+1), count: rowsCount+1)
        
        // Base case(s) - fill first row & column
        for index in 1...rowsCount { dpMatrix[index][0] = dpMatrix[index-1][0] + Int(rows[index-1].asciiValue!) }
        for index in 1...columnsCount { dpMatrix[0][index] = dpMatrix[0][index-1] + Int(columns[index-1].asciiValue!) }
        
        for rowIndex in 1...rowsCount {
            let currentRowChar = rows[rowIndex-1]
            for columnIndex in 1...columnsCount {
                let currentColumnChar = columns[columnIndex-1]
                
                if currentRowChar == currentColumnChar {
                    let previousSum = dpMatrix[rowIndex-1][columnIndex-1]
                    dpMatrix[rowIndex][columnIndex] = previousSum
                } else {
                    let previousRowSum = dpMatrix[rowIndex-1][columnIndex]
                    let previousColumnSum = dpMatrix[rowIndex][columnIndex-1]
                    let currentRowSum = previousRowSum + Int(currentRowChar.asciiValue!)
                    let CurrentColumnSum = previousColumnSum + Int(currentColumnChar.asciiValue!)
                    
                    dpMatrix[rowIndex][columnIndex] = min(currentRowSum, CurrentColumnSum)
                }
            }
        }
        
        return dpMatrix[rowsCount][columnsCount]
    }
}