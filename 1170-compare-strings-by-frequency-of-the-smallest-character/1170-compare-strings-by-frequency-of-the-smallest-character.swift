class Solution {
    func numSmallerByFrequency(_ queries: [String], _ words: [String]) -> [Int] {
        let queriesCounts = queries.map{ f($0) }
        let wordsCounts = words.map{ f($0) }.sorted()
        
        return queriesCounts.map{ 
            binarySearch($0, wordsCounts) 
        }
    }
    
    func f(_ s: String) -> Int {
        var counts:[Int] = Array(repeating: 0, count: 26)
        
        for c in s {
             let index = Int(c.asciiValue! - Character("a").asciiValue!)
             counts[index] += 1
        }
        
        return counts.first{ $0 > 0 } ?? 0
    }
    
    func binarySearch(_ f: Int, _ sortedWordsFrequency: [Int]) -> Int {
        var l = 0
        var r = sortedWordsFrequency.count
        
        while l < r {
            let m = l + (r - l) / 2
            if sortedWordsFrequency[m] > f {
                r = m
            } else {
                l = m + 1
            }
        }
        
        return sortedWordsFrequency.count - l
    }
}