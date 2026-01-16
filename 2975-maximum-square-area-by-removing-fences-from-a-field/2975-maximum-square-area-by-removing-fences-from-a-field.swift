class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(H² + V²)
    ///     - H = number of horizontal fences
    ///     - V = number of vertical fences
    ///     We compute all pairwise distances in both directions.
    ///
    /// Space Complexity:
    ///   • O(H² + V²)
    ///     - Sets storing all possible fence distances.
    ///
    /// Problem Summary:
    ///   Given horizontal and vertical fences on a grid, find the largest
    ///   square area that can be formed between fences.
    ///
    /// Key Insight:
    ///   - A square is possible if there exists a distance `d` such that:
    ///       • `d` is a distance between two horizontal fences
    ///       • `d` is also a distance between two vertical fences
    ///   - The largest such `d` produces the maximum square area.
    /// -----------------------------------------------------------------------
    func maximizeSquareArea(_ maxRow: Int, _ maxCol: Int, _ horizontalFences: [Int], _ verticalFences: [Int]) -> Int {
        let MOD = 1_000_000_007
        
        // Include the grid boundaries as fences
        var allHorizontalFences = horizontalFences + [1, maxRow]
        var allVerticalFences = verticalFences + [1, maxCol]
        
        // Sort fence positions
        allHorizontalFences.sort()
        allVerticalFences.sort()
        
        /// Collect all possible distances between horizontal fences
        var horizontalDistances = Set<Int>()
        for i in 0..<allHorizontalFences.count {
            for j in (i + 1)..<allHorizontalFences.count {
                horizontalDistances.insert(
                    allHorizontalFences[j] - allHorizontalFences[i]
                )
            }
        }
        
        /// Collect all possible distances between vertical fences
        var verticalDistances = Set<Int>()
        for i in 0..<allVerticalFences.count {
            for j in (i + 1)..<allVerticalFences.count {
                verticalDistances.insert(
                    allVerticalFences[j] - allVerticalFences[i]
                )
            }
        }
        
        // Find common side lengths available in both directions
        let commonSideLengths = horizontalDistances.intersection(verticalDistances)
        
        // If no square can be formed
        guard let maxSideLength = commonSideLengths.max() else {
            return -1
        }
        
        // Area of the largest square
        return (maxSideLength * maxSideLength) % MOD
    }
}
