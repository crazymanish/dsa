class Solution {
    func maxDistance(_ position: [Int], _ m: Int) -> Int {
        let sortedPosition = position.sorted()

        func numBalls(force: Int) -> Int {
            var balls = 0
            var previousPosition = -force
            for currentPosition in sortedPosition {
                if currentPosition - previousPosition >= force {
                    balls += 1
                    previousPosition = currentPosition
                }
            }
            return balls
        }

        var left = 1
        var right = sortedPosition.last! - sortedPosition.first!
        while left < right {
            let mid = right - (right - left) / 2
            if numBalls(force: mid) >= m {
                left = mid
            } else {
                right = mid - 1
            }
        }

        return left
    }
}