/**
 Problem Summary:
 Find the smallest integer not present in `nums`, starting from the sum
 of the longest consecutive prefix.

 Strategy:
 1. Calculate the sum of the longest consecutive prefix.
 2. Store all values in a `Set` for constant-time lookups.
 3. Increment the sum until an absent value is found.

 Time Complexity: O(n)
 Space Complexity: O(n)
 */
class Solution {
    func missingInteger(_ nums: [Int]) -> Int {
        // Store all numbers for O(1) average-time membership checks.
        let numbers = Set(nums)

        // Calculate the sum of the longest consecutive prefix.
        var consecutivePrefixSum = nums[0]

        for index in 0..<(nums.count - 1) {
            guard nums[index] + 1 == nums[index + 1] else {
                break
            }

            consecutivePrefixSum += nums[index + 1]
        }

        // Find the first value not present in the input.
        var candidate = consecutivePrefixSum

        while numbers.contains(candidate) {
            candidate += 1
        }

        return candidate
    }
}