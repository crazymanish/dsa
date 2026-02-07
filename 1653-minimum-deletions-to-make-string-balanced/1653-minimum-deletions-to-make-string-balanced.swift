class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n), where n = s.count
    ///     We scan the string once.
    ///
    /// Space Complexity:
    ///   • O(1)
    ///     Only a few integer variables are used.
    ///
    /// Problem Summary:
    ///   Given a string consisting only of 'a' and 'b',
    ///   delete the minimum number of characters so that
    ///   the string becomes balanced:
    ///
    ///       all 'a's appear before all 'b's
    ///
    /// Approach:
    ///   Instead of thinking in terms of deletions, we find the
    ///   longest valid subsequence of the form:
    ///
    ///       "aaaa...bbbb..."
    ///
    ///   Then:
    ///       minimum deletions = total length - longest valid subsequence length
    ///
    /// DP Meaning:
    ///   - longestEndingWithA:
    ///       length of the longest valid subsequence ending with 'a'
    ///   - longestEndingWithB:
    ///       length of the longest valid subsequence ending with 'b'
    ///
    /// Transition:
    ///   - If current char == 'a':
    ///         longestEndingWithA += 1
    ///   - If current char == 'b':
    ///         longestEndingWithB = max(longestEndingWithA, longestEndingWithB) + 1
    /// -----------------------------------------------------------------------
    func minimumDeletions(_ s: String) -> Int {
        var longestEndingWithA = 0
        var longestEndingWithB = 0
        
        for character in s {
            if character == "a" {
                // Extend the subsequence that ends with 'a'
                longestEndingWithA += 1
            } else {
                // Extend the best subsequence seen so far and end with 'b'
                longestEndingWithB =
                    max(longestEndingWithA, longestEndingWithB) + 1
            }
        }
        
        // The longest valid subsequence length
        let longestValidLength =
            max(longestEndingWithA, longestEndingWithB)
        
        // Minimum deletions needed
        return s.count - longestValidLength
    }
}
