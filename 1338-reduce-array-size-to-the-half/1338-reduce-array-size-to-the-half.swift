class Solution {
    func minSetSize(_ arr: [Int]) -> Int {
        var frequencyHashMap: [Int : Int] = [:]
        
        for element in arr {
            frequencyHashMap[element, default: 0] += 1
        }
        
        // frequencyHashMap:  [3: 4, 5: 3, 7: 1, 2: 2]
        // Sorted frequencyHashMap: [(key: 3, value: 4), (key: 5, value: 3), (key: 2, value: 2), (key: 7, value: 1)]
        let sortedByValueFrequencyHashMap = frequencyHashMap.sorted { $0.1 > $1.1 }
        
        var frequencyCount = 0
        var minSetSize = 0
        for (_, value) in sortedByValueFrequencyHashMap {
            frequencyCount += value
            minSetSize += 1
            
            if frequencyCount >= arr.count/2 { break }
        }
        
        return minSetSize
    }
}