class Solution {
    /**
     Problem Summary:
     Given a rotated sorted array that may contain duplicates, return the minimum value.

     Strategy:
     Use binary search with two pointers:
     - If nums[mid] > nums[right], the minimum must be on the right side.
     - If nums[mid] < nums[right], the minimum is at mid or on the left side.
     - If nums[mid] == nums[right], duplicates make the direction unclear, so safely shrink right by one.

     Time Complexity:
     O(log n) on average.
     O(n) in the worst case when many duplicates exist.

     Space Complexity:
     O(1), because the search is iterative and uses constant extra space.
     */
    func findMin(_ nums: [Int]) -> Int {
        var leftIndex = 0
        var rightIndex = nums.count - 1

        while leftIndex < rightIndex {
            let middleIndex = leftIndex + (rightIndex - leftIndex) / 2

            if nums[middleIndex] > nums[rightIndex] {
                // Minimum must be to the right of middleIndex because the rotation point
                // is inside the right half.
                leftIndex = middleIndex + 1
            } else if nums[middleIndex] < nums[rightIndex] {
                // Minimum can be middleIndex itself or somewhere to its left.
                rightIndex = middleIndex
            } else {
                // nums[middleIndex] == nums[rightIndex]
                // Duplicate values prevent us from knowing which side contains the minimum.
                // Removing nums[rightIndex] is safe because nums[middleIndex] has the same value.
                rightIndex -= 1
            }
        }

        return nums[leftIndex]
    }
}