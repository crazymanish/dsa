class Solution {
    func putMarbles(_ weights: [Int], _ k: Int) -> Int {
        let n = weights.count
        
        if k == 1 || k == n { return 0 }

        var neighborSums: [Int] = (1..<n).map { weights[$0 - 1] + weights[$0] }
        
        if k == 2 || k == n-1 { return neighborSums.max()! - neighborSums.min()! }

        neighborSums.sort()
        
        var minScore = weights.first! + weights.last! 
        var maxScore = minScore
        
        for i in (n-k)..<(n-1) {
            maxScore += neighborSums[i]
        }
        
        for i in 0..<(k-1) {
            minScore += neighborSums[i]
        }

        return maxScore - minScore
    }
}