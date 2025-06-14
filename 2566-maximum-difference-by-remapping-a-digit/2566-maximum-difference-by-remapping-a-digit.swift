// Time Complexity: O(log10(n))
// The complexity is proportional to the number of digits in the input `num`.
// Converting a number to a string, iterating through its digits, and converting
// it back are all operations that scale linearly with the number of digits.

// Space Complexity: O(log10(n))
// We store the digits of the number in an array of characters, which requires
// space proportional to the number of digits.

class Solution {
    /**
     * Calculates the difference between two new numbers derived from the input `num`.
     * - `maxNum` is formed by replacing the first non-'9' digit with '9'.
     * - `minNum` is formed by replacing the first digit with '0'.
     *
     * - Parameter num: The input integer.
     * - Returns: The difference between the maximized and minimized numbers.
     */
    func minMaxDifference(_ num: Int) -> Int {
        // Converting the number to an array of characters is a clearer way to work with its digits.
        let digits = Array(String(num))
        
        // --- Determine which digits to change ---

        // To maximize the number, we find the first digit from the left that is not '9'
        // and replace all its occurrences with '9'. If all digits are '9', we just replace '9'
        // with '9' (i.e., no change), so we default to the first digit.
        let digitToMakeNine = digits.first { $0 != "9" } ?? digits[0]

        // To minimize the number, we replace all occurrences of the most significant
        // (i.e., the first) digit with '0'.
        let digitToMakeZero = digits[0]
        
        // --- Build the minimized and maximized numbers ---
        
        // Use `map` to create the character arrays for the new numbers.
        let minNumberDigits = digits.map { $0 == digitToMakeZero ? "0" : $0 }
        let maxNumberDigits = digits.map { $0 == digitToMakeNine ? "9" : $0 }

        // Convert the character arrays back to strings, then to integers.
        // The `!` is safe because the source is a number, so the resulting string will be a valid integer.
        let minimizedNumber = Int(String(minNumberDigits))!
        let maximizedNumber = Int(String(maxNumberDigits))!
        
        return maximizedNumber - minimizedNumber
    }
}