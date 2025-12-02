/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n), where n = number of points
///     - Counting y-values takes O(n)
///     - Iterating over distinct y-groups is O(unique_y)
///
/// Space Complexity:
///   • O(unique_y)
///     - Hash map storing count of points per unique y-coordinate.
///
/// Explanation:
///   A trapezoid is formed when:
///     - You choose two distinct horizontal lines (y₁, y₂)
///     - And on each line you choose a pair of points with the same y-value,
///       forming two parallel horizontal segments.
///   
///   Number of pairs on a horizontal line with `c` points:
///       pairs = c * (c - 1) / 2
///
///   For every new horizontal line, we multiply its pair-count with the
///   cumulative sum of all previously seen pair-counts to count trapezoids.
/// ---------------------------------------------------------------------------

class Solution {
    func countTrapezoids(_ points: [[Int]]) -> Int {
        let mod = 1_000_000_007
        
        // Count how many points lie on each y-coordinate
        var countByY: [Int: Int] = [:]
        for point in points {
            countByY[point[1], default: 0] += 1
        }
        
        var result = 0       // Total trapezoid count
        var accumulatedPairs = 0  // Sum of all pair counts seen so far
        
        // Iterate through horizontal levels (order doesn't matter)
        for pointCount in countByY.values where pointCount > 1 {
            
            // Number of horizontal pairs on this y-coordinate
            let pairsOnThisLevel = pointCount * (pointCount - 1) / 2
            
            // Each new set of pairs can form trapezoids with ALL prior pairs
            result = (result + pairsOnThisLevel * accumulatedPairs) % mod
            
            // Accumulate for future levels
            accumulatedPairs = (accumulatedPairs + pairsOnThisLevel) % mod
        }
        
        return result
    }
}
