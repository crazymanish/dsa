/*
Time Complexity: O(log n)
- We iterate once per bit of n (while mask ≤ n).
- Each iteration does constant work (bitwise operations, arithmetic, shift).
- Therefore, total time complexity is proportional to the number of bits in n → O(log n).

Space Complexity: O(1)
- We use only a fixed number of integer variables (answer, mask, and input n).
- No extra data structures are used.
*/

class Solution {
    func minimumOneBitOperations(_ n: Int) -> Int {
        var answer = 0       // Result variable to accumulate the number of operations
        var mask = 1         // Bit mask starting from the least significant bit (LSB)
        
        // Loop through each bit position while mask ≤ n
        while mask <= n {
            // If the current bit is set in n
            if n & mask != 0 {
                // Update answer using the transformation formula:
                // answer = (2 * mask - 1) - answer
                // This corresponds to flipping bits based on Gray code properties
                answer = (mask * 2 - 1) - answer
            }
            
            // Move to the next bit position (left shift by 1)
            mask <<= 1
        }
        
        // Return the total number of bit operations required to make n = 0
        return answer
    }
}
