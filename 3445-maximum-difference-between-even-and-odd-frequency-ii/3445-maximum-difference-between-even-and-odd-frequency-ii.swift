// Time Complexity: O(n)
// The algorithm iterates through a constant number of digit pairs (5 * 4 = 20).
// For each pair, it uses a single-pass sliding window approach over the input string.
// The `right` pointer moves n times, and the `left` pointer also moves at most n times in total
// across all iterations of the inner while loop.
// Thus, the overall complexity is C * O(n), which simplifies to O(n), where 'n' is the string length.

// Space Complexity: O(n)
// An array of characters `characters` is created from the input string, which requires O(n) space.
// The auxiliary space for other variables, including the 2x2 `minPrefixDifferenceByParity` table
// and various counters, is constant, i.e., O(1).
class Solution {
    /**
     * This function calculates a maximum difference based on character counts in a sliding window
     * with specific parity constraints. The original problem is not specified, but the logic is preserved
     * and clarified from the source code.
     *
     * - Parameters:
     * - S: The input string, expected to contain digits from '0' to '4'.
     * - k: The minimum size of the sliding window.
     * - Returns: The calculated maximum difference.
     */
    func maxDifference(_ s: String, _ k: Int) -> Int {
        let characters = Array(s)
        let stringLength = characters.count
        // Use a large number to represent infinity, avoiding overflow from Int.max.
        let infinity = Int.max / 2
        var maximizedDifference = -infinity

        // The problem is constrained to digits '0' through '4'.
        // We iterate through all possible distinct pairs of digits (firstDigit, secondDigit).
        for firstDigitValue in 0...4 {
            for secondDigitValue in 0...4 {
                if firstDigitValue == secondDigitValue {
                    continue // The two chosen digits must be distinct.
                }

                let firstChar = Character(String(firstDigitValue))
                let secondChar = Character(String(secondDigitValue))

                // `totalCountA/B` track occurrences of chars from the start of the string up to the `right` pointer.
                var totalCountA = 0
                var totalCountB = 0
                // `prefixCountA/B` track occurrences up to the `left` pointer (the part before the window).
                var prefixCountA = 0
                var prefixCountB = 0
                
                // This table stores the minimum value of (prefixCountA - prefixCountB) seen so far.
                // It is indexed by the parity (even=0, odd=1) of prefixCountA and prefixCountB.
                // `minPrefixDifferenceByParity[parityA][parityB] = min(prefixCountA - prefixCountB)`
                var minPrefixDifferenceByParity = Array(repeating: Array(repeating: infinity, count: 2), count: 2)

                var left = -1
                // Use a sliding window, expanding with the `right` pointer.
                for right in 0..<stringLength {
                    if characters[right] == firstChar { totalCountA += 1 }
                    if characters[right] == secondChar { totalCountB += 1 }

                    // Shrink the window from the left based on these conditions:
                    // 1. The window size (`right - left`) is at least `k`.
                    // 2. The number of `secondChar`s within the window (`totalCountB - prefixCountB`) is at least 2.
                    while right - left >= k && totalCountB - prefixCountB >= 2 {
                        // Determine the parity (0 for even, 1 for odd) of the prefix counts.
                        let parityA = prefixCountA & 1
                        let parityB = prefixCountB & 1
                        
                        // Update the table with the minimum difference found for this specific parity combination.
                        minPrefixDifferenceByParity[parityA][parityB] = min(minPrefixDifferenceByParity[parityA][parityB], prefixCountA - prefixCountB)
                        
                        // Move the left boundary of the window forward and update prefix counts.
                        left += 1
                        if characters[left] == firstChar { prefixCountA += 1 }
                        if characters[left] == secondChar { prefixCountB += 1 }
                    }

                    // The expression to maximize is: (countA_in_window) - (countB_in_window)
                    // This can be rewritten as: (totalCountA - totalCountB) - (prefixCountA - prefixCountB).
                    // To maximize this, we must subtract the minimum possible `prefixCountA - prefixCountB`.
                    
                    // The problem also imposes parity constraints on the window counts:
                    // 1. `countA_in_window` must be odd: (totalCountA - prefixCountA) % 2 == 1
                    // 2. `countB_in_window` must be even: (totalCountB - prefixCountB) % 2 == 0
                    // This means we need a prefix state where `prefixCountA` has the opposite parity of `totalCountA`,
                    // and `prefixCountB` has the same parity as `totalCountB`.
                    
                    let requiredPrefixParityA = (totalCountA & 1) ^ 1
                    let requiredPrefixParityB = totalCountB & 1
                    let minPrefixDiff = minPrefixDifferenceByParity[requiredPrefixParityA][requiredPrefixParityB]

                    // If a valid prefix state was found (i.e., not infinity), update the result.
                    if minPrefixDiff != infinity {
                         maximizedDifference = max(maximizedDifference, totalCountA - totalCountB - minPrefixDiff)
                    }
                }
            }
        }

        return maximizedDifference
    }
}