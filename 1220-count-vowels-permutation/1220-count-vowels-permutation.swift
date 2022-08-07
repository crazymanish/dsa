class Solution {
    func countVowelPermutation(_ n: Int) -> Int {
        let vowelsCount = 5 
        let rules: [Int: [Int]] = [
            0: [1], // a followed by e
            1: [0, 2], // e followed by a, i
            2: [0, 1, 3, 4], // i followed by all except i
            3: [2, 4], // o followed by i, u
            4: [0] // u followed by a
        ]
        let mod = 1_000_000_007
        let emptyArray: [Int] = []
        
        var dp = Array(repeating: 1, count: vowelsCount)
        
        for _ in 1..<n {
            var newDp = Array(repeating: 0, count: vowelsCount)
            
            for j in 0..<vowelsCount {
                for rule in rules[j, default: emptyArray] {
                    newDp[j] += dp[rule] % mod
                }
            }
            
            dp = newDp
        }
        
        return dp.reduce(0, +) % mod
    }
}