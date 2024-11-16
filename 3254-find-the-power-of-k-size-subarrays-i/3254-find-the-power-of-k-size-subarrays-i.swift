class Solution {
    func resultsArray(_ nums: [Int], _ k: Int) -> [Int] {
        var streak = 0 // Consecutive number count.
        var results = [Int]()

        for i in nums.indices {
            if i > 0 && nums[i] == nums[i-1] + 1 {
                streak = min(k, streak+1) // Last 2 numbers are consecutive.
            } else {
                streak = 1 // Non-consecutive numbers.
            }

            // Append max ("nums[i]") if k consecutive numbers.
            // Or -1 otherwise.
            if i+1 >= k { results.append(streak==k ? nums[i] : -1) }
        }

        return results
    }
}