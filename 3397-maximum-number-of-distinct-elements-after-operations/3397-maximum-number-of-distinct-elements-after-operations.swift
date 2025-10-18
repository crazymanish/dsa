class Solution {
    /**
     * Calculates the maximum number of distinct elements achievable by modifying an array.
     *
     * Problem: Given an array `nums` and an integer `k`, you can change any element `x`
     * to a new integer in the inclusive range `[x, x + 2k]`. The goal is to
     * find the maximum number of distinct elements you can have in the array after
     * performing these operations.
     *
     * Algorithm (Greedy):
     * 1. Sort the array `nums`. This allows us to process elements in increasing order.
     * 2. Iterate through the sorted array, greedily assigning the smallest possible
     * new value to each number to make it distinct from the previously assigned value.
     * 3. This is done using `reductions` (a "scan" operation) which builds an array of
     * these new `assignedValues`.
     * 4. For each `currentNum`, we compare it to the `previousAssignedValue`:
     * - The new value must be at least `currentNum`.
     * - The new value must be at least `previousAssignedValue + 1` (to be distinct).
     * - Therefore, the smallest target value is `max(currentNum, previousAssignedValue + 1)`.
     * - This target value is capped by the upper bound of the allowed range: `currentNum + 2k`.
     * - So, the `newAssignedValue` we pick is: `min(max(currentNum, previousAssignedValue + 1), currentNum + 2k)`.
     * 5. The `reductions` closure implements this exact logic in a slightly different (but equivalent) branching form.
     * 6. Finally, we count the number of distinct elements in the resulting `assignedValues` array.
     */
    func maxDistinctElements(_ nums: [Int], _ k: Int) -> Int {
        
        // This function chain implements the greedy algorithm described above.
        
        // Step 1: Sort the array to process elements in increasing order.
        let sortedNums = nums.sorted()
        
        // Step 2: Use `reductions` (a "scan" operation) to build an array of new assigned values.
        // It iterates through the sorted numbers, keeping track of the *previous assigned value*
        // and calculating the *new assigned value* for the current number.
        let assignedValues = sortedNums.reductions { previousAssignedValue, currentNum in
            // `previousAssignedValue` is the result of the last iteration ($0).
            // `currentNum` is the next element from `sortedNums` ($1).
            
            if previousAssignedValue < currentNum {
                // Case 1: The current number is already larger than the previous assigned value.
                // We can greedily assign `currentNum` itself. It is:
                // 1. Distinct (since `currentNum > previousAssignedValue`).
                // 2. The smallest valid value in its allowed range `[currentNum, currentNum + 2k]`.
                return currentNum
            } else {
                // Case 2: `previousAssignedValue >= currentNum`.
                // We must pick a new value that is at least `previousAssignedValue + 1`
                // to guarantee it's distinct.
                let targetDistinctValue = previousAssignedValue + 1
                
                // This new value is also capped by the allowed upper bound from the original number.
                let maxAllowedValue = currentNum + 2 * k
                
                // We take the `min` of our target and the allowed max.
                // If `targetDistinctValue > maxAllowedValue`, it means we *cannot*
                // make this element distinct (e.g., k=0, nums=[1, 1]). In this case,
                // we are forced to pick `maxAllowedValue`, which will be a duplicate.
                let newAssignedValue = min(targetDistinctValue, maxAllowedValue)
                return newAssignedValue
            }
        }
        
        // Step 3: Count the distinct elements in our new `assignedValues` array.
        // Since `assignedValues` is non-decreasing, `chunked(by: ==)` groups
        // all identical values together. The count of chunks is the distinct count.
        let distinctElementCount = assignedValues
            .chunked(by: ==)
            .count
            
        return distinctElementCount
    }
}