class Solution {
    /**
     Problem Summary:
     Given two sorted integer arrays, return the smallest value that appears in both arrays.
     If no common value exists, return -1.

     Strategy:
     Use two pointers to scan both sorted arrays from left to right.
     - If both values are equal, we found the smallest common value.
     - If the first value is smaller, move the first pointer forward.
     - If the second value is smaller, move the second pointer forward.

     Time Complexity:
     O(n + m), where n is nums1.count and m is nums2.count.

     Space Complexity:
     O(1), since only two pointers are used.
     */
    func getCommon(_ nums1: [Int], _ nums2: [Int]) -> Int {
        var firstIndex = 0
        var secondIndex = 0

        while firstIndex < nums1.count && secondIndex < nums2.count {
            let firstValue = nums1[firstIndex]
            let secondValue = nums2[secondIndex]

            // Since both arrays are sorted, the first equal value is the smallest common value.
            if firstValue == secondValue {
                return firstValue
            }

            // Move the pointer with the smaller value to catch up to the larger value.
            if firstValue < secondValue {
                firstIndex += 1
            } else {
                secondIndex += 1
            }
        }

        // No common value exists.
        return -1
    }
}