// https://leetcode.com/problems/4sum-ii

class Solution {
    func fourSumCount(_ nums1: [Int], _ nums2: [Int], _ nums3: [Int], _ nums4: [Int]) -> Int {
        var output: Int = 0
        
        var array1 = nums1.sorted()
        var array2 = nums2.sorted()
        var array3 = nums3.sorted()
        var array4 = nums4.sorted()

        for firstNumIndex in 0..<array1.count {
            for secondNumIndex in 0..<array2.count {
                for thirdNumIndex in 0..<array3.count {
                    for forthNumIndex in 0..<array4.count {
                        if (array1[firstNumIndex] + 
                            array2[secondNumIndex] + 
                            array3[thirdNumIndex] + 
                            array4[forthNumIndex] == 0) {       
                            output += 1
                        }
                    }
                }
            }
        }

        return output
    }
}