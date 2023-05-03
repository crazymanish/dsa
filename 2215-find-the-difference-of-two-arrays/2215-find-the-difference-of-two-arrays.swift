class Solution {
    func findDifference(_ nums1: [Int], _ nums2: [Int]) -> [[Int]] {
        let set1 = Set(nums1)
        let set2 = Set(nums2)

        let nums1Difference = set1.subtracting(set2)
        let nums2Difference = set2.subtracting(set1)

        return [Array(nums1Difference), Array(nums2Difference)]
    }
}