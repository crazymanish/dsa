// https://leetcode.com/problems/coin-change-2

class Solution {
    // (Unbounded) Knapsack problem variation - Dynamic Programming
    func change(_ amount: Int, _ coins: [Int]) -> Int {
        let coinsCount = coins.count
        var dpCache: [Int] = Array(repeating: 0, count: (amount + 1))
        dpCache[0] = 1 // Base case (If amount is 0)
        
        // https://www.geeksforgeeks.org/coin-change-dp-7/?ref=lbp
        for coinIndex in 0..<coinsCount {
            let currentCoin = coins[coinIndex]
            for currentAmount in currentCoin...amount {
                dpCache[currentAmount] += dpCache[currentAmount-currentCoin]
            }
        }

        return dpCache[amount]
    }
}
