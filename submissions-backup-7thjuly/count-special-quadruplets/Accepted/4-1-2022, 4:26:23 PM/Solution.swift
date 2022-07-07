// https://leetcode.com/problems/count-special-quadruplets

class Solution {
    func countQuadruplets(_ nums: [Int]) -> Int {
        var output: Int = 0
        let arrayCount = nums.count

        guard arrayCount > 3 else { return output }

        for firstNumIndex in 0..<arrayCount - 3 {
            for secondNumIndex in firstNumIndex+1..<arrayCount - 2 {
                for thirdNumIndex in secondNumIndex+1..<arrayCount - 1 {
                    for forthNumIndex in thirdNumIndex+1..<arrayCount {
                        let firstNum = nums[firstNumIndex]
                        let secondNum = nums[secondNumIndex]
                        let thirdNum = nums[thirdNumIndex]
                        let forthNum = nums[forthNumIndex]
                        
                        let currentTarget = firstNum + secondNum + thirdNum
                        if (currentTarget == forthNum) {
                            output += 1
                        }
                    }
                }
            }
        }

        return output
    }
}