// https://leetcode.com/problems/intersection-of-two-arrays

class Solution {
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var hashMap: [Int : Bool] = [:]
        for num in nums1 { hashMap[num] = true }
        
        var outputHashMap: [Int: Bool] = [:]
        for num in nums2 { if hashMap[num] != nil { outputHashMap[num] = true } }
        
        return Array(outputHashMap.keys)
    }
}