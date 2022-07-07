// https://leetcode.com/problems/top-k-frequent-elements

class Solution {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var hashMap: [Int: Int] = [:]
        for num in nums { hashMap[num] = (hashMap[num] ?? 0) + 1 }
        
        var output: [Int] = []
        var mutableK = k
        
        while (mutableK > 0)  {
            var maximumFrequencyKey: Int = Int.min
            var maximumFrequency = Int.min
            
            for (key, value) in hashMap {
                if value > maximumFrequency {
                    maximumFrequencyKey = key
                    maximumFrequency = value
                }
            }
            
            output.append(maximumFrequencyKey)
            
            hashMap[maximumFrequencyKey] = 0
            mutableK -= 1
        }
        
        return output
    }
}