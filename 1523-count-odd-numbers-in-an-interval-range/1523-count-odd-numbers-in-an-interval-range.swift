/// ---------------------------------------------------------------------------
/// Time Complexity:   O(1)
/// Space Complexity:  O(1)
///
/// Explanation:
///   The number of odd integers in [low, high] is:
///       (high + 1) / 2  -  low / 2
///
///   This works because:
///     • (x / 2) gives number of odds ≤ (x - 1)
///     • ((x + 1) / 2) gives number of odds ≤ x
/// ---------------------------------------------------------------------------
class Solution {
    func countOdds(_ low: Int, _ high: Int) -> Int {
        return (high + 1) / 2 - (low / 2)
    }
}
