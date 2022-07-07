// https://leetcode.com/problems/count-number-of-pairs-with-absolute-difference-k

class Solution {
    func countKDifference(_ nums: [Int], _ k: Int) -> Int {
        let numsCount = nums.count
        var output = 0
        
        for i in 0..<numsCount {
            for j in i+1..<numsCount {
                if abs(nums[i] - nums[j]) == k { output += 1 }
            }   
        }
        
        return output
    }
}