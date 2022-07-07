// https://leetcode.com/problems/smallest-index-with-equal-value

class Solution {
    func smallestEqual(_ nums: [Int]) -> Int {
        var smallestEqual = -1 
        
        for (index, value) in nums.enumerated() {
            let remainder = index % 10
            
            if remainder == value {
                smallestEqual = index
                break
            }
        }
        
        return smallestEqual
    }
}