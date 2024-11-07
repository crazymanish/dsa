class Solution {
    func largestCombination(_ candidates: [Int]) -> Int {
        var result = 0
        // Compute for each bit position the number of candidates
        // that have the bit set at that position.
        for i in 0..<24 {
            var count = 0
            
            for candidate in candidates {
                count += (candidate >> i) & 1
            }
            
            result = max(result, count)
        }
        return result
    }
}