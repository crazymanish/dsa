// Time Complexity: O(N log N)
// The initial sorting of the `power` array dominates the runtime, taking O(N log N).
// The recursive `helper` function itself runs in O(N) time. Although it's recursive,
// memoization ensures that the work for each unique starting index is done only once.
// The inner `while` loops advance pointers through the array, and over all unique
// recursive calls, this amounts to a single traversal.
//
// Space Complexity: O(N)
// The space is used for the sorted copy of the `power` array, the `dp` memoization
// array of size N+1, and the recursion call stack, which can go up to N deep.
class Solution {
    func maximumTotalDamage(_ power: [Int]) -> Int {
        let n = power.count
        // Sorting is crucial to group identical spells and efficiently find the next valid spell.
        let power = power.sorted()

        // `dp` array for memoization. dp[i] will store the max damage from index `i` onwards.
        // Using 0 as a sentinel for "not yet computed".
        var dp = Array(repeating: 0, count: n + 1)

        // `helper` is a recursive function that calculates the max damage starting from a given index.
        func helper(_ start: Int = 0) -> Int {
            // Base case: If we've gone past the last spell, there's no more damage to add.
            if start >= n { return 0 }
            // Memoization check: If we've already solved this subproblem, return the stored result.
            if dp[start] > 0 { return dp[start]}

            // Optimization: Group all spells with the same power as `power[start]`.
            // `end` will point to the last index of this group.
            var end = start
            while end + 1 < n && power[end + 1] == power[start] {
                end += 1
            }
            let spellCount = end - start + 1
            let currentSpellDamage = spellCount * power[start]

            // Find the index of the next spell we are allowed to cast if we cast the current one.
            // We must skip any spells with power `power[start] + 1` or `power[start] + 2`.
            var next = end + 1
            while next < n && power[next] <= power[start] + 2 {
                next += 1
            }

            // The core DP recurrence relation: make a choice.
            // Choice 1: Cast the current spell (and all its duplicates).
            // Damage = (damage from this spell group) + (max damage from the next valid index onwards).
            let damageIfCast = currentSpellDamage + helper(next)
            
            // Choice 2: Skip the current spell group entirely.
            // Damage = (max damage from the next distinct spell onwards).
            let damageIfSkip = helper(end + 1)
            
            // Store and return the best outcome.
            dp[start] = max(damageIfCast, damageIfSkip)
            return dp[start]
        }

        // Start the recursive calculation from the beginning of the sorted array.
        return helper()
    }
}