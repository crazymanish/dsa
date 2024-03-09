class Solution {
    func getCommon(_ nums1: [Int], _ nums2: [Int]) -> Int {
        var pointer1 = 0
        var pointer2 = 0
        
        while pointer1 < nums1.count && pointer2 < nums2.count {
            if nums1[pointer1] == nums2[pointer2] {
                return nums1[pointer1]
            } else if nums1[pointer1] < nums2[pointer2] {
                pointer1 += 1
            } else {
                pointer2 += 1
            }
        }
        
        return -1
    }
}