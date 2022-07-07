// https://leetcode.com/problems/top-k-frequent-words

class Solution {
    func topKFrequent(_ words: [String], _ k: Int) -> [String] {
        var hashMap: [String: (Int, Int)] = [:]
        
        var index = 0
        for word in words {
            let frequency = (hashMap[word]?.1 ?? 0) + 1
            let hashIndex = hashMap[word]?.0 ?? index
            hashMap[word] = (hashIndex, frequency)
            
            index += 1
        }
        
        var output: [(String, Int, Int)] = []
        var mutableK = k
        
        while (mutableK > 0)  {
            var key: String = ""
            var index = Int.min
            var frequency = Int.min
            
            for (key1, value) in hashMap {
                if value.1 > frequency  {
                    key = key1
                    index = value.0
                    frequency = value.1
                }
            }
            
            let item = (key, index, frequency)
            output.append(item)
            
            hashMap[key] = (0, 0)
            mutableK -= 1
        }
        
        return output
            .sorted(by: { 
                if $0.2 !=  $1.2 { return $0.2 > $1.2 }
                return $0.1 < $1.1
                })
            .map({ $0.0 })
    }
}