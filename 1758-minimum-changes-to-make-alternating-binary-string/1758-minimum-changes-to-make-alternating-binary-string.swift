class Solution {
    /**
     ------------------------------------------------------------------------
     Problem Summary:
     Given a binary string `s`, determine the minimum number of operations
     required to make the string alternating.

     An alternating string means no two adjacent characters are the same:
     Examples: "0101", "1010".

     In one operation, you can flip any character ('0' → '1' or '1' → '0').

     ------------------------------------------------------------------------
     Strategy:
     There are only two valid alternating patterns for a binary string:

       1. Pattern A: "010101..."
       2. Pattern B: "101010..."

     For each position in the string:
     - Compare the current character with what it *should be* in each pattern.
     - Count mismatches for both patterns.

     The minimum flips required is the smaller mismatch count.

     Key observation:
     - For Pattern A, even indices should be '0' and odd indices should be '1'.
     - For Pattern B, even indices should be '1' and odd indices should be '0'.

     The provided implementation cleverly counts mismatches for both
     patterns in a single pass.

     ------------------------------------------------------------------------
     Time Complexity:
     O(n)
     We scan the string once.

     Space Complexity:
     O(1)
     Only a few counters are used.
     ------------------------------------------------------------------------
     */

    func minOperations(_ s: String) -> Int {
        // Number of flips required to match pattern "010101..."
        var flipsForPatternStartingWithZero = 0

        // Number of flips required to match pattern "101010..."
        var flipsForPatternStartingWithOne = 0

        for (index, character) in s.enumerated() {

            // Convert character to expected parity value:
            // '0' → 0
            // '1' → 1
            let bitValue = (character == "1") ? 1 : 0

            // Check if current position matches expected parity
            if index % 2 == bitValue {
                // Mismatch for pattern starting with '0'
                flipsForPatternStartingWithZero += 1
            } else {
                // Mismatch for pattern starting with '1'
                flipsForPatternStartingWithOne += 1
            }
        }

        // Minimum operations between the two possible patterns
        return min(flipsForPatternStartingWithZero, flipsForPatternStartingWithOne)
    }
}