// Time Complexity: O(N²)
//   - Sorting the points takes O(N * log N).
//   - The nested loops run in O(N²) time. Inside the inner loop, all operations are O(1).
//   - The overall complexity is dominated by the nested loops.
//
// Space Complexity: O(N)
//   - Dominated by the storage for the `sortedPoints` array created for sorting.
class Solution {
    /**
     * Counts valid pairs of points using an optimized O(N²) approach.
     *
     * The strategy is:
     * 1. Sort the points by x-coordinate (ascending) and then y-coordinate (descending). This
     * ensures we always process points from left to right, and for points with the same
     * x-value, we process the higher one first.
     * 2. Iterate through each point, treating it as a fixed potential top-left corner (`topLeftPoint`).
     * 3. For each fixed `topLeftPoint`, iterate through all subsequent points (`bottomRightCandidate`).
     * 4. A pair is valid if the `bottomRightCandidate` is in the correct quadrant (below and to the right)
     * AND the rectangle formed by the pair contains no other points.
     * 5. We check this efficiently by maintaining a `highestBlockingY` level. For a `bottomRightCandidate`
     * to be valid, it must be "visible" from `topLeftPoint`, meaning its y-coordinate must be higher
     * than the y-coordinate of any other valid point we've already considered between them.
     */
    func numberOfPairs(_ points: [[Int]]) -> Int {
        // Sort points primarily by x-coordinate, and secondarily by y-coordinate descending.
        let sortedPoints = points.sorted { p1, p2 in
            if p1[0] != p2[0] {
                return p1[0] < p2[0]
            } else {
                return p1[1] > p2[1]
            }
        }
        
        let pointCount = sortedPoints.count
        var validPairCount = 0

        // Fix one point as the potential top-left corner of the rectangle.
        for i in 0..<pointCount {
            let topLeftPoint = sortedPoints[i]
            let topLeftY = topLeftPoint[1]
            
            // This tracks the highest 'y' of any point encountered so far that is below topLeftPoint.
            // This forms a "ceiling" that blocks the "line of sight" to other points.
            var highestBlockingY = Int.min
            
            // Iterate through subsequent points as potential bottom-right corners.
            for j in (i + 1)..<pointCount {
                let bottomRightCandidate = sortedPoints[j]
                let bottomRightY = bottomRightCandidate[1]
                
                // First, check if the candidate is in the correct quadrant (below and to the right).
                // The x-condition (`x_j >= x_i`) is guaranteed by the loops and sorting.
                if bottomRightY <= topLeftY {
                    
                    // Now, check if this candidate is "visible" from topLeftPoint.
                    // A candidate is visible if its y-coordinate is higher than the blocking ceiling
                    // formed by all intermediate points we've checked. If it is, no intermediate point
                    // can be inside the bounding box this pair would form.
                    if bottomRightY > highestBlockingY {
                        validPairCount += 1
                    }
                    
                    // Any point in the correct quadrant, whether it forms a valid pair or not,
                    // contributes to the blocking ceiling for subsequent points to its right.
                    highestBlockingY = max(highestBlockingY, bottomRightY)
                }
            }
        }
        return validPairCount
    }
}
