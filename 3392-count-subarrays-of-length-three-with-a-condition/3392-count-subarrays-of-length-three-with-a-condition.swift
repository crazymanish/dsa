class Solution {
    /// Counts the number of subarrays of length 3 within the input array `nums`
    /// such that the sum of the first and third elements equals exactly half
    /// of the second element.
    ///
    /// - Parameter nums: The input array of integers.
    /// - Returns: The total count of subarrays meeting the condition.
    ///
    /// Constraints:
    ///   - 3 <= nums.length <= 100
    ///   - -100 <= nums[i] <= 100
    ///
    /// Complexity:
    ///   - Time: O(n), where n is the length of `nums`. We iterate through the array once.
    ///   - Space: O(1), as we only use a fixed amount of extra space.
    func countSubarrays(_ nums: [Int]) -> Int {
        let n = nums.count
        var count = 0

        // The constraints state n >= 3, but a guard is good practice
        // in case constraints change or for general robustness.
        guard n >= 3 else {
            return 0 // No subarrays of length 3 possible
        }

        // Iterate through all possible starting indices `i` for a subarray of length 3.
        // The loop needs to stop when `i+2` is the last index, so `i` goes up to `n-3`.
        // The range `0..<(n - 2)` achieves this, covering indices 0, 1, ..., n-3.
        for i in 0..<(n - 2) {
            let first = nums[i]
            let second = nums[i+1]
            let third = nums[i+2]

            // Check the condition: first + third == second / 2
            // Use multiplication to avoid potential integer division or floating-point issues:
            // 2 * (first + third) == second
            if 2 * (first + third) == second {
                count += 1 // Increment count if the condition is met
            }
        }

        return count // Return the final count
    }
}
