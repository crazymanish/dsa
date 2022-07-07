// https://leetcode.com/problems/reverse-string-ii

class Solution {
    func reverseStr(_ s: String, _ k: Int) -> String {
        var sArray: [String] = []
        for char in s { sArray.append(String(char)) }
        
        var count = sArray.count
        var mutableK = k
        if k > count { mutableK = count }
        
        var index = 0
        while index < count - mutableK + 1 {
            var leftPointer = index
            var rightPointer = index + mutableK - 1
            
            while leftPointer < rightPointer {
                let temp = sArray[leftPointer]
                sArray[leftPointer] = sArray[rightPointer]
                sArray[rightPointer] = temp
                
                leftPointer += 1
                rightPointer -= 1
            }
            
            index += 2*mutableK
        }
        
        return sArray.joined(separator: "")
    }
}