class Solution {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var hashMap: [Int : Int] = [:]
        
        for num in nums {
            hashMap[num, default: 0] += 1
        }
        
        let topFrequentNums = Array(hashMap.keys.sorted {
            let leftNumFrequency = hashMap[$0] ?? 0
            let rightNumFrequency = hashMap[$1] ?? 0
            
            if leftNumFrequency == rightNumFrequency {
                return $0 < $1
            } else {
                return leftNumFrequency > rightNumFrequency
            }
        })
    
        return Array(topFrequentNums.prefix(k))
    }
}