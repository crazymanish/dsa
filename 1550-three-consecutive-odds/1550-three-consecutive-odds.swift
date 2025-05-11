class Solution {
    /**
     * Checks if there are three consecutive odd numbers in the given array.
     *
     * The function iterates through the array, maintaining a count of consecutive
     * odd numbers encountered. If an even number is found, the count is reset.
     * If the count reaches 3 at any point, the function immediately determines
     * that three consecutive odds exist.
     *
     * - Parameter arr: An array of integers to check.
     * - Returns: `true` if the array contains three consecutive odd numbers, `false` otherwise.
     *
     * - Time Complexity: O(N), where N is the number of elements in the array `arr`.
     * In the worst case, the function iterates through all elements of the array once.
     * In the best case (e.g., the first three numbers are odd), it might terminate early.
     *
     * - Space Complexity: O(1).
     * The function uses a constant amount of extra space for variables like `consecutiveOddCount`.
     */
    func threeConsecutiveOdds(_ arr: [Int]) -> Bool {
        // Counter for consecutive odd numbers.
        var consecutiveOddCount = 0
        
        // Iterate through each number in the input array.
        for num in arr {
            // Check if the current number is odd.
            if num % 2 != 0 { // num is odd
                consecutiveOddCount += 1 // Increment the count of consecutive odd numbers.
                
                // If we have found three consecutive odd numbers, we can stop early.
                if consecutiveOddCount == 3 {
                    return true // Found three consecutive odds.
                }
            } else { // num is even
                // If an even number is encountered, reset the count of consecutive odds.
                consecutiveOddCount = 0
            }
        }
        
        // If the loop completes and we haven't returned true,
        // it means three consecutive odds were not found.
        // The final check `consecutiveOddCount == 3` is implicitly handled by the early return.
        // If the loop finishes, it means `consecutiveOddCount` never stayed at 3 or never reached 3.
        return false
    }
}
