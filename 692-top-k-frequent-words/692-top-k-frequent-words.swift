class Solution {
    func topKFrequent(_ words: [String], _ k: Int) -> [String] {
        var hashMap: [String : Int] = [:]
        
        for word in words {
            hashMap[word, default: 0] += 1
        }
        
        let topFrequentWords: [String] = Array(hashMap.keys.sorted {
            let leftWordFrequency = hashMap[$0] ?? 0
            let rightWordFrequency = hashMap[$1] ?? 0
            
            if leftWordFrequency == rightWordFrequency {
                return $0 < $1
            } else {
                return leftWordFrequency > rightWordFrequency
            }
        })
    
        return Array(topFrequentWords.prefix(k))
    }
}