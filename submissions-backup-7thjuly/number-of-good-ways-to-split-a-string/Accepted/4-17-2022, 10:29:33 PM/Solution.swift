// https://leetcode.com/problems/number-of-good-ways-to-split-a-string

class Solution {
    func numSplits(_ s: String) -> Int {
        let sCount = s.count
        let sArray = Array(s)
        
        var rightHashMap: [Character : Int] = [:]
        var rightHashMapCounter = 0
        for char in s {
            if let hashMapValue = rightHashMap[char] {
                rightHashMap[char] = hashMapValue + 1
            } else {
                rightHashMap[char] = 1
                rightHashMapCounter += 1
            }
        }
        
        var leftHashMap: [Character : Int] = [:]
        var leftHashMapCounter = 0
        
        var outputNumSplits = 0
        
        for char in s {
            if let hashMapValue = leftHashMap[char] {
                leftHashMap[char] = hashMapValue + 1
            } else {
                leftHashMap[char] = 1
                leftHashMapCounter += 1
            }
            
            rightHashMap[char] = rightHashMap[char]! - 1
            if rightHashMap[char] == 0 { rightHashMapCounter -= 1 }
            
            if leftHashMapCounter == rightHashMapCounter { outputNumSplits += 1 }
        }
        
        return outputNumSplits
    }
}