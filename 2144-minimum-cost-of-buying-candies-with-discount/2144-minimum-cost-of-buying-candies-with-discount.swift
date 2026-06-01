class Solution {
    /**
     Problem Summary:
     Given the costs of candies, buy candies using the offer:
     for every 3 candies bought, the cheapest one is free.
     Return the minimum total cost.

     Strategy:
     Sort candies in descending order.
     For every group of 3 candies, pay for the two most expensive candies
     and skip the third one because it is free.

     Time Complexity: O(n log n), where n is the number of candies.
     Space Complexity: O(n), because sorting creates a new array.
     */
    func minimumCost(_ cost: [Int]) -> Int {
        let sortedCosts = cost.sorted(by: >)
        var totalCost = 0

        for index in 0..<sortedCosts.count {
            // Every third candy in descending order is free.
            // Example group: [high, medium, low] -> pay high + medium, skip low.
            if (index + 1) % 3 == 0 {
                continue
            }

            totalCost += sortedCosts[index]
        }

        return totalCost
    }
}