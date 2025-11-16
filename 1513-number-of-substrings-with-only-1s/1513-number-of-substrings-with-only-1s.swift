/**
 Counts the number of substrings made entirely of '1's.

 Time Complexity:  O(n)
   - Each character is visited once while scanning consecutive runs of 1s.

 Space Complexity: O(1)
   - Only constant extra variables.
 */
class Solution {
    func numSub(_ s: String) -> Int {
        let chars = Array(s)
        let count = chars.count
        let mod = 1_000_000_007
        
        var totalSubstrings = 0
        var startIndex = 0
        
        while startIndex < count {
            // If current character is '1', count the full run
            if chars[startIndex] == "1" {
                var runLength = 0
                var runEndIndex = startIndex
                
                // Count consecutive 1's starting at startIndex
                while runEndIndex < count && chars[runEndIndex] == "1" {
                    runLength += 1
                    runEndIndex += 1
                }
                
                // A run of length L contributes L*(L+1)/2 substrings
                totalSubstrings = (totalSubstrings + runLength * (runLength + 1) / 2) % mod
                
                // Jump to the first non-'1' character after the run
                startIndex = runEndIndex
            } else {
                // Skip zeros
                startIndex += 1
            }
        }
        
        return totalSubstrings
    }
}
