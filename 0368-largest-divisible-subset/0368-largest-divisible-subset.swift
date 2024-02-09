class Solution {
    func largestDivisibleSubset(_ nums: [Int]) -> [Int] {
        let nums = nums.sorted()
        var dp = Array(repeating: [Int](), count: nums.count)
        var answer: [Int] = [nums[0]]
        
        for i in 0..<nums.count {
            dp[i] = [nums[i]]
            for j in 0..<i where nums[i] % nums[j] == 0 {
                guard dp[j].count + 1 > dp[i].count else { continue }
                
                dp[i] = dp[j] + [nums[i]]

                if answer.count < dp[i].count {
                    answer = dp[i]
                }
            }
        }

        return answer
    }
}