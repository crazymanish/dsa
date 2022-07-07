// https://leetcode.com/problems/merge-sorted-array

class Solution {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var mergePointerIndex = m+n-1
        var nums1PointerIndex = m-1
        var nums2PointerIndex = n-1
       
        while mergePointerIndex >= 0 && nums2PointerIndex >= 0 {
            if nums1PointerIndex >= 0 && nums1[nums1PointerIndex] > nums2[nums2PointerIndex] {
                nums1[mergePointerIndex] = nums1[nums1PointerIndex]
                nums1PointerIndex -= 1
            } else {
                nums1[mergePointerIndex] = nums2[nums2PointerIndex]
                nums2PointerIndex -= 1
            }
            
            mergePointerIndex -= 1
        }
    }
}