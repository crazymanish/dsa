/*
Time Complexity: O(max(num1, num2) / min(num1, num2))
- In each iteration, we subtract the smaller number from the larger one.
- In the worst case, when the numbers are close in value (like 100000 and 99999),
  this becomes O(num1 / num2) iterations, roughly linear in the ratio of the two numbers.
- However, in practice (especially when numbers differ significantly), 
  it performs fewer iterations and is much faster.

Space Complexity: O(1)
- We use only a few integer variables (num1, num2, result) — constant extra space.
*/

class Solution {
    func countOperations(_ num1: Int, _ num2: Int) -> Int {
        // Create mutable copies since Swift function parameters are immutable by default
        var num1 = num1
        var num2 = num2
        var result = 0 // Counter for the total number of operations
        
        // Continue until one of the numbers becomes zero
        while num1 != 0 && num2 != 0 {
            if num1 > num2 {
                // Subtract the smaller number (num2) from the larger (num1)
                num1 = num1 - num2
            } else {
                // Subtract num1 from num2 otherwise
                num2 = num2 - num1
            }
            result += 1 // Increment the operation count after each subtraction
        }
        
        // Return the total count of operations performed
        return result
    }
}
