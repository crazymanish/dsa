// https://leetcode.com/problems/shortest-common-supersequence

class Solution {
    func shortestCommonSupersequence(_ str1: String, _ str2: String) -> String {
        // Step1: Calculate the LCS...
        let dpMatrix = longestCommonSubsequence(str1, str2)

        // Step2: Perform "(str1 + str2 - lcs) operation" & tricky part is we need to maintain order
        let output = combine(Array(str1), Array(str2), dpMatrix)

        return String(output.reversed())
    }

    // Reusing code: 1143. Longest Common Subsequence
    // https://leetcode.com/problems/longest-common-subsequence/
    private func longestCommonSubsequence(_ text1: String, _ text2: String) -> [[Int]] {
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

        return dpMatrix
    }

    private func combine(_ str1: [Character], _ str2: [Character], _ dp: [[Int]]) -> String {
        var i = str1.count
        var j = str2.count
        var result = ""

        while i > 0 && j > 0 {
            if str1[i-1] == str2[j-1] {
                result += "\(str1[i-1])"
                i -= 1
                j -= 1
            } else {
                if dp[i-1][j] > dp[i][j-1] {
                    result += "\(str1[i-1])"
                    i -= 1
                } else {
                    result += "\(str2[j-1])"
                    j -= 1
                }
            }
        }

        while i>0 {
            result += "\(str1[i-1])"
            i -= 1
        }

        while j>0 {
            result += "\(str2[j-1])"
            j -= 1
        }

        return result
    }
}
