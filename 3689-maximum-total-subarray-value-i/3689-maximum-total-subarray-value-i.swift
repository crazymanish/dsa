class Solution {
    /**
     Problem Summary:
     Given an integer array `nums` and an integer `k`, return the maximum total value
     by using the largest possible difference between any two numbers, repeated `k` times.

     Strategy:
     The maximum value of `max(subarray) - min(subarray)` across the array is simply
     the global maximum minus the global minimum. Since this value can be chosen `k`
     times, the answer is `(maximumNumber - minimumNumber) * k`.

     Time Complexity: O(n), where n is the number of elements in `nums`.
     Space Complexity: O(1), only constant extra space is used.
     */
    func maxTotalValue(_ nums: [Int], _ k: Int) -> Int {
        var minimumNumber = nums[0]
        var maximumNumber = nums[0]

        // Scan once to find both the smallest and largest values.
        for number in nums {
            minimumNumber = min(minimumNumber, number)
            maximumNumber = max(maximumNumber, number)
        }

        // The best possible value is the full range of the array, repeated k times.
        return (maximumNumber - minimumNumber) * k
    }
}