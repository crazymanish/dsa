import Foundation

class Solution {
    func numMusicPlaylists(_ n: Int, _ goal: Int, _ k: Int) -> Int {
        let mod = Int(1e9 + 7)
        
        // songs "n" to form the "goal' playlist .
        var dp = [[Int]](repeating: .init(repeating: 0, count: goal + 1), count: n + 1)
        dp[0][0] = 1
        
        for goalIndex in 1...goal {
            for songIndex in 1...min(n, goalIndex) {
                // new song
                dp[songIndex][goalIndex] = dp[songIndex-1][goalIndex-1] * (n-(songIndex-1))
                
                // adding old songs, even though "k" should not be selected
                dp[songIndex][goalIndex] += dp[songIndex][goalIndex-1] * max(songIndex-k, 0) % mod
                dp[songIndex][goalIndex] %= mod
            }
        }
        
        return dp[n][goal]
    }
}