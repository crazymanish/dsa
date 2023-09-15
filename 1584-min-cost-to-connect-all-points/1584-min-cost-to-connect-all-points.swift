class Solution {
    func minCostConnectPoints(_ points: [[Int]]) -> Int {
        var connected = Array(repeating: false, count: points.count)
        var weights = Array(repeating: Int.max, count: points.count)
        weights[0] = 0
        
        func distance(_ from: [Int], _ to: [Int]) -> Int {
            abs((from[0] - to[0])) + abs((from[1] - to[1]))
        }
        
        func getNearestPointDetail() -> (point: Int, distance: Int) {
            var pointDetail = (point: -1, distance: Int.max)
        
            for i in 0..<weights.count {
                if connected[i] { continue }
            
                if weights[i] < pointDetail.distance {
                    pointDetail = (point: i, distance: weights[i])
                }
            }
        
            return pointDetail
        }
        
        func updateWeights(_ from: Int) {
            for i in 0..<points.count {
                if connected[i] { continue }
            
                weights[i] = min(weights[i], distance(points[from], points[i]))
            }
        }
        
        var result = 0
        for _ in points {
            let nearestPointDetail = getNearestPointDetail()
            result += nearestPointDetail.distance
            
            let currentPoint = nearestPointDetail.point
            connected[currentPoint] = true           
            updateWeights(currentPoint)
        }
        
        return result
    }
}