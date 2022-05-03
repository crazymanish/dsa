class Solution {
    func maxProfit(_ prices: [Int], _ fee: Int) -> Int {
        var minBuyPrice = prices[0]
        var maxProfit = 0
        
        for index in 1..<prices.count {
            let todayPrice = prices[index]
            
            let todayBuyPrice = todayPrice - maxProfit
            let todaySellProfit = todayPrice - minBuyPrice - fee
            
            minBuyPrice = min(minBuyPrice, todayBuyPrice)
            maxProfit = max(maxProfit, todaySellProfit)
        }
        
        return maxProfit
    }
}