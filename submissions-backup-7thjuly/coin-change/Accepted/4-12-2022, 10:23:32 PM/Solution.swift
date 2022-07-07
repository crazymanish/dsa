// https://leetcode.com/problems/coin-change

class Solution {
    // (Unbounded) Knapsack problem variation - Dynamic Programming
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        let coinsCount = coins.count
        var dpCache: [Int] = Array(repeating: Int.max, count: (amount + 1))
        dpCache[0] = 0 // Base case (If amount is 0)
        
        if amount > 0 {
            for currentAmount in 1...amount {
                for coinIndex in 0..<coinsCount {
                    let currentCoin = coins[coinIndex]

                    if currentCoin <= currentAmount {
                        let possibleResult = dpCache[currentAmount-currentCoin]
                    
                        if possibleResult != Int.max && possibleResult+1 < dpCache[currentAmount] {
                            dpCache[currentAmount] = possibleResult+1
                        }
                    }
                }
            }
        }
        
        if dpCache[amount] == Int.max { return -1 }

        return dpCache[amount]
    }
}