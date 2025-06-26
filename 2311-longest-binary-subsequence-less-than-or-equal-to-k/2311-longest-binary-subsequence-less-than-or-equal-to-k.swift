// Time Complexity: O(n)
// The code iterates through the input string once from right to left.
// All operations inside the loop (character check, addition, bitwise shift) are O(1).
// 'n' is the length of the string `s`.

// Space Complexity: O(1)
// The algorithm uses a fixed number of variables to store the length and current value,
// regardless of the input string size.
class Solution {
    /**
     * Finds the length of the longest subsequence of `s` that forms a binary number
     * with a value less than or equal to `k`.
     *
     * - Parameters:
     * - s: A string representing a binary number.
     * - k: The target integer value to not exceed.
     * - Returns: The length of the longest valid subsequence.
     */
    func longestSubsequence(_ s: String, _ k: Int) -> Int {
        var subsequenceLength = 0
        var currentValue = 0
        
        // We greedily build the subsequence from right to left (least significant bit to most).
        // It's always optimal to include all '0's, as they increase the length without increasing the value.
        // We include '1's as long as they don't push the subsequence's value over `k`.
        for character in s.reversed() {
            if character == "0" {
                // Always include '0's. They contribute to length but not to value.
                subsequenceLength += 1
            } else { // character == '1'
                // The position of this '1' in the subsequence corresponds to 2^subsequenceLength.
                // For example, if length is 3, this '1' would be at the 4th spot (2^3 = 8).
                
                // Use bitwise left shift `1 << n` for `2^n`. It's faster and avoids floating-point math.
                // We must check if `subsequenceLength` is too large, as `1 << 63` can overflow `Int`.
                // A check like `subsequenceLength >= k.bitWidth` is a robust way to prevent this.
                if subsequenceLength >= 63 { 
                    // The value of this '1' would be too large to fit in an Int or would surely exceed k.
                    continue
                }
                
                let powerOfTwo = 1 << subsequenceLength
                
                // Check if adding this '1' (and its corresponding value) keeps the total value within `k`.
                // We also check that the addition itself won't overflow.
                if currentValue <= k - powerOfTwo {
                    currentValue += powerOfTwo
                    subsequenceLength += 1
                }
            }
        }
        
        return subsequenceLength
    }
}