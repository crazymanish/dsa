/**
 Problem Summary:
 A "happy string" is a string of length `n` built from ['a','b','c'] such that
 no two adjacent characters are the same.

 All happy strings are ordered lexicographically. Return the k-th happy string.
 If fewer than k strings exist, return an empty string.

 Strategy:
 Instead of generating all strings with backtracking, we construct the answer
 directly using combinatorics.

 Key Observations:
 - First character has 3 choices.
 - Each subsequent position has 2 choices (cannot repeat the previous character).
 - Therefore total happy strings = 3 * 2^(n-1).

 At each step we determine which character block the k-th string belongs to.

 For example:
 If remaining positions = r, each valid prefix generates 2^r strings.

 We iterate through possible characters in lexicographical order and subtract
 blocks until we find the one containing the k-th string.

 Time Complexity:
 O(n)

 Space Complexity:
 O(n) for the result string
 */

class Solution {
    func getHappyString(_ n: Int, _ k: Int) -> String {
        // Total number of happy strings
        let totalStrings = 3 * (1 << (n - 1))
        if k > totalStrings { return "" }

        let characters: [Character] = ["a", "b", "c"]

        var remainingK = k
        var result: [Character] = []

        for position in 0..<n {
            for character in characters {
                // Skip characters equal to previous one
                if let previous = result.last, previous == character {
                    continue
                }

                // Number of strings possible if we choose this character
                let remainingPositions = n - position - 1
                let blockSize = 1 << remainingPositions

                if remainingK > blockSize {
                    // Skip this block of strings
                    remainingK -= blockSize
                } else {
                    // This character belongs to the k-th string
                    result.append(character)
                    break
                }
            }
        }

        return String(result)
    }
}