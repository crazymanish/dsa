/*
Time Complexity: O(N)
The algorithm must iterate through the input array of size N at least once to inspect all numbers. Operations like creating a Set from an array, filtering, and finding the maximum all take time proportional to N.

Space Complexity: O(K)
A Set is used to store the unique numbers. In the worst case, if all K unique numbers are positive, the set will store K elements. If all numbers in the input array are unique, this becomes O(N).
*/
class Solution {
    /// Calculates the sum of unique positive numbers in an array.
    /// If no unique positive numbers are found, it returns the overall maximum number in the array.
    func maxSum(_ nums: [Int]) -> Int {
        // 1. Find all unique positive numbers using a Set for automatic de-duplication.
        let uniquePositives = Set(nums.filter { $0 > 0 })

        // 2. If we found any unique positive numbers, return their sum.
        if !uniquePositives.isEmpty {
            return uniquePositives.reduce(0, +)
        } else {
            // 3. Otherwise, find and return the largest number in the original array.
            //    This handles cases with only negative numbers, zeros, or an empty input.
            //    We return 0 for an empty input array as a sensible default.
            return nums.max() ?? 0
        }
    }
}