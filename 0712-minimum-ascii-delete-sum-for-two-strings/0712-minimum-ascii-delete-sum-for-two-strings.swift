class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(m * n)
    ///     - m = s1.count
    ///     - n = s2.count
    ///     We fill a 2D DP table comparing all character pairs.
    ///
    /// Space Complexity:
    ///   • O(m * n)
    ///     - DP matrix of size (m + 1) × (n + 1)
    ///
    /// Problem Summary:
    ///   Given two strings, delete characters from either string such that
    ///   the resulting strings are equal, minimizing the sum of ASCII values
    ///   of deleted characters.
    ///
    /// DP Definition:
    ///   dp[i][j] = minimum ASCII delete sum to make:
    ///              s1[0..<i] and s2[0..<j] equal
    ///
    /// Transition:
    ///   - If s1[i-1] == s2[j-1]:
    ///         dp[i][j] = dp[i-1][j-1]
    ///   - Else:
    ///         dp[i][j] = min(
    ///             dp[i-1][j] + ASCII(s1[i-1]),   // delete from s1
    ///             dp[i][j-1] + ASCII(s2[j-1])    // delete from s2
    ///         )
    /// -----------------------------------------------------------------------
    func minimumDeleteSum(_ s1: String, _ s2: String) -> Int {
        // Convert strings to character arrays for O(1) indexing
        let firstChars = Array(s1)
        let secondChars = Array(s2)
        
        let firstLength = firstChars.count
        let secondLength = secondChars.count
        
        // dp[row][col] represents minimum delete sum for prefixes
        var dp = Array(
            repeating: Array(repeating: 0, count: secondLength + 1),
            count: firstLength + 1
        )
        
        // Base case: delete all characters from s1
        for i in 1...firstLength {
            dp[i][0] = dp[i - 1][0] + Int(firstChars[i - 1].asciiValue!)
        }
        
        // Base case: delete all characters from s2
        for j in 1...secondLength {
            dp[0][j] = dp[0][j - 1] + Int(secondChars[j - 1].asciiValue!)
        }
        
        // Fill the DP table
        for i in 1...firstLength {
            let charFromFirst = firstChars[i - 1]
            
            for j in 1...secondLength {
                let charFromSecond = secondChars[j - 1]
                
                if charFromFirst == charFromSecond {
                    // Characters match, no deletion needed
                    dp[i][j] = dp[i - 1][j - 1]
                } else {
                    // Choose the cheaper deletion
                    let deleteFromFirst =
                        dp[i - 1][j] + Int(charFromFirst.asciiValue!)
                    
                    let deleteFromSecond =
                        dp[i][j - 1] + Int(charFromSecond.asciiValue!)
                    
                    dp[i][j] = min(deleteFromFirst, deleteFromSecond)
                }
            }
        }
        
        // Final answer for full strings
        return dp[firstLength][secondLength]
    }
}
