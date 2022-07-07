// https://leetcode.com/problems/divide-array-in-sets-of-k-consecutive-numbers

class Solution {
    func isPossibleDivide(_ nums: [Int], _ k: Int) -> Bool {
        var hashMap: [Int: Int] = [:]
        for num in nums {
            let hashMapValue = hashMap[num] ?? 0
            hashMap[num] = hashMapValue + 1
        }
        
        var sortedNums = nums.sorted()
        
        for num in sortedNums {
            if let hashMapValue = hashMap[num], hashMapValue > 0 {
                for consecutiveNum in num..<(num+k) {
                    let consecutiveHashMapValue = hashMap[consecutiveNum] ?? 0
                    hashMap[consecutiveNum] = consecutiveHashMapValue - hashMapValue
                    
                    if hashMap[consecutiveNum]! < 0 { return false }
                }
            }
        }
        
        return true
    }
}