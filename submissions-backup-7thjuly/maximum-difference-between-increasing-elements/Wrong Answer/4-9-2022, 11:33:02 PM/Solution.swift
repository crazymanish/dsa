// https://leetcode.com/problems/maximum-difference-between-increasing-elements

class Solution {
    // This question is same as:121. Best Time to Buy and Sell Stock
    // https://leetcode.com/problems/best-time-to-buy-and-sell-stock/
    // I just copy-paste code, not even change the pointer(s) name
    func maximumDifference(_ nums: [Int]) -> Int {
        var maxProfit = -1
        
        // Using two pointers 
        var buyPointer = 0
        var sellPointer = 1
        
        while sellPointer < nums.count {
            let buyPrice = nums[buyPointer]
            let sellPrice = nums[sellPointer]
            
            maxProfit = max(maxProfit, sellPrice-buyPrice)
            
            if sellPrice < buyPrice {
                buyPointer = sellPointer
            }
            
            sellPointer += 1
        }
        
        return maxProfit
    }
}