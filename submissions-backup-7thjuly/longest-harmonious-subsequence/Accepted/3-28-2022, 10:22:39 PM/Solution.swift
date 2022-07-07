// https://leetcode.com/problems/longest-harmonious-subsequence

class Solution {
    func findLHS(_ nums: [Int]) -> Int {
        var hashMap: [Int : Int] = [:]
        
        for num in nums {
            let hashMapValue = hashMap[num] ?? 0
            hashMap[num] = hashMapValue + 1
        }
        
        var outputResult = 0
        
        for (key, value) in hashMap {
            if let plusOneValue = hashMap[key+1] {
                let result = value + plusOneValue
                outputResult = max(outputResult, result)
            }
        }
        
        return outputResult
    }
}