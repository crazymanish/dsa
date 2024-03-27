class Solution {
    func numSubarrayProductLessThanK(_ nums: [Int], _ k: Int) -> Int {
        var product = 1
        var factor: [Int] = []
        var dp = Array(repeating: 0, count: nums.count + 1)
        
        for i in 0..<nums.count {
            product *= nums[i]
            factor.append(nums[i])
            
            while product >= k && factor.count > 0 {
                product /= factor.removeFirst()
            }
            
            dp[i+1] = dp[i] + (factor.count + (factor.count + 1)) / 2
        }
        
        return dp[nums.count]
    }
}