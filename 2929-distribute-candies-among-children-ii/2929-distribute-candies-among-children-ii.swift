// Time Complexity: O(limit)
// The main loop iterates from `minPossibleCandiesForFirstChild` to `maxPossibleCandiesForFirstChild`.
// The number of iterations is `maxPossibleCandiesForFirstChild - minPossibleCandiesForFirstChild + 1`.
// - `maxPossibleCandiesForFirstChild` is at most `limit`.
// - `minPossibleCandiesForFirstChild` is at least `0`.
// In the worst-case scenario (e.g., when `totalCandiesToDistribute` is between `limit` and `2 * limit`),
// the loop runs approximately `limit` times. For example, if `totalCandiesToDistribute = limit`,
// `minPossibleCandiesForFirstChild = max(0, limit - 2*limit) = 0`, `maxPossibleCandiesForFirstChild = min(limit, limit) = limit`.
// The loop runs `limit - 0 + 1 = limit + 1` times.
// All operations inside the loop are constant time. Thus, the complexity is O(limit).
//
// Space Complexity: O(1)
// The algorithm uses a fixed number of variables to store counts and intermediate calculations,
// regardless of the input size. Therefore, the space complexity is constant.

class Solution {
    func distributeCandies(_ totalCandiesToDistribute: Int, _ maxCandiesPerChild: Int) -> Int {
        var validDistributionsCount = 0

        // Determine the valid range for candies given to the first child (let's call it 'c1').
        // c1 + c2 + c3 = totalCandiesToDistribute
        // 0 <= c1, c2, c3 <= maxCandiesPerChild

        // Lower bound for candiesForFirstChild (c1):
        // Since c2 <= maxCandiesPerChild and c3 <= maxCandiesPerChild, then c2 + c3 <= 2 * maxCandiesPerChild.
        // c1 = totalCandiesToDistribute - (c2 + c3).
        // So, c1 >= totalCandiesToDistribute - 2 * maxCandiesPerChild.
        // Also, c1 must be >= 0.
        let minPossibleCandiesForFirstChild = max(0, totalCandiesToDistribute - 2 * maxCandiesPerChild)

        // Upper bound for candiesForFirstChild (c1):
        // c1 cannot exceed totalCandiesToDistribute.
        // c1 cannot exceed maxCandiesPerChild (problem constraint).
        let maxPossibleCandiesForFirstChild = min(totalCandiesToDistribute, maxCandiesPerChild)

        // If the calculated lower bound is greater than the upper bound,
        // it means there's no valid number of candies the first child can receive.
        if minPossibleCandiesForFirstChild > maxPossibleCandiesForFirstChild {
            return 0
        }

        // Iterate through all possible numbers of candies for the first child.
        for candiesForFirstChild in minPossibleCandiesForFirstChild...maxPossibleCandiesForFirstChild {
            // Calculate candies remaining to be distributed between the second and third child.
            let candiesRemainingForTwoChildren = totalCandiesToDistribute - candiesForFirstChild

            // Now, we need to find pairs (c2, c3) such that:
            // c2 + c3 = candiesRemainingForTwoChildren
            // 0 <= c2 <= maxCandiesPerChild
            // 0 <= c3 <= maxCandiesPerChild

            // Let's find the range for candiesForSecondChild (c2).
            // c3 = candiesRemainingForTwoChildren - c2.
            // Substitute c3 into its constraints: 0 <= candiesRemainingForTwoChildren - c2 <= maxCandiesPerChild.

            // From `candiesRemainingForTwoChildren - c2 >= 0`, we get `c2 <= candiesRemainingForTwoChildren`.
            // From `candiesRemainingForTwoChildren - c2 <= maxCandiesPerChild`, we get `c2 >= candiesRemainingForTwoChildren - maxCandiesPerChild`.

            // Combining with `0 <= c2 <= maxCandiesPerChild`:
            // Lower bound for c2: max(0, candiesRemainingForTwoChildren - maxCandiesPerChild)
            let minPossibleCandiesForSecondChild = max(0, candiesRemainingForTwoChildren - maxCandiesPerChild)
            // Upper bound for c2: min(maxCandiesPerChild, candiesRemainingForTwoChildren)
            let maxPossibleCandiesForSecondChild = min(maxCandiesPerChild, candiesRemainingForTwoChildren)

            // If a valid range for c2 exists (lower bound <= upper bound),
            // the number of ways to choose c2 (and thus c3) is (max - min + 1).
            if minPossibleCandiesForSecondChild <= maxPossibleCandiesForSecondChild {
                validDistributionsCount += (maxPossibleCandiesForSecondChild - minPossibleCandiesForSecondChild + 1)
            }
        }

        return validDistributionsCount
    }
}