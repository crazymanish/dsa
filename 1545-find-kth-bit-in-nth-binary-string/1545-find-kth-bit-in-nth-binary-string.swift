class Solution {
    /**
     ------------------------------------------------------------------------
     Problem Summary:
        We define a binary string S_n recursively:
        
        S_1 = "0"
        S_n = S_(n-1) + "1" + reverse(invert(S_(n-1)))

        Given integers n and k, return the k-th bit (1-indexed) in S_n.

     Strategy:
        - Start from S_1 = [0].
        - Iteratively construct the string until its length >= k.
        - Each construction step:
              current = previous
                        + [1]
                        + reverse(previous) with each bit inverted.
        - Stop once we have enough length to access index (k - 1).

        Note:
        We only build until the length reaches k, not necessarily full S_n.

     Time Complexity:
        O(L), where L is the constructed string length.
        In worst case L ≈ 2^n.

     Space Complexity:
        O(L), storing the constructed sequence.
     ------------------------------------------------------------------------
     */

    func findKthBit(_ n: Int, _ k: Int) -> Character {
        // Start with S_1
        var sequence = [0]

        // Build until we can access the k-th element
        while sequence.count < k {
            // Invert and reverse current sequence
            let reversedInverted = sequence
                .reversed()
                .map { $0 ^ 1 }

            // Append middle 1 and transformed suffix
            sequence += [1] + reversedInverted
        }

        // Convert 0/1 integer to corresponding character
        return sequence[k - 1] == 0 ? "0" : "1"
    }
}