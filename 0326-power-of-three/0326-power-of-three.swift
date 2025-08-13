// Time Complexity: O(log3(n))
// In the worst case, the function recursively divides n by 3 until it reaches 1.
// The number of divisions is the base-3 logarithm of n.
//
// Space Complexity: O(log3(n))
// Each recursive call adds a new frame to the call stack. The maximum depth of the
// stack will be proportional to the number of recursive calls, which is O(log3(n)).
class Solution {
    /**
     * Checks if an integer is a power of three using recursion.
     *
     * - Parameter n: The integer to check.
     * - Returns: `true` if n is a power of three, otherwise `false`.
     */
    func isPowerOfThree(_ n: Int) -> Bool {
        // Base Case 1: A power of three must be a positive number.
        if n <= 0 { return false }
        
        // Base Case 2: The successful end of the recursion. If we have
        // divided n by 3 enough times to get to 1, it was a power of three.
        if n == 1 { return true }
        
        // Base Case 3: A failing condition. If n is not divisible by 3 (and is not 1),
        // it cannot be a power of three, as it has prime factors other than 3.
        if n % 3 != 0 { return false }
        
        // Recursive Step: If n is positive and divisible by 3,
        // continue the check with its value divided by 3.
        return isPowerOfThree(n / 3)
    }
}