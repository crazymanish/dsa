// https://leetcode.com/problems/degree-of-an-array

class Solution {
    func findShortestSubArray(_ nums: [Int]) -> Int {
        var hashMap: [Int: ElementInfo] = [:]
        
        for (index, num) in nums.enumerated() {
            var hashMapValue = hashMap[num] ?? ElementInfo(index)
            hashMapValue.lastIndex = index
            hashMapValue.count = hashMapValue.count + 1
            
            hashMap[num] = hashMapValue
        }
        
        var maxCountKey = Int.min
        var hashMapCountLength: [Int : Int] = [:]
        for (_, value) in hashMap {
            let hashMapValue = hashMapCountLength[value.count] ?? Int.max
            hashMapCountLength[value.count] = min(hashMapValue, value.count)
            
            maxCountKey = max(maxCountKey, value.count)
        }
        
        return hashMapCountLength[maxCountKey] ?? 0
    }
}

class ElementInfo {
    let firstIndex: Int
    var lastIndex: Int
    var count: Int = 0
    
    var length: Int { lastIndex - firstIndex + 1 }
    
    init(_ firstIndex: Int) {
        self.firstIndex = firstIndex
        self.lastIndex = firstIndex
    }
}