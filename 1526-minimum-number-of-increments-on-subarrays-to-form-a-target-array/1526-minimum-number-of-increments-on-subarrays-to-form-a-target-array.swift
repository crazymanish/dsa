class Solution {
    /**
     * Calculates the minimum number of operations to make an array of zeros
     * equal to the `target` array, where an operation consists of
     * incrementing a continuous subarray by 1.
     *
     * The logic is that the total number of operations is equal to the
     * sum of all "new" operations. A "new" operation is required
     * only when the current element is *taller* than the previous element.
     *
     * Example: [3, 1, 2]
     * 1. `previousHeight` starts at 0.
     * 2. `current = 3`: `3 > 0`. We need 3 new operations. `total = 3`. `previousHeight = 3`.
     * 3. `current = 1`: `1 > 3` is false. We don't need new operations;
     * the 3 operations from before already cover this bar. `previousHeight = 1`.
     * 4. `current = 2`: `2 > 1` is true. We need 1 new operation (2 - 1). `total = 4`. `previousHeight = 2`.
     * Final: 4
     *
     * The user's original code had a confusing start:
     * `var cur = target.min() ?? 0`
     * `var count = cur`
     * This is a non-standard, though correct, way of implementing this.
     * The standard implementation (shown below) starts both at 0.
     */
    func minNumberOperations(_ target: [Int]) -> Int {
        
        // `previousHeight` tracks the height of the previous element.
        // We start at 0, representing the ground level before the first element.
        var previousHeight = 0
        
        // `totalOperations` accumulates the total number of operations.
        var totalOperations = 0

        // Iterate through each target height in the array.
        for currentHeight in target {
            
            // If the current bar is taller than the previous one,
            // we must add new operations to cover the difference.
            if currentHeight > previousHeight {
                // The number of *new* operations is the difference in height.
                totalOperations += (currentHeight - previousHeight)
            }

            // Update the previous height for the next iteration.
            previousHeight = currentHeight
        }

        return totalOperations
    }
}