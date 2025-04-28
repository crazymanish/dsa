class Solution {
    /**
     Calculates the number of contiguous subarrays where the product of the subarray's sum and its length is less than k.

     The "score" of a subarray is defined as (sum of elements) * (length of subarray).
     This function counts how many subarrays have a score strictly less than `scoreThreshold`.

     - Parameter numbers: The input array of integers.
     - Parameter scoreThreshold: The threshold value `k`. Subarrays are counted if their score is less than this value.
     - Returns: The total count of subarrays satisfying the condition.

     - Complexity:
        - Time: O(N log N), where N is the number of elements in `numbers`.
            - Calculating prefix sums takes O(N).
            - The main loop iterates N times (for each `startIndex`).
            - Inside the loop, `findUpperBoundIndex` performs a binary search over a range up to N, taking O(log N) time.
            - Therefore, the total time is dominated by the loop: O(N) + N * O(log N) = O(N log N).
        - Space: O(N), where N is the number of elements in `numbers`.
            - The `prefixSums` array requires O(N) auxiliary space.
            - Other variables use O(1) space.
     */
    func countSubarrays(_ numbers: [Int], _ scoreThreshold: Int) -> Int {
        let count = numbers.count
        // Prevent division by zero or invalid calculations if k is non-positive.
        // Since sum and length are non-negative, their product can only be < k if k > 0.
        guard scoreThreshold > 0 else { return 0 }

        // Calculate prefix sums to efficiently find the sum of any subarray.
        // prefixSums[i] stores the sum of elements numbers[0...i-1].
        // The sum of numbers[start...end] is prefixSums[end + 1] - prefixSums[start].
        // Time: O(N), Space: O(N)
        var prefixSums = Array(repeating: 0, count: count + 1)
        for i in 0..<count {
            // Ensure prefix sum doesn't overflow standard Int limits during calculation.
            // Using Int64 to handle potentially large sums.
            prefixSums[i + 1] = prefixSums[i] + numbers[i]
        }

        /**
         Performs a binary search to find the upper bound index for a valid subarray.
         Time complexity per call: O(log N)
         */
        func findUpperBoundIndex(startingAt startIndex: Int) -> Int {
            var left = startIndex // Start searching from the current startIndex
            var right = count     // Exclusive upper bound for the potential end index (search space size up to N)

            // Binary search loop: O(log N) iterations
            while left < right {
                let mid = left + (right - left) / 2 // O(1)

                let subarrayEndIndexExclusive = mid + 1
                let subarrayLength = subarrayEndIndexExclusive - startIndex // O(1)
                
                guard subarrayLength > 0 else {
                     left = mid + 1 // O(1)
                     continue
                }

                let subarraySum = prefixSums[subarrayEndIndexExclusive] - prefixSums[startIndex] // O(1)
                let currentScore = Int64(subarraySum) * Int64(subarrayLength) // O(1)

                if currentScore < Int64(scoreThreshold) { // O(1)
                    left = mid + 1 // O(1)
                } else {
                    right = mid // O(1)
                }
            }
            return left
        }

        var totalCount = 0 // O(1) space

        // Main loop iterates N times. Time: O(N * log N)
        for startIndex in 0..<count { // N iterations
            // Call binary search: O(log N) time
            let upperBound = findUpperBoundIndex(startingAt: startIndex)

            // O(1) operations
            let countForCurrentStart = upperBound - startIndex
            totalCount += countForCurrentStart
        }

        return totalCount
    }
}