class Solution {
    func numWays(_ words: [String], _ target: String) -> Int {
        let MOD = 1_000_000_007
        let (wordCount, targetCount) = (words[0].count, target.count)

        // 1. Create array of dictionaries to determine how many of a character
        // are at an index.
        var freq = Array(repeating: [Character: Int](), count: wordCount)
        for word in words {
            for (i, char) in word.enumerated() {
                freq[i][char, default: 0] += 1
            }
        }
        
        // 2. Initialize 2D dp array, setting the first column to 1. Here, dp[i][j]
        // should contain the number of ways that target[i] can be formed via
        // index j of all words.
        var dp = [[Int]](repeating: [Int](repeating: 0, count: targetCount+1), count: wordCount+1)
        for i in 0..<wordCount+1 { dp[i][0] = 1 }

        // 3. dp[i][j] = freq * dp[i-1][j-1] + dp[i-1][j]
        let targetArr = Array(target)
        for i in 1..<wordCount+1 {
            for j in 1..<targetCount+1 {
                let charFreq = freq[i-1][targetArr[j-1], default: 0]
                dp[i][j] = (charFreq * dp[i-1][j-1] + dp[i-1][j]) % MOD
            }
        }
        
        return dp[wordCount][targetCount]
    }
}