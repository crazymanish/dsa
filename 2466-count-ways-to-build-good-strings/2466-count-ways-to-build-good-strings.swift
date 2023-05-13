/*
        zero = x, one = y, length = z
        only care about the number
        (x*) + (y*) = length

        xxxxxyyyyyyyy

        path: 0...high, count++ when >= low
        dp: number of compositions
        dp[path] = dp[path - x] + dp[path - y]
                   (take zero)    (take one)

        ex:
        zero: 1, one: 5, low: 10 high: 20
        dp: 01234567...10.....20
            0111123     ^: count from here

            "000000"
            "111110"
            "011111"
 */
class Solution {
    func countGoodStrings(_ low: Int, _ high: Int, _ zero: Int, _ one: Int) -> Int {
        var dp = [Int: Int]()
        var count = 0
        
        func countGoodStrings(_ pathCount: Int) {
            if pathCount == zero {
                dp[pathCount, default: 0] += 1
            }
            
            if pathCount == one {
                dp[pathCount, default: 0] += 1
            }
        
            dp[pathCount, default: 0] += dp[pathCount - zero, default: 0]
            dp[pathCount, default: 0] += dp[pathCount - one, default: 0]
            dp[pathCount, default: 0] %= 1000000007
        }
        
        
        for i in 0...high {
            countGoodStrings(i)
            
            if i >= low {
                count += dp[i]!
            }
        }
        
        return count % 1000000007
    }
}