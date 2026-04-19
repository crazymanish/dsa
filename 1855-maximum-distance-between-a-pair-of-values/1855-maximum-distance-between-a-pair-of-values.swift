class Solution {
    /**
     Problem Summary:
     Given two non-increasing arrays `nums1` and `nums2`, find the maximum distance (j - i)
     such that:
        - i <= j
        - nums1[i] <= nums2[j]

     Strategy (Two Pointers):
     - Use two pointers `i` (for nums1) and `j` (for nums2).
     - Since both arrays are non-increasing:
         * If nums1[i] <= nums2[j], it's a valid pair → update distance and move `j` forward
         * Otherwise, move `i` forward to find a smaller value
     - Ensure `j` always stays >= `i` to satisfy i <= j

     Time Complexity:
     - O(n), where n = min(nums1.count, nums2.count)

     Space Complexity:
     - O(1), constant extra space
     */

    func maxDistance(_ nums1: [Int], _ nums2: [Int]) -> Int {
        var pointerNums1 = 0   // Pointer for nums1 (index i)
        var pointerNums2 = 0   // Pointer for nums2 (index j)
        var maximumDistance = 0

        let nums1Count = nums1.count
        let nums2Count = nums2.count

        // Traverse both arrays using two pointers
        while pointerNums1 < nums1Count && pointerNums2 < nums2Count {
            // Ensure the condition i <= j holds
            if pointerNums1 > pointerNums2 {
                pointerNums2 = pointerNums1
                continue
            }

            // If valid pair (nums1[i] <= nums2[j])
            if nums1[pointerNums1] <= nums2[pointerNums2] {
                // Update maximum distance
                maximumDistance = max(maximumDistance, pointerNums2 - pointerNums1)

                // Move j forward to try expanding distance
                pointerNums2 += 1
            } else {
                // nums1[i] > nums2[j], need smaller nums1[i]
                // Move i forward
                pointerNums1 += 1
            }
        }

        return maximumDistance
    }
}