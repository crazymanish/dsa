// https://leetcode.com/problems/make-two-arrays-equal-by-reversing-sub-arrays

class Solution {
    func canBeEqual(_ target: [Int], _ arr: [Int]) -> Bool {
        var hashMap: [Int : Bool] = [:]
        
        for number in arr { hashMap[number] = true }
        
        var canBeEqual = true
        for number in target {
            if hashMap[number] == nil {
                canBeEqual = false
                break
            }
        }
        
        return canBeEqual
    }
}