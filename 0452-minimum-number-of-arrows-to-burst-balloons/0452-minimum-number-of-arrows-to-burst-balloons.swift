class Solution {
    func findMinArrowShots(_ points: [[Int]]) -> Int {
        var sortedPoints = points.sorted{$0[1] < $1[1]}
        var answer = 1 
        var last = sortedPoints[0][1]
        
        for point in sortedPoints {
            if point[0] > last {
                last = point[1]
                answer += 1
            }
        }

        return answer
    }
}