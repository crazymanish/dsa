// https://leetcode.com/problems/number-of-good-pairs

class Solution {
    func numIdenticalPairs(_ nums: [Int]) -> Int {
        typealias ValueTimesMap = [Int : Int]
        var hashMap: ValueTimesMap = [:]
        
        for num in nums {
            if let existingHashMapValue = hashMap[num] {
                hashMap[num] = existingHashMapValue + 1
            } else {
                hashMap[num] = 1   
            }
        }
        
        var maximumPairs = 0
        for (key, value) in hashMap {
            maximumPairs += value * (value - 1)
        }
        
        return maximumPairs / 2
    }
}