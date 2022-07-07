// https://leetcode.com/problems/shortest-common-supersequence

class Solution {
    func shortestCommonSupersequence(_ str1: String, _ str2: String) -> String {
        // Step1: Calculate the LCS...
        let dpMatrix = longestCommonSubsequence(str1, str2)

        // Step2: Perform "(str1 + str2 - lcs) operation" & tricky part is we need to maintain order
        let output = combine(str1, str2, dpMatrix)

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

    private func combine(_ str1: String, _ str2: String, _ dpMatrix: [[Int]]) -> String {
        let str1Array = Array(str1)
        let str2Array = Array(str2)
        var str1LastIndex = str1Array.count
        var str2LastIndex = str2Array.count

        var output = ""

        while str1LastIndex != 0 || str2LastIndex != 0 {
            let char: Character

            if str1LastIndex == 0 {
                str2LastIndex -= 1
                char = str2Array[str2LastIndex]
            } else if str2LastIndex == 0 {
                str1LastIndex -= 1
                char = str1Array[str1LastIndex]
            } else if str1Array[str1LastIndex-1] == str2Array[str2LastIndex-1] {
                str1LastIndex -= 1
                str2LastIndex -= 1
                char = str1Array[str1LastIndex] // or str2Array[str2LastIndex] // Both char same
            } else if dpMatrix[str1LastIndex-1][str2LastIndex] == dpMatrix[str1LastIndex][str2LastIndex] {
                str1LastIndex -= 1
                char = str1Array[str1LastIndex]
            } else if dpMatrix[str1LastIndex][str2LastIndex-1] == dpMatrix[str1LastIndex][str2LastIndex] {
                str2LastIndex -= 1
                char = str2Array[str2LastIndex]
            } else {
                // noop: no more case
                char = "F" // we are fucked, if we reach here...
            }

            output = String(char) + output
        }

        return output
    }
}
