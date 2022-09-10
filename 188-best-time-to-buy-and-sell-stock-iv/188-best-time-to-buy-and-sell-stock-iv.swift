class Solution {
    func maxProfit(_ k: Int, _ prices: [Int]) -> Int {
        let tradeCount: Int = k
        
        if prices.count <= 0 { return 0 }
        if tradeCount <= 0 { return 0 }
        
        if tradeCount >= (prices.count / 2 + 1) {
            var result: Int = 0
            var day: Int = 1
            
            while day < prices.count {
                var amount = prices[day] - prices[day - 1]
                if amount > 0 { result += amount }
                day += 1
            }
            
            return result
        }
        
        var dpCache = Array(repeating: Array(repeating:0, count: tradeCount + 1), count: prices.count + 1)
        
        var trade: Int = 1
        var day: Int = 1
        
        while trade <= tradeCount {
            day = 1
            var maxEarn: Int = -prices[0]
            
            while day <= prices.count {
                dpCache[day][trade] = max(dpCache[day-1][trade], prices[day-1] + maxEarn)
                maxEarn = max(maxEarn, dpCache[day-1][trade-1] - prices[day-1])
                day += 1
            }
            
            trade += 1
        }
        
        return dpCache[prices.count][tradeCount]
    }
}