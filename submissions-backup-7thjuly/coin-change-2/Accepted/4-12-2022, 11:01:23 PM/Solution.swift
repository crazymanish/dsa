// https://leetcode.com/problems/coin-change-2

class Solution {
    // (Unbounded) Knapsack problem variation - Dynamic Programming
    func change(_ amount: Int, _ coins: [Int]) -> Int {
        guard amount > 0 else { return 1 } // Base case
        
        let coinsCount = coins.count
        var dpCache: [Int] = Array(repeating: 0, count: (amount + 1))
        dpCache[0] = 1 // Base case (If amount is 0)
        
        // https://www.geeksforgeeks.org/coin-change-dp-7/?ref=lbp
        for coin in coins {
            for currentAmount in 1...amount {
                if currentAmount >= coin {
                    dpCache[currentAmount] += dpCache[currentAmount-coin]   
                }
            }
        }

        return dpCache[amount]
    }
}