// https://leetcode.com/problems/count-equal-and-divisible-pairs-in-an-array

class Solution {
    func countPairs(_ nums: [Int], _ k: Int) -> Int {
        let numsCount = nums.count
        var output = 0
        
        for i in 0..<numsCount {
            for j in i+1..<numsCount {
                if nums[i] == nums[j] && (i * j) % k == 0 { output += 1 }
            }   
        }
        
        return output
    }
}