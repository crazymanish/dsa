// https://leetcode.com/problems/set-mismatch

class Solution {
    func findErrorNums(_ nums: [Int]) -> [Int] {
        let sortedNums = nums.sorted()
        
        var output: [Int] = []
        var lastNum = 0
        for num in nums {
            if num == lastNum {
                output = [num, num+1]
                break
            }
            lastNum = num
        }
        
        return output
    }
}