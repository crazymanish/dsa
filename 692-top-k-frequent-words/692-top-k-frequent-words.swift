class Solution {
    func topKFrequent(_ words: [String], _ k: Int) -> [String] {
        var hashMap: [String : Int] = [:]
        
        for word in words {
            hashMap[word, default: 0] += 1
        }
        
        let topFrequentWords: [String] = Array(hashMap.keys.sorted {
            let leftWordfrequency = hashMap[$0] ?? 0
            let rightWordfrequency = hashMap[$1] ?? 0
            
            if leftWordfrequency == rightWordfrequency {
                return $0 < $1
            } else {
                return leftWordfrequency > rightWordfrequency
            }
        })
    
        return Array(topFrequentWords.prefix(k))
    }
}