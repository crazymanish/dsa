class Solution {
    /**
     Problem Summary:
     Given an array `colors`, find the maximum distance between two houses
     whose colors are different.

     Strategy:
     The farthest possible pair must involve one of the ends.
     So we:
     1. Fix the leftmost house and scan from the right until we find a different color.
     2. Fix the rightmost house and scan from the left until we find a different color.
     The answer is the larger of those two distances.

     Time Complexity:
     O(n)

     Space Complexity:
     O(1)
     */
    func maxDistance(_ colors: [Int]) -> Int {
        let houseCount = colors.count
        let leftmostColor = colors[0]
        let rightmostColor = colors[houseCount - 1]

        var maximumDistance = 0

        // Find the farthest house from the right that differs from the leftmost house.
        for index in stride(from: houseCount - 1, through: 0, by: -1) {
            if colors[index] != leftmostColor {
                maximumDistance = max(maximumDistance, index)
                break
            }
        }

        // Find the farthest house from the left that differs from the rightmost house.
        for index in 0..<houseCount {
            if colors[index] != rightmostColor {
                maximumDistance = max(maximumDistance, houseCount - 1 - index)
                break
            }
        }

        return maximumDistance
    }
}