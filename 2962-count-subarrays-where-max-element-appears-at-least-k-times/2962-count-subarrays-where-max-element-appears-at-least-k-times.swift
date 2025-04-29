class Solution {
    /**
     Counts the number of contiguous subarrays that contain the maximum value of the array at least `k` times.

     - Parameter numbers: The input array of integers.
     - Parameter k: The minimum number of times the maximum value must appear in a subarray for it to be counted.
     - Returns: The total count of such subarrays.

     - Complexity:
        - Time: O(N), where N is the number of elements in `numbers`.
            - Finding the maximum value takes O(N).
            - The sliding window approach iterates through the array with two pointers (`windowStart`, `windowEnd`). Each pointer traverses the array at most once. Thus, the loop structure takes O(N) time.
            - Total time is O(N) + O(N) = O(N).
        - Space: O(1).
            - Only a few variables are used for pointers, counts, and the maximum value, requiring constant extra space.
     */
    func countSubarrays(_ numbers: [Int], _ k: Int) -> Int {
        // Find the maximum value in the array. Takes O(N) time.
        guard let maxValue = numbers.max() else {
            // If the array is empty, there are no subarrays.
            return 0
        }
        // If k is 0 or negative, the condition "at least k occurrences" is ill-defined
        // or trivially true for all non-empty subarrays if k=0.
        // Assuming k must be positive based on typical problem constraints.
        // If k=1, we count subarrays containing the max value at least once.
         guard k > 0 else {
             // Or handle k=0 based on specific problem interpretation (e.g., return total possible subarrays N*(N+1)/2 if k=0?)
             // Assuming k >= 1 for valid counting.
             return 0 // No subarrays can have a non-positive number of occurrences.
         }

        var maxElementCountInWindow = 0 // Counter for occurrences of maxValue in the current window [windowStart...windowEnd]
        var totalSubarrayCount = 0      // Accumulator for the final answer
        var windowStart = 0             // Left pointer of the sliding window

        // Iterate through the array with the right pointer of the sliding window.
        // O(N) iterations for this loop.
        for windowEnd in numbers.indices {
            // If the element entering the window is the maximum value, increment the count.
            if numbers[windowEnd] == maxValue {
                maxElementCountInWindow += 1
            }

            // Shrink the window from the left (`windowStart`) as long as the current window
            // [windowStart...windowEnd] contains *at least* k occurrences of maxValue.
            // The inner while loop runs at most N times in total across all outer loop iterations
            // because windowStart only increases.
            while maxElementCountInWindow >= k {
                // If the element leaving the window is the maximum value, decrement the count.
                if numbers[windowStart] == maxValue {
                    maxElementCountInWindow -= 1
                }
                // Shrink the window by moving the left pointer.
                windowStart += 1
            }

            // After the while loop, `windowStart` is the smallest index such that the window
            // `numbers[windowStart...windowEnd]` contains *fewer* than `k` occurrences of `maxValue`.
            // This implies that any subarray ending at `windowEnd` and starting at an index `i`
            // where `0 <= i < windowStart` *must* contain at least `k` occurrences of `maxValue`.
            // The number of such valid starting indices `i` is `windowStart`.
            // Therefore, add `windowStart` to the total count.
            totalSubarrayCount += windowStart
        }

        // Return the total count of subarrays satisfying the condition.
        return totalSubarrayCount
    }
}