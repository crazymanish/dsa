/**
 * Primary idea: Dynamic Programming,  dp[amountIndex] += dp[amountIndex-coin]
 * Note: Loopo of coins should be outside to avoid duplicates
 * Time Complexity: O(n^2), Space Complexity: O(n)
 */
 class Solution {
    func change(_ amount: Int, _ coins: [Int]) -> Int {
        guard amount > 0 else { return 1 }
        
        var dp = [Int](repeating: 0, count: amount+1)
        dp[0] = 1
        
        for coin in coins {
            for amountIndex in 1...amount {
                if amountIndex >= coin {
                    dp[amountIndex] += dp[amountIndex-coin]
                }
            }
        }
        
        return dp[amount]
    }
}