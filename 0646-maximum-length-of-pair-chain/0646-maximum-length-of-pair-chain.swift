class Solution {
    func findLongestChain(_ pairs: [[Int]]) -> Int {
        let sortedPairs = pairs.sorted { $0[1] < $1[1] }
        var longestChainCount = 0
        var currentHighest = Int.min
        
        for pair in sortedPairs {
            if pair[0] > currentHighest {
                longestChainCount += 1
                currentHighest = pair[1]
            }
        }
        
        return longestChainCount
    }
}