class Solution {
    /// -----------------------------------------------------------------------
    /// Problem Summary:
    ///   Count the number of non-empty substrings that:
    ///     • contain only '0's and '1's
    ///     • have equal number of consecutive 0s and 1s
    ///     • all 0s and all 1s in the substring are grouped consecutively
    ///
    /// Example:
    ///   "00110011" → valid substrings like "0011", "01", "1100", etc.
    ///
    /// Time Complexity:
    ///   • O(n)
    ///     We scan the string once.
    ///
    /// Space Complexity:
    ///   • O(1)
    ///     Only a few counters are used.
    ///
    /// Key Insight:
    ///   We track lengths of consecutive character groups.
    ///   For every adjacent pair of groups:
    ///       valid substrings = min(size_of_group1, size_of_group2)
    /// -----------------------------------------------------------------------
    func countBinarySubstrings(_ s: String) -> Int {
        guard !s.isEmpty else { return 0 }
        
        let characters = Array(s)
        
        var previousGroupLength = 0
        var currentGroupLength = 1
        var totalCount = 0
        
        // Iterate through string
        for index in 1..<characters.count {
            if characters[index] == characters[index - 1] {
                // Extend current group
                currentGroupLength += 1
            } else {
                // Group changed → count valid substrings
                totalCount += min(previousGroupLength, currentGroupLength)
                
                // Shift groups
                previousGroupLength = currentGroupLength
                currentGroupLength = 1
            }
        }
        
        // Account for last pair of groups
        totalCount += min(previousGroupLength, currentGroupLength)
        
        return totalCount
    }
}
