class Solution {
    func maxFrequencyElements(_ nums: [Int]) -> Int {
        let hashMap = nums.reduce(into: [:]) { counts, element in
            counts[element, default: 0] += 1
        }
        
        var result = 0
        if let maxFrequency = hashMap.values.max() {
            let maxFrequencyCount = hashMap.filter { $0.value == maxFrequency }.count
            
            result = maxFrequency * maxFrequencyCount
        }
        
        return result
    }
}