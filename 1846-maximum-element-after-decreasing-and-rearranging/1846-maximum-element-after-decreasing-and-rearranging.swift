class Solution {
    /**
     * Problem Summary:
     * Rearrange and decrement elements so that the first element is 1 and
     * adjacent elements differ by at most 1. Return the maximum possible
     * final element.
     *
     * Strategy:
     * - Bucket every value into the range [1...n].
     * - Values larger than n are treated as n since the answer cannot exceed n.
     * - Simulate the sorted order using frequencies while greedily extending
     *   the largest achievable value.
     *
     * Time Complexity: O(n)
     * Space Complexity: O(n)
     */
    func maximumElementAfterDecrementingAndRearranging(_ arr: [Int]) -> Int {
        let n = arr.count
        var frequency = Array(repeating: 0, count: n + 1)

        for value in arr {
            frequency[min(value, n)] += 1
        }

        var currentMaximum = 0

        for value in 1...n {
            while frequency[value] > 0 {
                if value > currentMaximum {
                    currentMaximum += 1
                }
                
                frequency[value] -= 1
            }
        }

        return currentMaximum
    }
}