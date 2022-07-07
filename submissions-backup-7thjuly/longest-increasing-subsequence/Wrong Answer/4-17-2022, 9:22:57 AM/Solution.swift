// https://leetcode.com/problems/longest-increasing-subsequence

class Solution {
    // Variation of LCS
    // 1143. Longest Common Subsequence
    // https://leetcode.com/problems/longest-common-subsequence/
    func lengthOfLIS(_ nums: [Int]) -> Int {
        if nums.count == 1 { return 1 }
        
        let rows = nums
        let columns = nums
        
        let rowsCount = rows.count
        let columnsCount = columns.count
        
        // Init with 1 instead of 0
        var dpMatrix = Array(repeating: Array(repeating: 1, count: columnsCount+1), count: rowsCount+1)
        
        for rowIndex in 1...rowsCount {
            let currentRowChar = rows[rowIndex-1]
            for columnIndex in 2...columnsCount {
                let currentColumnChar = columns[columnIndex-1]
                let previousLCS = dpMatrix[rowIndex-1][columnIndex-1]
                
                // This condition changed compared to original LCS for finding Increasing
                if currentColumnChar > currentRowChar && currentColumnChar > columns[columnIndex-2] {
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