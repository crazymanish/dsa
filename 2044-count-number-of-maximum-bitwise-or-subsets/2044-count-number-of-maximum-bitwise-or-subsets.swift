/*
Time Complexity: `O(2^N)`
The algorithm uses backtracking to explore every possible subset. There are **2^N** subsets for an array of size **N**. For each subset, we perform a constant number of operations (a bitwise OR and a recursive call).

Space Complexity: `O(N)`
The space is determined by the maximum depth of the recursion stack, which is equal to the number of elements, **N**.
*/
class Solution {
    /// Counts the number of non-empty subsets of `nums` that have the maximum possible bitwise OR value.
    func countMaxOrSubsets(_ nums: [Int]) -> Int {
        // 1. Calculate the target OR value, which is the OR of the entire array.
        // Any subset's OR value cannot exceed this.
        let maxOR = nums.reduce(0, |)
        var count = 0

        /// Recursively explores subsets to find those matching the maxOR value.
        /// - Parameters:
        ///   - index: The current index in the `nums` array to consider.
        ///   - currentOR: The bitwise OR value of the subset built so far.
        func backtrack(index: Int, currentOR: Int) {
            // Base case: If we've considered all numbers.
            if index == nums.count {
                // If the OR of the completed subset matches the target, increment the count.
                if currentOR == maxOR {
                    count += 1
                }
                return
            }

            // --- Recursive Step: Two choices for each number ---

            // Choice 1: Exclude the current number `nums[index]`.
            // The `currentOR` value remains unchanged.
            backtrack(index: index + 1, currentOR: currentOR)
            
            // Choice 2: Include the current number `nums[index]`.
            // Update the `currentOR` by OR-ing it with the current number.
            backtrack(index: index + 1, currentOR: currentOR | nums[index])
        }
        
        // Start the backtracking process from the first element with an initial OR value of 0.
        // The problem asks for non-empty subsets. Our initial call `backtrack(index: 0, currentOR: 0)`
        // will eventually check the empty subset (where currentOR remains 0). If maxOR is 0, this
        // would incorrectly count the empty set. However, since the constraints state nums[i] >= 1,
        // maxOR can never be 0, so this edge case is naturally avoided.
        backtrack(index: 0, currentOR: 0)

        return count
    }
}