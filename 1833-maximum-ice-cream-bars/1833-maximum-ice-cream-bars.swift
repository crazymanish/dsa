class Solution {
    func maxIceCream(_ costs: [Int], _ coins: Int) -> Int {
        let sortedCosts = costs.sorted()
        var remainingCoins = coins
        var iceCreamCount = 0
        
        for cost in sortedCosts {
            if cost > remainingCoins { break }
            
            iceCreamCount += 1
            remainingCoins -= cost
        }
        
        return iceCreamCount
    }
}