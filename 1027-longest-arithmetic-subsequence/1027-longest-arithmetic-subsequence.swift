class Solution {
    func longestArithSeqLength(_ A: [Int]) -> Int {
        var n = A.count 
        var dp = Array(repeating: [Int: Int](), count: n)
        var result = 0
        
        for i in 1..<A.count {
            for j in (0...i-1).reversed() {
                let diff = A[j] - A[i]
                
                if dp[i][diff] == nil {
                    dp[i][diff] = 2
                }
                
                if let val = dp[j][diff] {
                    dp[i][diff] = max(dp[i][diff]!, val+1)
                }
                
                result = max(result, dp[i][diff]!)
            }
        }
        
        return result
    }
}