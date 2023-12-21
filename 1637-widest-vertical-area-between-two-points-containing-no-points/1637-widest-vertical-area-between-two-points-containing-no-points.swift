class Solution {
    func maxWidthOfVerticalArea(_ points: [[Int]]) -> Int {
        let sortedPoints = points.sorted { $0[0] < $1[0]}
        var result = 0
        
        for index in 0..<sortedPoints.count-1 {
            let currentIndexResult = sortedPoints[index+1][0] - sortedPoints[index][0]
            
            result = max(result, currentIndexResult)
        }

        return result
    }
}