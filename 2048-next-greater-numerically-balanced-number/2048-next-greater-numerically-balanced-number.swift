// Time Complexity: O(G * log R)
// Let G be the gap between `n` and the next beautiful number (the result).
// Let R be the magnitude of the resulting beautiful number.
// 1. The main `while` loop runs G times (i.e., `result - n` times).
// 2. Inside the loop, `isDigitCountBalanced` is called.
// 3. `isDigitCountBalanced(num)`:
//    - Let `d` be the number of digits in `num`, so `d = O(log num)`.
//    - The inner `while` loop runs `d` times to populate the dictionary.
//    - The `for` loop iterates over the dictionary, which can have at most 10
//      keys (for digits 0-9). This is an O(1) operation (at most 10 checks).
//    - Therefore, the helper function's complexity is O(d) or O(log num).
// 4. The total time is the number of checks multiplied by the cost of each check:
//    O(G * log R).
//
// Space Complexity: O(1)
// 1. The `isDigitCountBalanced` function uses a dictionary `digitCounts`.
// 2. This dictionary will store at most 10 key-value pairs (for digits 0-9).
//    Its size is constant and does not depend on the size of the input number.
// 3. The main function only uses a few integer variables.
// 4. Therefore, the extra space required is constant, O(1).

class Solution {
    /// Finds the smallest "beautiful" number strictly greater than `n`.
    /// A "beautiful" number is one where for every digit `d` in the number,
    /// the digit `d` appears exactly `d` times.
    /// Note: The digit 0 cannot be part of a beautiful number because
    /// it would have to appear 0 times, which is a contradiction.
    func nextBeautifulNumber(_ n: Int) -> Int {
        
        // Start checking from the number right after n.
        var currentNum = n + 1
        
        // Keep incrementing and checking until we find a beautiful number.
        while !isDigitCountBalanced(currentNum) {
            currentNum += 1
        }

        // `currentNum` is now the smallest beautiful number > n.
        return currentNum
    }
    
    /// Helper function to check if a number is "beautiful".
    /// - Returns: `true` if the count of each digit `d` in the number
    ///   is exactly equal to `d`.
    private func isDigitCountBalanced(_ num: Int) -> Bool {
        var numCopy = num
        // Use a dictionary to store the frequency of each digit.
        var digitCounts = [Int: Int]()

        // Deconstruct the number and count its digits.
        while numCopy > 0 {
            let digit = numCopy % 10
            digitCounts[digit, default: 0] += 1
            numCopy /= 10
        }

        // Validate the counts against the digits themselves.
        for (digit, count) in digitCounts {
            // A beautiful number cannot contain 0 (it would need to appear 0 times).
            // For any other digit, its value must match its count.
            if digit == 0 || digit != count {
                return false
            }
        }

        // If all checks pass, the number is beautiful.
        return true
    }
}