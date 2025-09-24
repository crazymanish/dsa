// Time Complexity: O(D), where D is the absolute value of the denominator.
// - The algorithm simulates long division. The number of unique non-zero remainders when
//   dividing by D is at most D-1. Therefore, the loop for the fractional part runs
//   at most D times before a remainder becomes 0 or repeats.
//
// Space Complexity: O(D)
// - The `remainderMap` can store up to D-1 entries in the worst case.
// - The length of the output string can also grow to a length proportional to D.
class Solution {
    /**
     * Converts a fraction represented by a numerator and a denominator into a string.
     * If the fractional part is repeating, the repeating sequence is enclosed in parentheses.
     *
     * The strategy is to simulate long division. The key to detecting a repeating decimal
     * is to keep track of the remainders encountered during the division process. If we
     * see a remainder that has appeared before, we know that the sequence of digits in
     * the quotient will start to repeat from that point. A hash map is used to store
     * previously seen remainders and the position in the result string where they occurred.
     *
     * - Parameters:
     * - numerator: The numerator of the fraction.
     * - denominator: The denominator of the fraction.
     * - Returns: A string representation of the fraction.
     */
    func fractionToDecimal(_ numerator: Int, _ denominator: Int) -> String {
        // --- Handle Edge Cases and Sign ---
        
        if numerator == 0 {
            return "0"
        }
        
        var result = ""
        
        // Determine the sign of the result. Using XOR `!=` is a concise way to check if
        // one number is negative and the other is positive.
        if (numerator < 0) != (denominator < 0) {
            result.append("-")
        }
        
        // Use 64-bit integers and absolute values to prevent overflow and simplify calculations.
        var num = Int64(abs(numerator))
        let den = Int64(abs(denominator))
        
        // --- Calculate Integer Part ---
        
        result += String(num / den)
        var remainder = num % den
        
        // If there's no remainder, the result is a whole number.
        if remainder == 0 {
            return result
        }
        
        result.append(".")
        
        // --- Calculate Fractional Part and Detect Repetition ---
        
        // This map stores [remainder: position_in_string].
        var remainderMap = [Int64: Int]()
        
        while remainder != 0 {
            // Check if we've seen this remainder before.
            if let startPosition = remainderMap[remainder] {
                // If yes, a repeating cycle is found. Insert parentheses at the
                // position where this remainder was first seen.
                let startIndex = result.index(result.startIndex, offsetBy: startPosition)
                result.insert("(", at: startIndex)
                result.append(")")
                break
            }
            
            // If the remainder is new, store it and its current position in the result string.
            remainderMap[remainder] = result.count
            
            // Perform one step of long division.
            remainder *= 10
            result.append(String(remainder / den))
            remainder %= den
        }
        
        return result
    }
}