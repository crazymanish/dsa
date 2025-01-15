class Solution {
    func minimizeXor(_ num1: Int, _ num2: Int) -> Int {
        // Calculate how many bits we need to add (if positive) or remove (if negative)
        // to match the number of set bits in num2.
        var neededSetBits = num2.nonzeroBitCount - num1.nonzeroBitCount
        
        // If no adjustment is needed, just return num1 as is.
        if neededSetBits == 0 { return num1 }
        
        // We'll build our result by modifying num1's bits.
        var num = num1
        
        // Iterate through bits starting from the least significant bit (LSB)
        // and moving toward more significant bits by shifting a mask.
        for bit in sequence(first: 1, next: { $0 << 1 }) {
            
            // Check if num's current bit is 0 (unset).
            if num & bit == 0 {
                // If we need more set bits, flip this 0-bit to 1.
                if neededSetBits > 0 {
                    num |= bit         // Set the bit
                    neededSetBits -= 1
                    // If we've matched the required set bits, we're done.
                    if neededSetBits == 0 { break }
                }
                
            } else {
                // This branch means num's current bit is 1.
                // If we have too many set bits, flip this 1-bit to 0.
                if neededSetBits < 0 {
                    num ^= bit        // Unset the bit
                    neededSetBits += 1
                    // If we've matched the required set bits, we're done.
                    if neededSetBits == 0 { break }
                }
            }
        }
        
        // After adjusting bits, num has the same number of 1-bits as num2.
        return num
    }
}