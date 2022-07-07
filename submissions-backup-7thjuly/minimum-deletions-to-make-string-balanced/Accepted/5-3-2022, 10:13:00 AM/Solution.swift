// https://leetcode.com/problems/minimum-deletions-to-make-string-balanced

class Solution {
    func minimumDeletions(_ s: String) -> Int {
        var prefixBCount = 0
        var minimumDeletionsCount = 0
        
        for char in s {
            if char == "b" {
                prefixBCount += 1
            } else if char == "a" && prefixBCount > 0 {
                prefixBCount -= 1
                minimumDeletionsCount += 1
            }
        }
        
        return minimumDeletionsCount
    }
}