/*
Time Complexity: O(N + C)
- Let N be the upper bound of the numbers and C be the number of conflicting pairs.
- The first pass to preprocess conflicts takes O(C) time.
- The second, main pass iterates from N down to 1, taking O(N) time.
- The final loop to find the maximum gain is also O(N).
- The overall complexity is linear with respect to the input size.

Space Complexity: O(N)
- The solution uses several arrays (firstConflictAt, secondConflictAt, gainFromRemoval), each of size N+1. The space required scales linearly with N.
*/
class Solution {
    func maxSubarrays(_ n: Int, _ conflictingPairs: [[Int]]) -> Int {
        // MARK: - Phase 1: Preprocess Conflicts
        // For each starting point `i`, find the two conflicts that occur soonest.
        // `firstConflictAt[i]` = the smallest `j` where (i, j) is a conflicting pair.
        // `secondConflictAt[i]` = the second-smallest `j`.
        var firstConflictAt = [Int](repeating: Int.max, count: n + 1)
        var secondConflictAt = [Int](repeating: Int.max, count: n + 1)

        for pair in conflictingPairs {
            let start = min(pair[0], pair[1])
            let end = max(pair[0], pair[1])

            if firstConflictAt[start] > end {
                secondConflictAt[start] = firstConflictAt[start]
                firstConflictAt[start] = end
            } else if secondConflictAt[start] > end {
                secondConflictAt[start] = end
            }
        }

        // MARK: - Phase 2: Main Calculation (Backward Pass)
        // We iterate backward from i = n to 1 to calculate the number of valid subarrays.
        // A subarray [i, j] is valid if no conflict exists within it.
        
        // The base count of valid subarrays, assuming we don't ignore any conflicts.
        var baseSubarrayCount = 0
        
        // Tracks the starting point of the conflict that currently limits our subarrays.
        // This is the `i` with the minimum `firstConflictAt[i]` seen so far.
        var activeConstraintStart = n
        
        // Tracks the end position of the second-closest conflict found so far.
        var secondClosestConflictEnd = Int.max
        
        // `gainFromRemoval[i]` stores the number of extra subarrays we would get if we
        // chose to ignore the conflict starting at `i`.
        var gainFromRemoval = [Int](repeating: 0, count: n + 1)
        
        for currentStart in (1...n).reversed() {
            // Update the active constraints as we move `currentStart` to the left.
            if firstConflictAt[activeConstraintStart] > firstConflictAt[currentStart] {
                // `currentStart` introduces a tighter constraint. The old constraint
                // becomes a candidate for the second-closest one.
                secondClosestConflictEnd = min(secondClosestConflictEnd, firstConflictAt[activeConstraintStart])
                activeConstraintStart = currentStart
            } else {
                // The constraint from `currentStart` is not as tight, but it might be
                // the second-closest one.
                secondClosestConflictEnd = min(secondClosestConflictEnd, firstConflictAt[currentStart])
            }

            // The end of any valid subarray starting at `currentStart` must be before the
            // earliest conflict boundary for any start >= `currentStart`.
            let firstBoundary = min(firstConflictAt[activeConstraintStart], n + 1)
            baseSubarrayCount += firstBoundary - currentStart
            
            // Calculate the potential gain if we ignore the `activeConstraintStart`.
            // The new boundary would be the next closest conflict.
            let secondBoundary = min(min(secondClosestConflictEnd, secondConflictAt[activeConstraintStart]), n + 1)
            let gain = secondBoundary - firstBoundary
            gainFromRemoval[activeConstraintStart] += gain
        }

        // MARK: - Phase 3: Final Result
        // Find the maximum possible gain from ignoring a single conflict.
        let maxGain = gainFromRemoval.max() ?? 0

        // The total is the base count plus the best possible gain.
        return baseSubarrayCount + maxGain
    }
}