// https://leetcode.com/problems/count-substrings-that-differ-by-one-character

class Solution {
    func countSubstrings(_ s: String, _ t: String) -> Int {
        let sArray = Array(s)
        let tArray = Array(t)
        
        var outputCounter = 0
        
        for sIndex in 0..<sArray.count {
            for tIndex in 0..<tArray.count {
                var diff = 0
                var sCurrentIndex = sIndex
                var tCurrentIndex = tIndex
                while sCurrentIndex < sArray.count && tCurrentIndex < tArray.count {
                    if sArray[sCurrentIndex] != tArray[tCurrentIndex] { diff += 1 }   
                    if diff == 1 { outputCounter += 1 }
                    if diff == 2 { break }
                    
                    sCurrentIndex += 1
                    tCurrentIndex += 1
                }
            }
        }
        
        return outputCounter
    }
}