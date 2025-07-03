// Time Complexity: O(numSegments * k)
// - Segmentation takes O(n), where n is the length of the word.
// - The main DP loop runs `numSegments` times.
// - Inside the loop, we iterate up to `k` twice (once for prefix sums, once for the new DP table).
// - Therefore, the dominant part is O(numSegments * k).

// Space Complexity: O(k)
// The space is dominated by the DP arrays (`dp`, `newDP`, `prefixSums`), each of size `k`.

class Solution {
    private let MOD = 1_000_000_007

    // MARK: - Main Logic
    
    /**
     * This function solves a complex counting problem, likely related to finding the number of ways
     * to construct a new string of length at least `k` by picking characters from consecutive
     * blocks of identical characters in the original `word`.
     *
     * The strategy uses the Principle of Inclusion-Exclusion:
     * Result = (Total possible combinations) - (Combinations with length < k)
     *
     * A Dynamic Programming approach with a prefix sum optimization is used to calculate
     * the number of combinations with length less than `k`.
     */
    func possibleStringCount(_ word: String, _ k: Int) -> Int {
        
        // --- Step 1: Segment the input string ---
        // Group consecutive identical characters and find their lengths.
        // e.g., "aaabbc" -> [3, 2, 1]
        let segmentLengths = findSegmentLengths(for: word)
        let numSegments = segmentLengths.count

        // --- Step 2: Calculate the total number of possible combinations ---
        // This is the product of all segment lengths, as we can pick any of the
        // characters from each segment independently.
        var totalCombinations = 1
        for length in segmentLengths {
            totalCombinations = modMul(totalCombinations, length)
        }

        // --- Step 3: Handle the simple case ---
        // The minimum possible length of a constructed string is `numSegments` (by taking 1 char from each segment).
        // If k is less than or equal to this minimum length, all combinations are valid.
        if k <= numSegments {
            return totalCombinations
        }

        // --- Step 4: DP to count combinations with length < k ---
        // `dp[j]` = number of ways to form a string of length `j`
        var dp = [Int](repeating: 0, count: k)
        dp[0] = 1 // Base case: one way to form a string of length 0 (by choosing nothing).

        // Iterate through each segment, updating the DP table.
        for segmentLength in segmentLengths {
            // Use a prefix sum array for optimization. `prefixSums[j]` = sum(dp[0]...dp[j-1]).
            var prefixSums = [Int](repeating: 0, count: k + 1)
            for j in 0..<k {
                prefixSums[j + 1] = modAdd(prefixSums[j], dp[j])
            }

            var nextDP = [Int](repeating: 0, count: k)
            // For each possible new length `j`...
            for j in 1..<k {
                // The new length `j` can be formed from a previous length `l` by adding `c` characters
                // from the current segment, where `1 <= c <= segmentLength`. So, `j = l + c`.
                // This means `l = j - c`, and `j - segmentLength <= l <= j - 1`.
                // The number of ways is the sum of `dp[l]` over this range.
                // We can calculate this sum efficiently using our prefix sums.
                let leftBound = max(0, j - segmentLength)
                nextDP[j] = modSub(prefixSums[j], prefixSums[leftBound])
            }
            dp = nextDP
        }

        // --- Step 5: Sum the invalid combinations and find the result ---
        var countOfStringsShorterThanK = 0
        for length in numSegments..<k {
             countOfStringsShorterThanK = modAdd(countOfStringsShorterThanK, dp[length])
        }

        return modSub(totalCombinations, countOfStringsShorterThanK)
    }

    // MARK: - Helpers

    /// Groups consecutive identical characters and returns an array of their counts.
    private func findSegmentLengths(for word: String) -> [Int] {
        guard !word.isEmpty else { return [] }
        
        let chars = Array(word)
        var segmentLengths = [1]
        
        for i in 1..<chars.count {
            if chars[i] == chars[i - 1] {
                segmentLengths[segmentLengths.count - 1] += 1
            } else {
                segmentLengths.append(1)
            }
        }
        return segmentLengths
    }
    
    // MARK: - Modular Arithmetic

    @inline(__always)
    private func modMul(_ a: Int, _ b: Int) -> Int {
        // Use Int64 to prevent overflow before the modulo operation.
        return Int((Int64(a) * Int64(b)) % Int64(MOD))
    }

    @inline(__always)
    private func modAdd(_ a: Int, _ b: Int) -> Int {
        let sum = a + b
        return sum >= MOD ? sum - MOD : sum
    }

    @inline(__always)
    private func modSub(_ a: Int, _ b: Int) -> Int {
        let diff = a - b
        return diff < 0 ? diff + MOD : diff
    }
}