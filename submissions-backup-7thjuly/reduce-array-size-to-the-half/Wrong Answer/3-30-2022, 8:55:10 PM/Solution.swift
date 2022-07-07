// https://leetcode.com/problems/reduce-array-size-to-the-half

class Solution {
    func minSetSize(_ arr: [Int]) -> Int {
        let arrayCount = arr.count
        var hashMap: [Int : Int] = [:]
        
        for element in arr {
            let hashMapValue = hashMap[element] ?? 0
            hashMap[element] = hashMapValue + 1
        }
        
        var modifiedArraySize = arrayCount
        var maximumFrequencyElementCount = 0
        
        while (modifiedArraySize > arrayCount / 2)  {
            var maximumFrequency = Int.min
            
            for (_, value) in hashMap {
                maximumFrequency = max(maximumFrequency, value)
            }
            
            maximumFrequencyElementCount += 1
            modifiedArraySize -= maximumFrequency
        }
        
        return maximumFrequencyElementCount
    }
}