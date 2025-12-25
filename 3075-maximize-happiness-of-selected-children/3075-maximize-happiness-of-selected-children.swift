/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n log n)
///     - Sorting the happiness values dominates.
///
/// Space Complexity:
///   • O(1) extra space (ignoring sorting space).
///
/// Problem Summary:
///   We select exactly `k` children.
///   Each time a child is selected, the happiness of every remaining child
///   decreases by 1. We want to maximize the total happiness.
///
/// Greedy Insight:
///   - Always pick the child with the highest remaining happiness.
///   - After picking `i` children, the effective happiness becomes:
///         happiness[i] - i
///   - If this value is negative, treat it as 0.
/// ---------------------------------------------------------------------------

class Solution {
    func maximumHappinessSum(_ happiness: [Int], _ k: Int) -> Int {
        // Sort happiness values in descending order
        let sortedHappiness = happiness.sorted(by: >)
        
        var totalHappiness = 0
        
        // Pick the top k children
        for index in 0..<k {
            // Effective happiness after index picks
            let effectiveHappiness = max(0, sortedHappiness[index] - index)
            totalHappiness += effectiveHappiness
        }
        
        return totalHappiness
    }
}
