// Time Complexity: O(N^2)
// Let N be the length of the input string `s`.
// 1. `compactMap` takes O(N) time to convert the string to an array of integers.
// 2. The `while` loop runs N - 2 times (e.g., N=5 -> 4 -> 3 -> 2; 3 iterations).
// 3. Inside the loop, `digitsSum` is called.
//    - The first call processes N digits and takes O(N) time.
//    - The second call processes N-1 digits and takes O(N-1) time.
//    - ...
//    - The last call processes 3 digits and takes O(3) time.
// 4. The total time for the loop is the sum O(N + (N-1) + ... + 3),
//    which is an arithmetic series that simplifies to O(N^2).
//
// Space Complexity: O(N)
// 1. `currentDigits` array is created with size N.
// 2. Inside the `digitsSum` function, a new array (`nextSequence`) is
//    created. Its size decreases on each iteration (N-1, N-2, ... 2).
// 3. The maximum space used at any time is proportional to the
//    initial string length N.

class Solution {
    /// Checks if the final two digits are the same after repeatedly applying
    /// a pairwise-sum-modulo-10 reduction to a string of digits.
    ///
    /// The process:
    /// 1. Start with a sequence of digits (e.g., "12345").
    /// 2. Create a new sequence by summing adjacent pairs % 10 (e.g., [3, 5, 7, 9]).
    /// 3. Repeat until only two digits remain (e.g., [8, 2, 6] -> [0, 8] -> [8]).
    ///    (Correction: [8, 2, 6] -> [0, 8]).
    /// 4. Check if the final two digits are equal.
    ///
    /// - Parameter s: A string containing only digits.
    /// - Returns: `true` if the final two digits are equal, `false` otherwise.
    func hasSameDigits(_ s: String) -> Bool {
        // Convert the string to an array of integers.
        var currentDigits = s.compactMap(\.wholeNumberValue)
        
        // Repeatedly reduce the digit sequence until only two digits remain.
        while currentDigits.count > 2 {
            // Replace the current sequence with the newly reduced sequence.
            currentDigits = getPairwiseSumSequence(currentDigits)
        }
        
        // After the loop, `currentDigits` will have exactly 2 elements.
        // Return `true` if they are the same.
        return currentDigits[0] == currentDigits[1]
    }
    
    /// Helper function to perform one reduction step.
    /// It creates a new array where each element is the sum (mod 10)
    /// of the adjacent elements from the input array.
    ///
    /// - Parameter digits: The current sequence of digits.
    /// - Returns: A new sequence that is one element shorter.
    private func getPairwiseSumSequence(_ digits: [Int]) -> [Int] {
        // This will store the new, shorter sequence.
        var nextSequence = [Int]()
        
        // Iterate through all adjacent pairs.
        // `i` goes from 0 up to the second-to-last index.
        for i in 0..<digits.count - 1 {
            // Calculate the sum of the pair.
            let sum = digits[i] + digits[i + 1]
            // Append the last digit (sum mod 10) to the new sequence.
            nextSequence.append(sum % 10)
        }
        
        return nextSequence
    }
}