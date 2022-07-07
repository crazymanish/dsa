// https://leetcode.com/problems/flip-string-to-monotone-increasing

class Solution {
    // Ditto question: 1653. Minimum Deletions to Make String Balanced
    // https://leetcode.com/problems/minimum-deletions-to-make-string-balanced/
    func minFlipsMonoIncr(_ s: String) -> Int {
        var prefix1Count = 0
        var minimumDeletionsCount = 0
        
        for char in s {
            if char == "1" {
                prefix1Count += 1
            } else if char == "0" && prefix1Count > 0 {
                prefix1Count -= 1
                minimumDeletionsCount += 1
            }
        }
        
        return minimumDeletionsCount
    }
}