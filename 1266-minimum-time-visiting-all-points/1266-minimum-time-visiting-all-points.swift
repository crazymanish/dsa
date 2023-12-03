class Solution {
    func minTimeToVisitAllPoints(_ points: [[Int]]) -> Int {
        var minTime = 0
        var previousPoint = points[0]
        
        for currentIndex in 1..<points.count {
            let currentPoint = points[currentIndex]
            let distanceX = currentPoint[0]-previousPoint[0]
            let distanceY = currentPoint[1]-previousPoint[1]
            
            minTime += max(abs(distanceX), abs(distanceY))
            previousPoint = currentPoint
        }
        
        return minTime
    }
}