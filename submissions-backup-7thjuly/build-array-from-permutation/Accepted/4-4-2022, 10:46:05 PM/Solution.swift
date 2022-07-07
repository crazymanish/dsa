// https://leetcode.com/problems/build-array-from-permutation

class Solution {
    func buildArray(_ nums: [Int]) -> [Int] {
        var output: [Int] = []
        
        for num in nums { output.append(nums[num]) }
        
        return output
    }
}