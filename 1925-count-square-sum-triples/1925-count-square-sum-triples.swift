/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • Precomputing squares:  O(n)
///   • Nested loops over (a, b):  O(n²)
///   • Checking membership in a Set:  O(1) average
///
///   => Total Time Complexity:  O(n²)
///
/// Space Complexity:
///   • O(n) for storing perfect squares of numbers 1...n
///
/// Why this avoids floating-point issues:
///   Instead of computing c = sqrt(a² + b²), we store all perfect squares
///   in a Set and simply check:
///         a² + b² ∈ squares
///
///   This eliminates floating-point inaccuracies and improves performance.
/// ---------------------------------------------------------------------------

class Solution {
    func countTriples(_ n: Int) -> Int {
        // Precompute perfect squares of all valid c values: c ∈ [1, n]
        let perfectSquares = Set((1...n).map { $0 * $0 })
        
        var tripleCount = 0
        
        // Try all valid pairs (a, b)
        for a in 1...n {
            let aSquared = a * a
            
            for b in 1...n {
                let cSquared = aSquared + b * b
                
                // If c² is a perfect square and c ≤ n, then it's a valid triple
                if perfectSquares.contains(cSquared) {
                    tripleCount += 1
                }
            }
        }
        
        return tripleCount
    }
}
