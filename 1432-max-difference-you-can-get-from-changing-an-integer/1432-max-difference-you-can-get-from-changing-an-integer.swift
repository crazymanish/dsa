// Time Complexity: O(log10(n))
// The complexity is determined by the number of digits in the input `num`.
// All operations (string conversion, finding characters, replacing occurrences)
// are linear with respect to the number of digits.

// Space Complexity: O(log10(n))
// Space is used to store the string representations of the number and its
// variations. This is also proportional to the number of digits.
class Solution {
    /**
     * Calculates the maximum possible difference between two numbers, 'a' and 'b', that can be
     * formed by applying a single digit-to-digit mapping on the original number `num`.
     *
     * - Parameter num: The starting integer.
     * - Returns: The maximum difference `a - b`.
     */
    func maxDiff(_ num: Int) -> Int {
        let numberAsString = String(num)

        // --- Step 1: Calculate the maximized number 'a' ---
        
        // To maximize the number, we should replace a digit with '9'.
        // To get the biggest increase, we find the first digit from the left that is NOT '9'
        // and replace all its occurrences with '9'.
        // If all digits are '9', we can default to replacing '9' with '9' (no change).
        let digitToMakeNine = numberAsString.first { $0 != "9" } ?? "9"
        let maximizedNumberString = numberAsString.replacingOccurrences(of: String(digitToMakeNine), with: "9")
        let maximizedNumber = Int(maximizedNumberString)!

        // --- Step 2: Calculate the minimized number 'b' ---

        let leadingDigit = numberAsString.first!
        let minimizedNumber: Int

        // The strategy for minimization depends on the leading digit.
        if leadingDigit == "1" {
            // Case 1: The number starts with '1'.
            // We cannot change the leading '1' to '0' (e.g., 123 -> 023 is invalid).
            // So, we must find the next best digit to change to '0'. This would be the
            // first digit that is not '0' or '1'.
            // If no such digit exists (e.g., in "1010"), we default to changing '0' to '0' (no change).
            let digitToMakeZero = numberAsString.first { $0 != "0" && $0 != "1" } ?? "0"
            let minimizedNumberString = numberAsString.replacingOccurrences(of: String(digitToMakeZero), with: "0")
            minimizedNumber = Int(minimizedNumberString)!
        } else {
            // Case 2: The number does not start with '1'.
            // To minimize, we should change the most significant digit to the smallest possible
            // value for a leading digit, which is '1'.
            let minimizedNumberString = numberAsString.replacingOccurrences(of: String(leadingDigit), with: "1")
            minimizedNumber = Int(minimizedNumberString)!
        }

        // --- Step 3: Return the final difference ---
        return maximizedNumber - minimizedNumber
    }
}