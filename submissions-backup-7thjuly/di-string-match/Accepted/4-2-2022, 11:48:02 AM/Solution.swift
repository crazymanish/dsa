// https://leetcode.com/problems/di-string-match

class Solution {
    func diStringMatch(_ s: String) -> [Int] {
        let sCount = s.count
        
        var increasingPointer = 0 // for 'I' chars
        var decreasingPointer = sCount // for 'D' chars
        var output: [Int] = []
        
        for char in s {
            if char == "I" {
                output.append(increasingPointer)
                increasingPointer += 1
            } else {
                output.append(decreasingPointer)
                decreasingPointer -= 1
            }
        }
        
        output.append(decreasingPointer)
        
        return output
    }
}