// https://leetcode.com/problems/count-binary-substrings

class Solution {
    func countBinarySubstrings(_ s: String) -> Int {
        if s.isEmpty { return 0 }
        
        var sArray = Array(s)
        var previousConsecutiveCharsCount = 0
        var currentConsecutiveCharsCount = 1
        var output = 0
        
        for index in 1..<sArray.count {
            let previousIndexChar = sArray[index-1]
            let currentIndexChar = sArray[index]
            
            if previousIndexChar == currentIndexChar {
                currentConsecutiveCharsCount += 1
            } else {
                output += min(previousConsecutiveCharsCount, currentConsecutiveCharsCount)
                
                previousConsecutiveCharsCount = currentConsecutiveCharsCount
                currentConsecutiveCharsCount = 1
            }
        }
        
        output += min(previousConsecutiveCharsCount, currentConsecutiveCharsCount)
        
        return output
    }
}