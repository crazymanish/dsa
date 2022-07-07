// https://leetcode.com/problems/delete-operation-for-two-strings

class Solution {
    func minDistance(_ word1: String, _ word2: String) -> Int {
        let lcs = longestCommonSubsequence(word1, word2)
        
        return (word1.count - lcs) + (word2.count - lcs)
    }

    private func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        let rows = Array(text1)
        let columns = Array(text2)
        
        let rowsCount = rows.count
        let columnsCount = columns.count
        
        var dpMatrix = Array(repeating: Array(repeating: 0, count: columnsCount+1), count: rowsCount+1)
        
        for rowIndex in 1...rowsCount {
            let currentRowChar = rows[rowIndex-1]
            for columnIndex in 1...columnsCount {
                let currentColumnChar = columns[columnIndex-1]
                
                if currentRowChar == currentColumnChar {
                    let previousLCS = dpMatrix[rowIndex-1][columnIndex-1]
                    dpMatrix[rowIndex][columnIndex] = 1 + previousLCS
                } else {
                    let previousRowLCS = dpMatrix[rowIndex-1][columnIndex]
                    let previousColumnLCS = dpMatrix[rowIndex][columnIndex-1]
                    let previousLCS = max(previousRowLCS, previousColumnLCS)
                    
                    dpMatrix[rowIndex][columnIndex] = previousLCS
                }
            }
        }
        
        return dpMatrix[rowsCount][columnsCount]
    }
}