// https://leetcode.com/problems/best-time-to-buy-and-sell-stock

class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        var maxProfit = 0
        
        // Using two pointers 
        var buyPointer = 0
        var sellPointer = 1
        
        while sellPointer < prices.count {
            let buyPrice = prices[buyPointer]
            let sellPrice = prices[sellPointer]
            
            maxProfit = max(maxProfit, sellPrice-buyPrice)
            
            if sellPrice < buyPrice {
                buyPointer = sellPointer
            }
            
            sellPointer += 1
        }
        
        return maxProfit
    }
}