// https://leetcode.com/problems/make-two-arrays-equal-by-reversing-sub-arrays

class Solution {
    func canBeEqual(_ target: [Int], _ arr: [Int]) -> Bool {
        var hashMap: [Int : Int] = [:]
        
        for number in arr { 
            if let hashMapValue = hashMap[number] {
                hashMap[number] = hashMapValue + 1 
            } else {
                hashMap[number] = 1    
            }
        }
        
        var canBeEqual = true
        for number in target {
            if let hashMapValue = hashMap[number] {
                hashMap[number] = hashMapValue - 1
            } else {
                canBeEqual = false
                break            
            }
        }
        
        if canBeEqual {
            for (_, value) in hashMap {
                if value != 0 {
                    canBeEqual = false
                    break            
                }
            }
        }
        
        return canBeEqual
    }
}