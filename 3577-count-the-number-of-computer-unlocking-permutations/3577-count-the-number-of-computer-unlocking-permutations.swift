/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n), where n = complexity.count
///     We scan from index 1 to n-1 and multiply values modulo 1e9+7.
///
/// Space Complexity:
///   • O(1)
///     Only constant extra space is used.
///
/// Explanation:
///   We want to count permutations valid under a rule:
///       Every complexity[i] must be strictly greater than complexity[0].
///
///   If any complexity[i] ≤ complexity[0], the answer is 0.
///   Otherwise, the number of valid permutations is:
///       (n - 1)!
///   computed as a running product modulo 1e9+7.
/// ---------------------------------------------------------------------------

class Solution {
    func countPermutations(_ complexity: [Int]) -> Int {
        let mod = 1_000_000_007
        let n = complexity.count
        
        // If there is only 1 task, only 1 permutation exists
        if n <= 1 { return 1 }
        
        // Base complexity threshold
        let base = complexity[0]
        
        // Count permutations of indices [1...n-1]
        var result = 1
        
        for i in 1..<n {
            // If any value violates the strict greater-than rule → no valid permutations
            if complexity[i] <= base {
                return 0
            }
            
            // Multiply by i (building factorial modulo mod)
            result = (result * i) % mod
        }
        
        return result
    }
}
