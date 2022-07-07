// https://leetcode.com/problems/merge-sorted-array

class Solution {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var num1Index = 0
        var num2Index = 0
        
        while num2Index < n {
            let num1Value = nums1[num1Index]
            let num2Value = nums2[num2Index]

            if num1Value != 0 && num1Value < num2Value {
                num1Index += 1
            } else {
                nums1.insert(num2Value, at: num1Index)
                nums1.removeLast()
             
                num2Index += 1
            }
        }
    }
}