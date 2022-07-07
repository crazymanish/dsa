// https://leetcode.com/problems/uncrossed-lines

class Solution {
    func maxUncrossedLines(_ nums1: [Int], _ nums2: [Int]) -> Int {
        return longestCommonSubsequence(nums1, nums2)
    }
    // Ditto question: 1143. Longest Common Subsequence
    // https://leetcode.com/problems/longest-common-subsequence/
    private func longestCommonSubsequence(_ nums1: [Int], _ nums2: [Int]) -> Int {
        let rows = nums1
        let columns = nums2
        
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