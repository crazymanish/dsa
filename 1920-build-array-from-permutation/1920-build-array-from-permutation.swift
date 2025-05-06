class Solution {
    /**
     * Builds an array `ans` from a given 0-indexed integer array `nums` according to the rule `ans[i] = nums[nums[i]]`.
     * It's assumed that `nums` is a permutation of integers from `0` to `nums.count - 1`.
     *
     * For example, if `nums = [0, 2, 1, 5, 3, 4]`, then:
     * ans[0] = nums[nums[0]] = nums[0] = 0
     * ans[1] = nums[nums[1]] = nums[2] = 1
     * ans[2] = nums[nums[2]] = nums[1] = 2
     * ans[3] = nums[nums[3]] = nums[5] = 4
     * ans[4] = nums[nums[4]] = nums[3] = 5
     * ans[5] = nums[nums[5]] = nums[4] = 3
     * Result: `[0, 1, 2, 4, 5, 3]`
     *
     * - Parameter nums: A 0-indexed integer array of length `n`. It's assumed that `nums`
     * contains a permutation of integers from `0` to `n-1`, ensuring that
     * `nums[i]` is always a valid index for the `nums` array.
     * - Returns: A new array `resultArray` of length `n` such that `resultArray[i] = nums[nums[i]]`.
     *
     * - Time Complexity: O(N), where N is the number of elements in the `nums` array.
     * The function iterates through the `nums` array once. Array append operations
     * have an amortized time complexity of O(1).
     *
     * - Space Complexity: O(N).
     * A new array `resultArray` of size N is created to store the output.
     * If we consider auxiliary space (space used beyond the input and output),
     * it's O(1) as we are only using a few variables for iteration.
     * However, typically the space for the output array is counted.
     */
    func buildArray(_ nums: [Int]) -> [Int] {
        // Initialize an empty array to store the constructed elements.
        // For performance with large arrays, pre-allocating capacity can be beneficial:
        // var resultArray = Array<Int>(repeating: 0, count: nums.count)
        // and then using `resultArray[i] = ...` in an indexed loop.
        // However, we'll stick to the original structure of appending.
        var resultArray: [Int] = []

        // Iterate through each element of the input `nums` array.
        // In each iteration, `currentValueFromNums` holds the value `nums[i]`
        // (if we were using a traditional index `i`).
        for currentValueFromNums in nums {
            // The problem requires `resultArray[i] = nums[nums[i]]`.
            // Here, `currentValueFromNums` is `nums[i]`.
            // So, `nums[currentValueFromNums]` evaluates to `nums[nums[i]]`.
            // This result is then appended to `resultArray`. Since we iterate
            // through `nums` in order and append sequentially, the `resultArray`
            // is built correctly according to the rule.
            resultArray.append(nums[currentValueFromNums])
        }

        // Return the newly constructed array.
        return resultArray
    }
}