class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        var minBuyPrice = prices[0]
        var maxProfit = 0
        var coolDownProfit = 0
        
        for index in 1..<prices.count {
            let todayPrice = prices[index]
            
            let todayBuyPrice = todayPrice - coolDownProfit
            let todaySellProfit = todayPrice - minBuyPrice
            let todayCoolDownProfit = maxProfit
            
            minBuyPrice = min(minBuyPrice, todayBuyPrice)
            maxProfit = max(maxProfit, todaySellProfit)
            coolDownProfit = max(coolDownProfit, todayCoolDownProfit)
        }
        
        return maxProfit
    }
}