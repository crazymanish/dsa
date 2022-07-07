// https://leetcode.com/problems/longest-common-subsequence

// Using Dynamic programming with Top-down matrix
class Solution {
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
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

/*
// Using Dynamic programming with recursion + Cache
class Solution {
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        let text1Array = Array(text1)
        let text2Array = Array(text2)
        
        let text1Count = text1Array.count
        let text2Count = text2Array.count
        
        var dpCache = Array(repeating: Array(repeating: -1, count: text2Count+1), count: text1Count+1)
        
        func findLongestCommonSubsequence(_ text1Count: Int, _ text2Count: Int) -> Int {
            if text1Count == 0 || text2Count == 0 { return 0 }
            
            if dpCache[text1Count][text2Count] != -1 { return dpCache[text1Count][text2Count] }
            
            let longestCommonSubsequence: Int
            
            if text1Array[text1Count-1] == text2Array[text2Count-1] {
                longestCommonSubsequence = 1 + findLongestCommonSubsequence(text1Count-1, text2Count-1)
            } else {
                let text1LongestCommonSubsequence = findLongestCommonSubsequence(text1Count, text2Count-1)
                let text2LongestCommonSubsequence = findLongestCommonSubsequence(text1Count-1, text2Count)
                longestCommonSubsequence = max(text1LongestCommonSubsequence, text2LongestCommonSubsequence)
            }
            
            dpCache[text1Count][text2Count] = longestCommonSubsequence
            return longestCommonSubsequence
        }
        
        return findLongestCommonSubsequence(text1Count, text2Count) 
    }
}
*/