/**
 Problem Summary
 ----------------
 Given a non-negative integer `num`, return its bitwise complement.
 The complement flips every bit in the binary representation of `num`
 (0 becomes 1, and 1 becomes 0).

 Example:
 num = 5
 Binary representation = 101
 Complement = 010
 Result = 2

 Strategy
 --------
 1. Convert the integer to its binary string representation.
 2. Traverse each character of the binary string.
 3. Flip each bit:
    - '0' becomes '1'
    - '1' becomes '0'
 4. Build a new binary string containing the flipped bits.
 5. Convert the resulting binary string back to an integer.

 This approach works because the problem only requires flipping the bits
 that appear in the binary representation of `num`, not infinite leading zeros.

 Time Complexity
 ---------------
 O(b)
 where `b` is the number of bits in `num` (≈ log₂(num)).

 Space Complexity
 ----------------
 O(b)
 for storing the flipped binary string.
 */

class Solution {
    func bitwiseComplement(_ num: Int) -> Int {
        // Convert the number to its binary representation
        let binaryRepresentation = String(num, radix: 2)
        
        // Store the flipped bits
        var flippedBinary = ""
        
        // Flip each bit in the binary representation
        for bit in binaryRepresentation {
            flippedBinary += (bit == "0") ? "1" : "0"
        }
        
        // Convert the flipped binary string back to an integer
        return Int(flippedBinary, radix: 2) ?? 0
    }
}