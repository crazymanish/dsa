class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • Worst case: O(n²)
    ///     We may still examine all pairs of rectangles.
    ///     Safe pruning often reduces the average work.
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     For sorting rectangle indices.
    ///
    /// Problem Summary:
    ///   For every pair of rectangles, compute their intersection.
    ///   The largest square that fits inside the intersection has side:
    ///       min(intersectionWidth, intersectionHeight)
    ///   Return the maximum square area over all pairs.
    ///
    /// Optimization:
    ///   Sort by leftX. For a fixed rectangle A:
    ///     - If leftB >= rightA - bestSide, then (rightA - leftB) <= bestSide,
    ///       so no later rectangle can beat bestSide in X direction.
    ///     - This is a SAFE early break.
    /// -----------------------------------------------------------------------
    func largestSquareArea(_ bottomLeft: [[Int]], _ topRight: [[Int]]) -> Int {
        let rectangleCount = bottomLeft.count
        var bestSquareSide = 0
        
        // Sort rectangle indices by increasing left X
        let indicesSortedByLeftX = (0..<rectangleCount).sorted {
            bottomLeft[$0][0] < bottomLeft[$1][0]
        }
        
        for i in 0..<rectangleCount {
            let rectA = indicesSortedByLeftX[i]
            
            let leftAX = bottomLeft[rectA][0]
            let bottomAY = bottomLeft[rectA][1]
            let rightAX = topRight[rectA][0]
            let topAY = topRight[rectA][1]
            
            for j in (i + 1)..<rectangleCount {
                let rectB = indicesSortedByLeftX[j]
                
                let leftBX = bottomLeft[rectB][0]
                
                // SAFE pruning:
                // Maximum possible overlap width with rectA is at most (rightAX - leftBX).
                // Since leftBX only increases as j increases, if it's already too large,
                // no future rectB can improve.
                if leftBX >= rightAX - bestSquareSide {
                    break
                }
                
                let bottomBY = bottomLeft[rectB][1]
                let rightBX = topRight[rectB][0]
                let topBY = topRight[rectB][1]
                
                // Compute intersection boundaries
                let intersectLeft = max(leftAX, leftBX)
                let intersectRight = min(rightAX, rightBX)
                let intersectBottom = max(bottomAY, bottomBY)
                let intersectTop = min(topAY, topBY)
                
                // No overlap => skip
                if intersectLeft >= intersectRight || intersectBottom >= intersectTop {
                    continue
                }
                
                // Intersection width/height
                let overlapWidth = intersectRight - intersectLeft
                let overlapHeight = intersectTop - intersectBottom
                
                // If even the best possible square here can't beat current best, skip
                if overlapWidth <= bestSquareSide || overlapHeight <= bestSquareSide {
                    continue
                }
                
                // Best square side inside the intersection
                let candidateSide = min(overlapWidth, overlapHeight)
                bestSquareSide = max(bestSquareSide, candidateSide)
            }
        }
        
        return bestSquareSide * bestSquareSide
    }
}
