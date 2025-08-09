// Time Complexity: O(log n)
// In the worst case, the function will recursively divide n by 2 until it reaches 1.
// The number of divisions is the base-2 logarithm of n.
//
// Space Complexity: O(log n)
// Each recursive call adds a new frame to the call stack. The maximum depth of the
// stack will be proportional to the number of recursive calls, which is O(log n).
class Solution {
    /**
     * Checks if an integer is a power of two using recursion.
     *
     * - Parameter n: The integer to check.
     * - Returns: `true` if n is a power of two, otherwise `false`.
     */
    func isPowerOfTwo(_ n: Int) -> Bool {
        // Base Case 1: Powers of two must be positive.
        // Any non-positive number cannot be a power of two.
        if n <= 0 { return false }
        
        // Base Case 2: The successful end of the recursion.
        // If we have divided n by 2 enough times to get to 1,
        // the original number was a power of two (e.g., 2^0 = 1).
        if n == 1 { return true }
        
        // Base Case 3: A failing condition.
        // If n is odd at any point (and not 1), it can't be a power of two,
        // as it has prime factors other than 2.
        if n % 2 != 0 { return false }
        
        // Recursive Step: If the number is positive and even,
        // continue the check with half of its value.
        return isPowerOfTwo(n / 2)
    }
}