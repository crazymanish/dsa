/**
 Problem Summary:
 Find the length of the longest subsequence whose bitwise XOR is non-zero.

 Strategy:
 - XOR all elements in the array.
 - If the XOR of the entire array is non-zero, the full array is valid.
 - If the total XOR is zero but not all elements are zero, removing any
   non-zero element makes the XOR non-zero, so the answer is `n - 1`.
 - If every element is zero, every subsequence has XOR zero.

 Time Complexity: O(n)
 Space Complexity: O(1)
 */
class Solution {
    func longestSubsequence(_ nums: [Int]) -> Int {
        var totalXOR = 0

        // Calculate the XOR of all elements.
        for number in nums {
            totalXOR ^= number
        }

        // The entire array is already a valid subsequence.
        if totalXOR != 0 {
            return nums.count
        }

        // If every element is zero, no subsequence can have a non-zero XOR.
        if nums.allSatisfy({ $0 == 0 }) {
            return 0
        }

        // Removing one non-zero element changes the total XOR to non-zero.
        return nums.count - 1
    }
}