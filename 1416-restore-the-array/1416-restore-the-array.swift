class Solution {
    func numberOfArrays(_ s: String, _ k: Int) -> Int {
        guard s.count > 0 else { return 0 }
        
        let sInts = s.compactMap { $0.wholeNumberValue }
        guard sInts.last! <= k else { return 0 }
        
        var dp = Array(repeating: 0, count: s.count)

        for i in (0..<(sInts.count)).reversed() {
            if sInts[i] == 0 { continue }
            
            var n = 0
            for j in (i..<sInts.count) {
                n = 10 * n + sInts[j]
                if n > k { break }
                
                if j == sInts.count - 1 {
                    dp[i] += 1
                } else {
                    dp[i] += dp[j+1]
                }
                
                dp[i] %= 1000000007
            }
        }
        
        return dp[0]
    }
}

/* Time Limit Exceeded
class Solution {
    func numberOfArrays(_ s: String, _ k: Int) -> Int {
        let sInts = s.compactMap { $0.wholeNumberValue }
        var dp = [Int](repeating: -1, count: s.count)
        
        func dfs(_ i: Int) -> Int {
            if i == s.count { return 1 }
            if sInts[i] == 0 { return 0 }
            if dp[i] != -1 { return dp[i] }

            var ans = 0
            var num = 0
            for j in i..<s.count {
                num = num * 10 + sInts[j]
                if num > k { break }
                ans = (ans + dfs(j + 1)) % 1000000007
            }
            dp[i] = ans
            return ans
        }
        
        return dfs(0)
    }
}
*/