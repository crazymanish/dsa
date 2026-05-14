class Solution {
    /**
     Problem Summary:
     Determine whether `nums` is a "good" array.
     A good array of length `n + 1` must contain:
     - Every integer from `1` to `n - 1` exactly once
     - The integer `n` exactly twice

     Strategy:
     - Let `maxExpectedValue = nums.count - 1`.
     - Use a frequency array to count how often each valid value appears.
     - Reject immediately if a value is outside the valid range `1...n`.
     - After counting:
       - Values `1...(n - 1)` must appear exactly once.
       - Value `n` must appear exactly twice.

     Time Complexity:
     O(n), where `n` is `nums.count`.

     Space Complexity:
     O(n), due to the frequency array.
     */
    func isGood(_ nums: [Int]) -> Bool {
        let maxExpectedValue = nums.count - 1
        var frequencies = Array(repeating: 0, count: maxExpectedValue + 1)

        // Count each value while rejecting invalid values early.
        for value in nums {
            guard value >= 1 && value <= maxExpectedValue else {
                return false
            }

            frequencies[value] += 1
        }

        // Values from 1 to n - 1 must appear exactly once.
        for value in 1..<maxExpectedValue {
            if frequencies[value] != 1 {
                return false
            }
        }

        // The maximum value n must appear exactly twice.
        return frequencies[maxExpectedValue] == 2
    }
}