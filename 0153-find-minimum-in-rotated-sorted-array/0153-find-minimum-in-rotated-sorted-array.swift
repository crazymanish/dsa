class Solution {
    /**
     Problem Summary:
     Given a rotated sorted array, return the minimum element.

     Strategy:
     Recursively divide the array into left and right halves, then return the smallest
     value found across both halves. This keeps the original recursive search behavior.

     Time Complexity:
     O(n), because every element may be visited.

     Space Complexity:
     O(log n) average recursion depth from dividing the range in half.
     */
    func findMin(_ nums: [Int]) -> Int {
        func findMinimum(in rangeStart: Int, through rangeEnd: Int) -> Int {
            // Empty range: return a large value so it does not affect the minimum.
            guard rangeStart <= rangeEnd else {
                return Int.max
            }

            let middleIndex = rangeStart + (rangeEnd - rangeStart) / 2
            let middleValue = nums[middleIndex]

            // Recursively search both halves.
            let leftMinimum = findMinimum(in: rangeStart, through: middleIndex - 1)
            let rightMinimum = findMinimum(in: middleIndex + 1, through: rangeEnd)

            // The minimum can be at the middle, in the left half, or in the right half.
            return min(middleValue, leftMinimum, rightMinimum)
        }

        return findMinimum(in: 0, through: nums.count - 1)
    }
}