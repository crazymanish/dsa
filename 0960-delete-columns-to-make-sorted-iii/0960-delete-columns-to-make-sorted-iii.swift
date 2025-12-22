/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(m² * n)
///     - m = number of columns
///     - n = number of strings
///     - For each column i, we compare it with all previous columns j < i,
///       and for each comparison we check all strings.
///
/// Space Complexity:
///   • O(m)
///     - DP array storing LIS length ending at each column.
///
/// Problem Summary:
///   We want to delete the minimum number of columns so that the remaining
///   columns are lexicographically non-decreasing across all rows.
///
/// Key Insight:
///   This is equivalent to finding the **Longest Non-Decreasing Subsequence
///   of columns**, where column j can come before column i if:
///
///       for every row r:  strs[r][j] ≤ strs[r][i]
///
///   Answer = totalColumns − lengthOfLongestValidSubsequence
/// ---------------------------------------------------------------------------

class Solution {
    func minDeletionSize(_ strs: [String]) -> Int {
        let chars = strs.map(Array.init)
        let columnCount = chars[0].count
        
        // dp[i] = length of the longest valid subsequence ending at column i
        let dp = (0..<columnCount).reduce(into: [Int]()) { dp, currentCol in
            
            // Find best dp[j] where j < currentCol
            // and column j can come before currentCol
            let bestPrevious = (0..<currentCol)
                .filter { prevCol in
                    chars.allSatisfy { row in
                        row[prevCol] <= row[currentCol]
                    }
                }
                .map { dp[$0] }
                .max()
            
            // Either extend a previous subsequence or start fresh
            dp.append((bestPrevious ?? 0) + 1)
        }
        
        // Minimum deletions = total columns - longest valid subsequence
        return columnCount - (dp.max() ?? 0)
    }
}
