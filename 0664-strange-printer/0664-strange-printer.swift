/*
. Create a 2D array
. Loop through the array and set the diagonal to 1
. If the character at i and j is the same, then set the value to the value of the cell at i, j-1
. If the characters are not the same, then set the value to the minimum of the values at i, k + the value at k+1, j
. Return the value at 0, s.count-1
*/
class Solution {
    func strangePrinter(_ s: String) -> Int {
        let s = Array(s)
        var dp = Array(repeating: Array(repeating: 0, count: s.count), count: s.count)
        
        for i in (0..<s.count).reversed() {
            dp[i][i] = 1
            
            for j in (i+1)..<s.count {
                if s[i] == s[j] {
                    dp[i][j] = dp[i][j-1]
                    continue
                }
                
                var minimum = Int.max
                for k in i..<j {
                    minimum = min(minimum, dp[i][k] + dp[k+1][j])
                }
                
                dp[i][j] = minimum
            }
        }
        
        return dp[0][s.count-1]       
    }
}