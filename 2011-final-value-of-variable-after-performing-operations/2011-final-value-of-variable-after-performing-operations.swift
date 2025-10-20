// https://leetcode.com/problems/final-value-of-variable-after-performing-operations

// Time Complexity: O(N)
// The algorithm iterates through the `operations` array once.
// N is the number of elements in the `operations` array.
// Inside the loop, the `contains` check is O(1) because the strings are
// of a fixed, small length (3). All other operations are constant time.
// Thus, the total time is directly proportional to N.

// Space Complexity: O(1)
// The algorithm uses a single integer variable (`value`) to store the running total.
// The space required does not change, regardless of the size of the input array.
// Therefore, it uses constant extra space.

class Solution {
    /// Calculates the final value of a variable after performing a series of operations.
    /// The variable, "X", starts at 0.
    ///
    /// - Parameter operations: An array of strings, where each string is one of:
    ///   "++X", "X++", "--X", or "X--".
    /// - Returns: The final integer value of "X" after all operations.
    func finalValueAfterOperations(_ operations: [String]) -> Int {
        
        // 'value' will hold the changing value of "X". It starts at 0.
        var value = 0
        
        // Iterate directly through each operation string in the array.
        for operation in operations {
            
            // The problem guarantees that each operation will be one of the four
            // specific strings. We can simply check if the string contains a "+"
            // to identify an increment operation.
            if operation.contains("+") {
                // This is "++X" or "X++", so increment the value.
                value += 1
            } else {
                // Otherwise, it must be "--X" or "X--", so decrement the value.
                value -= 1
            }
        }
        
        // Return the final accumulated value.
        return value
    }
}