// https://leetcode.com/problems/concatenation-of-array

class Solution {
    func getConcatenation(_ nums: [Int]) -> [Int] {
        let numsCount = nums.count
        var output = Array(repeating: 0, count: 2 * numsCount)
        
        for index in 0..<numsCount {
            let value = nums[index]
            
            output[index] = value
            output[index+numsCount] = value
        }
        
        return output
    }
}