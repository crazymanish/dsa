class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n), where n = points.count
    ///     We visit each point exactly once.
    ///
    /// Space Complexity:
    ///   • O(1)
    ///     Only constant extra variables are used.
    ///
    /// Problem Summary:
    ///   Starting from points[0], visit all points in order.
    ///   In one second, you may move:
    ///     - vertically,
    ///     - horizontally, or
    ///     - diagonally.
    ///
    /// Key Insight:
    ///   The minimum time to move between two points (x1, y1) → (x2, y2)
    ///   when diagonal movement is allowed is:
    ///
    ///       max(|x2 - x1|, |y2 - y1|)
    ///
    ///   because diagonal moves reduce both x and y distances simultaneously.
    /// -----------------------------------------------------------------------
    func minTimeToVisitAllPoints(_ points: [[Int]]) -> Int {
        guard points.count > 1 else { return 0 }
        
        var totalTime = 0
        var previousPoint = points[0]
        
        // Visit each point in order
        for index in 1..<points.count {
            let currentPoint = points[index]
            
            let deltaX = abs(currentPoint[0] - previousPoint[0])
            let deltaY = abs(currentPoint[1] - previousPoint[1])
            
            // Minimum time needed to move to the next point
            totalTime += max(deltaX, deltaY)
            
            previousPoint = currentPoint
        }
        
        return totalTime
    }
}
