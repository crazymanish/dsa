class Solution {
    /**
     * Calculates the minimum equal sum that can be achieved from two integer arrays, `nums1` and `nums2`.
     * Zeros in the arrays can be replaced by any positive integer (>= 1).
     * If it's impossible to make the sums equal under these conditions, -1 is returned.
     *
     * The logic is as follows:
     * 1. For each array, calculate the sum of its non-zero elements (`sumNonZeros1`, `sumNonZeros2`)
     * and the count of zero elements (`zerosInNums1`, `zerosInNums2`).
     * 2. Determine the minimum possible sum each array can achieve if all its zeros are replaced by 1.
     * `minPossibleSum1 = sumNonZeros1 + zerosInNums1`
     * `minPossibleSum2 = sumNonZeros2 + zerosInNums2`
     * 3. If these minimum possible sums are already equal (`minPossibleSum1 == minPossibleSum2`),
     * this is the smallest equal sum we can achieve.
     * 4. If `minPossibleSum1 < minPossibleSum2`:
     * - The target sum must be at least `minPossibleSum2`.
     * - We check if `nums1` can achieve `minPossibleSum2`. This is possible if `nums1` contains at least one zero
     * (`zerosInNums1 > 0`), which can be increased to cover the difference `minPossibleSum2 - minPossibleSum1`
     * (while other zeros in `nums1` remain 1). If so, the answer is `minPossibleSum2`.
     * - If `nums1` has no zeros, its sum is fixed and cannot reach `minPossibleSum2`, so it's impossible (-1).
     * 5. If `minPossibleSum2 < minPossibleSum1`:
     * - This is symmetric to the case above. The target sum must be at least `minPossibleSum1`.
     * - We check if `nums2` can achieve `minPossibleSum1`. This is possible if `nums2` contains at least one zero
     * (`zerosInNums2 > 0`). If so, the answer is `minPossibleSum1`.
     * - If `nums2` has no zeros, its sum is fixed and cannot reach `minPossibleSum1`, so it's impossible (-1).
     *
     * - Parameters:
     * - nums1: The first array of integers.
     * - nums2: The second array of integers.
     * - Returns: The minimum equal sum achievable, or -1 if it's impossible.
     *
     * - Time Complexity: O(N1 + N2), where N1 is the length of `nums1` and N2 is the length of `nums2`.
     * This is due to iterating through each array once for `reduce` and once for `filter`.
     * (Note: This can be optimized to a single pass per array to calculate both sum and zero count simultaneously).
     *
     * - Space Complexity: O(N1 + N2) in the worst case for the auxiliary space used by `filter`.
     * `filter` creates a new array containing the filtered elements. If all elements are zeros,
     * the filtered array will be of the same size as the input.
     * (Note: This can be optimized to O(1) auxiliary space by manually counting zeros in a loop).
     */
    func minSum(_ nums1: [Int], _ nums2: [Int]) -> Int {
        // Calculate the sum of non-zero elements and the count of zeros for nums1.
        // `baseSum1` accumulates the sum of all numbers in nums1. Since 0s add 0,
        // this effectively becomes the sum of non-zero elements.
        let baseSum1 = nums1.reduce(0, +)
        let zerosInNums1 = nums1.filter { $0 == 0 }.count

        // Calculate the sum of non-zero elements and the count of zeros for nums2.
        let baseSum2 = nums2.reduce(0, +)
        let zerosInNums2 = nums2.filter { $0 == 0 }.count
        
        // Calculate the minimum possible sum for nums1 if all its zeros are replaced by 1.
        // Each zero must be replaced by at least 1.
        let minPossibleSum1 = baseSum1 + zerosInNums1
        // Calculate the minimum possible sum for nums2 if all its zeros are replaced by 1.
        let minPossibleSum2 = baseSum2 + zerosInNums2

        // Case 1: The minimum possible sums are already equal.
        // This means by replacing all zeros in both arrays with 1, their sums match.
        // This is the smallest equal sum possible.
        if minPossibleSum1 == minPossibleSum2 {
            return minPossibleSum1
        }

        // Case 2: Minimum sum of nums1 is less than minimum sum of nums2.
        if minPossibleSum1 < minPossibleSum2 {
            // To make sums equal, nums1's sum needs to be increased to at least minPossibleSum2.
            // This is only possible if nums1 has zeros that can be assigned values greater than 1.
            // If nums1 has at least one zero, we can make its sum equal to minPossibleSum2.
            // (e.g., make one zero = 1 + (minPossibleSum2 - minPossibleSum1), other zeros = 1).
            // The target equal sum would then be minPossibleSum2.
            if zerosInNums1 > 0 {
                return minPossibleSum2
            } else {
                // nums1 has no zeros, so its sum (baseSum1, which is minPossibleSum1) is fixed.
                // It cannot be increased to match minPossibleSum2.
                return -1
            }
        } else { // Case 3: minPossibleSum2 < minPossibleSum1 (since minPossibleSum1 != minPossibleSum2)
            // To make sums equal, nums2's sum needs to be increased to at least minPossibleSum1.
            // This is only possible if nums2 has zeros.
            // If nums2 has at least one zero, we can make its sum equal to minPossibleSum1.
            // The target equal sum would then be minPossibleSum1.
            if zerosInNums2 > 0 {
                return minPossibleSum1
            } else {
                // nums2 has no zeros, so its sum (baseSum2, which is minPossibleSum2) is fixed.
                // It cannot be increased to match minPossibleSum1.
                return -1
            }
        }
    }
}
