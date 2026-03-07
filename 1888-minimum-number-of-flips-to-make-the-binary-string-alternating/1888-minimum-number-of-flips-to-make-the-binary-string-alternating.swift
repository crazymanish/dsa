class Solution {
    /**
     -----------------------------------------------------------------------
     Problem Summary:
       Given a binary string `s`, you may rotate the string any number of times.
       After choosing a rotation, determine the minimum number of flips needed
       to convert the string into an alternating binary string.

       Valid alternating patterns:
         • "010101..."
         • "101010..."

       A flip changes '0' → '1' or '1' → '0'.

     Strategy:
       Rotations can be simulated by concatenating the string with itself
       (`s + s`). A sliding window of size `n` represents every possible rotation.

       While traversing the doubled string:
         • Maintain mismatch counts against two patterns:
             pattern01 = "010101..."
             pattern10 = "101010..."

         • When the window exceeds size `n`, remove the contribution
           of the leftmost character.

         • At every window of size `n`, compute the minimum flips required.

     Key Insight:
       Instead of storing prefix sums, we update mismatch counts dynamically
       when characters enter and leave the window.

     Time Complexity:
       O(n)
       We traverse the doubled string once.

     Space Complexity:
       O(1)
       Only counters are maintained.
     -----------------------------------------------------------------------
     */
    func minFlips(_ s: String) -> Int {
        let n = s.count
        let doubledCharacters = Array(s + s)

        var mismatchPattern01 = 0
        var mismatchPattern10 = 0

        var minimumFlips = Int.max
        var left = 0

        for right in 0..<doubledCharacters.count {
            // Expected characters for alternating patterns
            let expected01: Character = right % 2 == 0 ? "0" : "1"
            let expected10: Character = right % 2 == 0 ? "1" : "0"

            if doubledCharacters[right] != expected01 {
                mismatchPattern01 += 1
            }

            if doubledCharacters[right] != expected10 {
                mismatchPattern10 += 1
            }

            // Maintain window size ≤ n
            if right - left + 1 > n {
                let leftExpected01: Character = left % 2 == 0 ? "0" : "1"
                let leftExpected10: Character = left % 2 == 0 ? "1" : "0"

                if doubledCharacters[left] != leftExpected01 {
                    mismatchPattern01 -= 1
                }

                if doubledCharacters[left] != leftExpected10 {
                    mismatchPattern10 -= 1
                }

                left += 1
            }

            // When window size equals n, evaluate flips
            if right - left + 1 == n {
                minimumFlips = min(minimumFlips, mismatchPattern01, mismatchPattern10)
            }
        }

        return minimumFlips
    }
}