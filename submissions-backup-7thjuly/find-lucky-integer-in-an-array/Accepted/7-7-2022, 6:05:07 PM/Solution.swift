// https://leetcode.com/problems/find-lucky-integer-in-an-array

class Solution {
    func findLucky(_ nums: [Int]) -> Int {
        var hashMap: [Int : Int] = [:]
        
        for num in nums {
            let hashMapValue = hashMap[num] ?? 0
            hashMap[num] = hashMapValue + 1
        }
        
        var luckyNumber = -1
        for (key, value) in hashMap {
            if key == value { luckyNumber = max(luckyNumber, value) }
        }
        
        return luckyNumber
    }
}