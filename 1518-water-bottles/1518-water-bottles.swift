// Time Complexity: O(log_E N), where N is numBottles and E is numExchange.
// In each iteration, the number of empty bottles decreases significantly (roughly
// by a factor of `numExchange` - 1). This results in a logarithmic number of
// loops relative to the initial number of bottles.
//
// Space Complexity: O(1)
// The algorithm uses a fixed number of variables to track the state, so the
// space required is constant and does not depend on the input size.
class Solution {
    func numWaterBottles(_ numBottles: Int, _ numExchange: Int) -> Int {
        // `totalBottles` tracks the cumulative number of bottles we can drink.
        // It starts with the initial number of bottles.
        var totalBottles = numBottles
        // `emptyBottles` tracks the number of empty bottles we have for exchange.
        // Initially, this is equal to the starting number of bottles.
        var emptyBottles = numBottles

        // Loop as long as we have enough empty bottles to make an exchange.
        while emptyBottles >= numExchange {
            // Calculate how many new full bottles we can get.
            // Integer division (`/`) gives the number of full exchanges possible.
            let exchangedFullBottles = emptyBottles / numExchange
            
            // Add the newly exchanged bottles to our total count, as we will drink them.
            totalBottles += exchangedFullBottles
            
            // Update our count of empty bottles for the next iteration.
            // New empty bottles = (bottles from the exchange, now empty) + (leftover bottles).
            // The modulo operator (`%`) gives the leftover bottles that were not enough for a full exchange.
            emptyBottles = exchangedFullBottles + (emptyBottles % numExchange)
        }

        // Return the total count of bottles we were able to drink.
        return totalBottles
    }
}