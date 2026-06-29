class Solution {
    /**
     Problem Summary:
     Count how many strings in `patterns` appear as substrings of `word`.
     
     Strategy:
     - Iterate through each pattern.
     - Use Swift's built-in `contains(_:)` to check whether `word`
       contains the current pattern.
     - Count every successful match.
     
     Time Complexity:
     - O(n × m) on average, where:
       - n = number of patterns
       - m = length of `word`
       (Actual complexity depends on the implementation of `contains`.)
     
     Space Complexity:
     - O(1)
     */
    func numOfStrings(_ patterns: [String], _ word: String) -> Int {
        var matchingPatternCount = 0

        // Count every pattern that appears as a substring of `word`.
        for pattern in patterns where word.contains(pattern) {
            matchingPatternCount += 1
        }

        return matchingPatternCount
    }
}