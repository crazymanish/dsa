// Time Complexity: O(log N)
// The loop iterates by building a number `currentPowerOfTwoMinusOne` that
// grows exponentially (1, 3, 7, 15, ...).
// The number of iterations is proportional to the number of bits in `n`,
// which is O(log N). Each operation inside the loop is O(1).
// Therefore, the total time complexity is O(log N).

// Space Complexity: O(1)
// The algorithm uses only a few constant-size integer variables.
// The space required does not change with the size of the input `n`.

class Solution {
    /// Finds the smallest number that is greater than or equal to `n`
    /// and consists of all set bits in its binary representation
    /// (i.e., a number of the form 2^k - 1, like 1, 3, 7, 15, ...).
    ///
    /// - Parameter n: The target number to exceed.
    /// - Returns: The smallest "all-ones" number >= n.
    func smallestNumber(_ n: Int) -> Int {
        
        // This variable will be built up to be the smallest number
        // of the form 2^k - 1 that is >= n.
        // We start at 0, which is 2^0 - 1 (conceptually).
        var currentPowerOfTwoMinusOne = 0
        
        // Loop as long as our "all-ones" number is smaller than n.
        while currentPowerOfTwoMinusOne < n {
            
            // This operation builds the next "all-ones" number.
            // (num << 1) is a left shift, equivalent to (num * 2).
            // (num << 1) + 1 appends a '1' to the binary representation.
            //
            // Example trace:
            // 0 -> (0*2) + 1 = 1   (binary "1")
            // 1 -> (1*2) + 1 = 3   (binary "11")
            // 3 -> (3*2) + 1 = 7   (binary "111")
            // 7 -> (7*2) + 1 = 15  (binary "1111")
            currentPowerOfTwoMinusOne = (currentPowerOfTwoMinusOne << 1) + 1
        }
        
        // Once the loop terminates, `currentPowerOfTwoMinusOne` is the
        // first "all-ones" number that is >= n.
        return currentPowerOfTwoMinusOne
    }
}