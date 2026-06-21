class Solution {
    /**
     Problem Summary:
     Buy the maximum number of ice cream bars with the given number of coins.

     Strategy:
     Sort costs in ascending order and greedily buy the cheapest bars first.
     This maximizes the count because cheaper bars leave more coins for future purchases.

     Time Complexity: O(n log n), where n is the number of costs.
     Space Complexity: O(n), due to sorting.
     */
    func maxIceCream(_ costs: [Int], _ coins: Int) -> Int {
        let sortedCosts = costs.sorted()
        var remainingCoins = coins
        var purchasedCount = 0

        for cost in sortedCosts {
            // Stop once the next cheapest bar is too expensive.
            guard cost <= remainingCoins else { break }

            remainingCoins -= cost
            purchasedCount += 1
        }

        return purchasedCount
    }
}