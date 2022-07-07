// https://leetcode.com/problems/4sum-ii

class Solution {
    func fourSumCount(_ nums1: [Int], _ nums2: [Int], _ nums3: [Int], _ nums4: [Int]) -> Int {
        var output: Int = 0
        var hashMap: [Int : Int] = [:]
        
        for firstNum in nums1 {
            for secondNum in nums2 {
                let sum = firstNum + secondNum
                
                let hashMapValue = hashMap[sum] ?? 0 
                hashMap[sum] = hashMapValue + 1
            }
        }
        
        for thirdNum in nums3 {
            for forthNum in nums4 {
                let sum = -(thirdNum + forthNum)
                
                if let hashMapValue = hashMap[sum] {
                    output += hashMapValue
                }
            }
        }

        return output
    }
}