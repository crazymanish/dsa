class Solution {
    func mergeArrays(_ nums1: [[Int]], _ nums2: [[Int]]) -> [[Int]] {
        var mergedArray: [[Int]] = [] // Array to store the merged result
        var nums1Index = 0 // Index for nums1
        var nums2Index = 0 // Index for nums2

        // Iterate through both arrays until one of them is exhausted
        while nums1Index < nums1.count && nums2Index < nums2.count {
            let id1 = nums1[nums1Index][0] // ID from nums1
            let id2 = nums2[nums2Index][0] // ID from nums2

            if id1 < id2 {
                mergedArray.append(nums1[nums1Index]) // Add element from nums1
                nums1Index += 1
            } else if id2 < id1 {
                mergedArray.append(nums2[nums2Index]) // Add element from nums2
                nums2Index += 1
            } else { // id1 == id2
                // Merge elements by summing their values
                mergedArray.append([id1, nums1[nums1Index][1] + nums2[nums2Index][1]])
                nums1Index += 1
                nums2Index += 1
            }
        }

        // Add any remaining elements from nums1
        while nums1Index < nums1.count {
            mergedArray.append(nums1[nums1Index])
            nums1Index += 1
        }

        // Add any remaining elements from nums2
        while nums2Index < nums2.count {
            mergedArray.append(nums2[nums2Index])
            nums2Index += 1
        }

        return mergedArray
    }
}