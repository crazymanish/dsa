class Solution {
    func countGoodNumbers(_ n: Int) -> Int {
        let modulo = 1_000_000_007 // Modulo value to prevent integer overflow

        // Nested helper function to calculate (base^exponent) % modulo efficiently
        func modularExponentiation(_ base: Int, _ exponent: Int) -> Int {
            var result = 1 // Initialize the result to 1
            var base = base % modulo // Reduce the base modulo modulo
            var exponent = exponent // Use a mutable copy of the exponent

            while exponent > 0 { // Iterate while the exponent is greater than 0
                if exponent % 2 == 1 { // If the exponent is odd
                    result = (result * base) % modulo // Multiply the result by the base (modulo modulo)
                }
                base = (base * base) % modulo // Square the base (modulo modulo)
                exponent /= 2 // Divide the exponent by 2
            }

            return result // Return the final result as an Int
        }

        let evenPositions = (n + 1) / 2 // Number of even-indexed positions
        let oddPositions = n / 2 // Number of odd-indexed positions

        let evenChoices = modularExponentiation(5, evenPositions) // Number of choices for even positions (0, 2, 4, 6)
        let oddChoices = modularExponentiation(4, oddPositions) // Number of choices for odd positions (2, 3, 5, 7)

        return (evenChoices * oddChoices) % modulo // Total number of good numbers (modulo modulo)
    }
}