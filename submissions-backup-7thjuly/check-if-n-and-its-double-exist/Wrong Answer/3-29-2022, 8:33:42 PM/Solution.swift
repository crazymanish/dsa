// https://leetcode.com/problems/check-if-n-and-its-double-exist

class Solution {
    func checkIfExist(_ arr: [Int]) -> Bool {
        var array = arr.sorted().reversed()
        var hashMap: [Int : Bool] = [:]
        
        for element in array {
            if hashMap[(element * 2)] != nil { 
                return true 
            } else {
                hashMap[element] = true
            }
        }
        
        return false
    }
}