class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n²)
    ///     - We fix a left index and expand the right index.
    ///     - Each subarray is examined once.
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     - A dictionary is used to track distinct values in the current window.
    ///
    /// Problem Summary:
    ///   Find the length of the longest subarray where:
    ///     - The number of distinct even values
    ///       equals
    ///     - The number of distinct odd values.
    ///
    /// Approach:
    ///   - Fix a starting index `left`.
    ///   - Expand the ending index `right`.
    ///   - Track distinct numbers using a dictionary.
    ///   - Count how many distinct evens and odds appear.
    ///   - Update the answer whenever the counts match.
    /// -----------------------------------------------------------------------
    func longestBalanced(_ nums: [Int]) -> Int {
        let count = nums.count
        var longestLength = 0
        
        // Fix the starting index
        for leftIndex in 0..<count {
            // Tracks whether a value has appeared in the current subarray
            var seenIndices = [Int: Int]()
            
            var distinctEvenCount = 0
            var distinctOddCount = 0
            
            // Expand the subarray to the right
            for rightIndex in leftIndex..<count {
                let value = nums[rightIndex]
                
                // First time seeing this value in the current window
                if seenIndices[value] == nil {
                    if value % 2 == 0 {
                        distinctEvenCount += 1
                    } else {
                        distinctOddCount += 1
                    }
                }
                
                // Mark value as seen
                seenIndices[value] = rightIndex
                
                // Check if the current subarray is balanced
                if distinctEvenCount == distinctOddCount {
                    longestLength = max(longestLength, rightIndex - leftIndex + 1)
                }
            }
        }
        
        return longestLength
    }
}
