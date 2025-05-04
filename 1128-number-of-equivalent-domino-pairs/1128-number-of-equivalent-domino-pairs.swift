class Solution {
    /**
     * Counts the number of equivalent domino pairs in a given list of dominoes.
     * Two dominoes `dominoes[i] = [a, b]` and `dominoes[j] = [c, d]` are equivalent
     * if either `(a == c and b == d)` or `(a == d and b == c)`. In other words,
     * one domino can be rotated to match the other.
     *
     * - Parameter dominoes: An array of dominoes, where each domino is represented as `[Int]`.
     * It's assumed each inner array has exactly two elements, and values are between 1 and 9 (inclusive).
     * - Returns: The total number of equivalent domino pairs (i, j) such that i < j.
     *
     * - Time Complexity: O(N), where N is the number of dominoes in the input array.
     * - We iterate through the `dominoes` array once.
     * - Inside the loop, calculating the hash and dictionary operations (lookup, update)
     * take average O(1) time.
     * - Overall: O(N).
     *
     * - Space Complexity: O(N) in the worst case, or more precisely O(M), where M is the
     * number of *unique* canonical domino representations.
     * - The `dominoFrequencies` dictionary stores the frequency of each unique canonical domino form.
     * In the worst case, all dominoes could be unique (after canonicalization), leading to O(N) space.
     * If there are many duplicates, the space used will be less than O(N).
     * The number of possible unique canonical dominoes is limited (e.g., 9*9 = 81, or less if considering min/max pairs),
     * so it could also be considered O(1) if viewed relative to the *possible* domino types rather than the input size N.
     * However, O(N) is the safer upper bound related to input size.
     */
    func numEquivDominoPairs(_ dominoes: [[Int]]) -> Int {
        // Dictionary to store the frequency of each canonical domino representation.
        // Key: An integer hash representing the canonical form (min_val * 10 + max_val).
        // Value: The count of how many times this canonical form has been seen.
        var dominoFrequencies: [Int: Int] = [:]
        // Accumulator for the total count of equivalent pairs found.
        var equivalentPairCount = 0

        // Iterate through each domino in the input list.
        for domino in dominoes {
            // Extract the two values from the current domino.
            // Assuming domino always has 2 elements based on problem constraints.
            let val1 = domino[0]
            let val2 = domino[1]

            // Create a canonical representation (hash) for the domino.
            // This ensures that [a, b] and [b, a] map to the same key.
            // We use min * 10 + max. Since values are 1-9, min is 1-9 and max is 1-9.
            // The smallest hash is 1*10 + 1 = 11, largest is 9*10 + 9 = 99.
            // This guarantees a unique hash for each equivalent pair type.
            let canonicalHash = min(val1, val2) * 10 + max(val1, val2)

            // Before incrementing the count for the current domino's hash,
            // check how many times we've already seen this canonical form.
            // Each previous instance forms a new pair with the current domino.
            // Example: If we've seen hash '12' twice before (freq=2), and we see it again,
            // this new domino forms 2 new pairs.
            let countForThisHash = dominoFrequencies[canonicalHash, default: 0]
            equivalentPairCount += countForThisHash

            // Increment the frequency count for this canonical domino form.
            dominoFrequencies[canonicalHash, default: 0] += 1
        }

        // Return the total accumulated count of equivalent pairs.
        return equivalentPairCount
    }
}
