class Solution {
    func maxPoints(_ points: [[Int]]) -> Int {
        if points.count <= 2 { return points.count }
        
        func calculateGCD(lhs: Int, rhs: Int) -> Int {
            return rhs == 0 ? lhs : calculateGCD(lhs: rhs, rhs: lhs % rhs)
        }

        var maxPointsResult = 0

        for index in 0..<points.count {
            var hashMap: [Int: [Int: Int]] = [:]
            var overPoints = 0
            var maxPoints = 0

            for index2 in index + 1..<points.count {
                var x = points[index2][0] - points[index][0]
                var y = points[index2][1] - points[index][1]

                if x == 0 && y == 0 {
                    overPoints += 1
                    continue
                }

                let gcd = calculateGCD(lhs: x, rhs: y)
                if gcd != 0 {
                    x /= gcd
                    y /= gcd
                }

                let currentPoints = (hashMap[x]?[y] ?? 0) + 1
                hashMap[x, default: [:]][y] = currentPoints
                maxPoints = max(maxPoints, currentPoints)
            }
            
            maxPointsResult = max(maxPointsResult, maxPoints + overPoints + 1)
        }
        
        return maxPointsResult
    }
}