// Time Complexity: O(N * log N)
//   - N: The value of the input integer `n`.
//   - The algorithm iterates from `firstNumber = 1` up to `n`. In the worst case, the loop runs O(N) times.
//   - Inside the loop, the dominant operation is checking if the numbers contain a zero. This is
//     done by converting the numbers to strings, which takes time proportional to the
//     number of digits, i.e., O(log10(N)).
//   - Therefore, the total time complexity is the number of iterations multiplied by the
//     work per iteration: O(N * log N).
//
// Space Complexity: O(log N)
//   - The space required is for storing the string representations of the numbers being
//     checked. The length of these strings is proportional to the number of digits, O(log N).
class Solution {
    
    /**
     * Checks if a positive integer contains the digit '0' in its decimal representation.
     *
     * - Parameter value: The integer to check.
     * - Returns: `true` if the number contains a '0', `false` otherwise.
     */
    private func containsZero(_ value: Int) -> Bool {
        return String(value).contains("0")
    }
    
    /**
     * Finds two positive integers, A and B, that do not contain the digit '0' and sum up to `n`.
     *
     * The strategy is a simple brute-force search. We can iterate through all possible
     * values for the first integer, `firstNumber`, starting from 1. For each `firstNumber`, we
     * calculate the corresponding second integer, `secondNumber = n - firstNumber`. We then check
     * if both `firstNumber` and `secondNumber` are "No-Zero integers". Since the problem guarantees
     * a solution exists, the first pair that satisfies this condition is a valid answer.
     *
     * - Parameter n: The target integer sum.
     * - Returns: An array containing two No-Zero integers `[firstNumber, secondNumber]`
     * such that their sum is `n`.
     */
    func getNoZeroIntegers(_ n: Int) -> [Int] {
        // Iterate through possible values for the first number.
        // The loop can stop before `n` because the second number must also be positive.
        for firstNumber in 1..<n {
            // Calculate the corresponding second number that sums up to `n`.
            let secondNumber = n - firstNumber
            
            // Check if both the current `firstNumber` and `secondNumber` meet the "No-Zero" criteria.
            if !containsZero(firstNumber) && !containsZero(secondNumber) {
                // If we find a valid pair, we can return it immediately as the problem
                // asks for any valid solution.
                return [firstNumber, secondNumber]
            }
        }
        
        // This line is technically unreachable given the problem's guarantee that a solution always exists.
        // It's included to satisfy the compiler's requirement for a return value on all code paths.
        fatalError("A solution is guaranteed by the problem constraints but was not found.")
    }
}