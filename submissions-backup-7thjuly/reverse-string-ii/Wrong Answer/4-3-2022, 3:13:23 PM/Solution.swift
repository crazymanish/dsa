// https://leetcode.com/problems/reverse-string-ii

class Solution {
    func reverseStr(_ s: String, _ k: Int) -> String {
        var sArray: [String] = []
        for char in s { sArray.append(String(char)) }
        
        var index = 0
        
        while index < sArray.count - k + 1 {
            var leftPointer = index
            var rightPointer = index + k - 1
            
            while leftPointer < rightPointer {
                let temp = sArray[leftPointer]
                sArray[leftPointer] = sArray[rightPointer]
                sArray[rightPointer] = temp
                
                leftPointer += 1
                rightPointer -= 1
            }
            
            index += 2*k
        }
        
        return sArray.joined(separator: "")
    }
}