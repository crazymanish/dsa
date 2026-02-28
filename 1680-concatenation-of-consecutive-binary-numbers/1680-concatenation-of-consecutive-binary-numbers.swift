class Solution {
    /**
     -----------------------------------------------------------------------
     Problem Summary:
        Given an integer `n`, construct a binary string formed by
        concatenating the binary representations of integers from 1 to n.
        Return the decimal value of that binary string modulo 1_000_000_007.

        Example:
            n = 3
            Binary sequence = "1" + "10" + "11" = "11011"
            Result = 27

     Strategy:
        Instead of physically constructing the full binary string,
        we simulate binary concatenation mathematically.

        Observations:
        - Appending a binary number is equivalent to:
              result = (result << bitLength) + number
        - The bit length of a number increases whenever we reach
          a power of 2 (1, 2, 4, 8, ...).

        So for each number from 1 to n:
            1) If the number is a power of two → increment bitLength
            2) Left shift result by bitLength
            3) Add current number
            4) Apply modulo

        This avoids:
        - Storing large intermediate binary arrays
        - Repeated array insertions (which are O(n))

     Time Complexity:
        O(n)
        We iterate once from 1 to n.

     Space Complexity:
        O(1)
        Only a few integer variables are used.
     -----------------------------------------------------------------------
     */

    func concatenatedBinary(_ n: Int) -> Int {
        let modulo = 1_000_000_007

        var result = 0
        var currentBitLength = 0

        for number in 1...n {
            // If number is a power of 2, its bit length increases
            // Power of two check: x & (x - 1) == 0
            if (number & (number - 1)) == 0 {
                currentBitLength += 1
            }

            // Shift result left to make space for current number
            result = ((result << currentBitLength) % modulo + number) % modulo
        }

        return result
    }
}