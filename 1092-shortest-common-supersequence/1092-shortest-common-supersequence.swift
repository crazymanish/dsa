class Solution {
    func shortestCommonSupersequence(_ str1: String, _ str2: String) -> String {
        // Calculate the LCS using dynamic programming
        let lcsMatrix = calculateLongestCommonSubsequence(str1, str2)

        // Combine the strings and remove the LCS to get the SCS
        let shortestCommonSuperseq = combineStrings(Array(str1), Array(str2), lcsMatrix)

        return String(shortestCommonSuperseq.reversed())
    }

    // Reusing code: 1143. Longest Common Subsequence
    // https://leetcode.com/problems/longest-common-subsequence/
    // Calculates the LCS of two strings using dynamic programming
    private func calculateLongestCommonSubsequence(_ text1: String, _ text2: String) -> [[Int]] {
        let rows = Array(text1)
        let columns = Array(text2)
        let rowsCount = rows.count
        let columnsCount = columns.count

        var lcsMatrix = Array(repeating: Array(repeating: 0, count: columnsCount + 1), count: rowsCount + 1)

        for row in 1...rowsCount {
            for column in 1...columnsCount {
                if rows[row - 1] == columns[column - 1] {
                    lcsMatrix[row][column] = 1 + lcsMatrix[row - 1][column - 1]
                } else {
                    lcsMatrix[row][column] = max(lcsMatrix[row - 1][column], lcsMatrix[row][column - 1])
                }
            }
        }

        return lcsMatrix
    }

    // Combines the strings based on the LCS matrix to create the SCS
    private func combineStrings(_ str1: [Character], _ str2: [Character], _ lcsMatrix: [[Int]]) -> String {
        var str1Index = str1.count
        var str2Index = str2.count
        var result = ""

        while str1Index > 0 && str2Index > 0 {
            if str1[str1Index - 1] == str2[str2Index - 1] {
                result.append(str1[str1Index - 1])
                str1Index -= 1
                str2Index -= 1
            } else {
                if lcsMatrix[str1Index - 1][str2Index] > lcsMatrix[str1Index][str2Index - 1] {
                    result.append(str1[str1Index - 1])
                    str1Index -= 1
                } else {
                    result.append(str2[str2Index - 1])
                    str2Index -= 1
                }
            }
        }

        while str1Index > 0 {
            result.append(str1[str1Index - 1])
            str1Index -= 1
        }

        while str2Index > 0 {
            result.append(str2[str2Index - 1])
            str2Index -= 1
        }

        return result
    }
}