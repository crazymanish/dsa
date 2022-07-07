// https://leetcode.com/problems/best-time-to-buy-and-sell-stock

class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        var minPrice = prices[0]
        var maxPrice = prices[0]
        
        for price in prices {
            if price < minPrice {
                minPrice = price
                maxPrice = price
            } else {
                maxPrice = max(maxPrice, price)
            }
        }
        
        return maxPrice - minPrice
    }
}