// Time Complexity: O(N), where N is the number of exchanges performed.
// The while loop runs once for each successful exchange. The number of possible exchanges
// is related to the initial number of bottles, but since the exchange cost increases,
// the loop terminates reasonably quickly. An O(numBottles) upper bound is safe.
//
// Space Complexity: O(1)
// The algorithm uses a fixed number of variables, so the space required is constant.
class Solution {
    func maxBottlesDrunk(_ numBottles: Int, _ numExchange: Int) -> Int {
        // Create a mutable copy of the exchange rate, as it increases with each exchange.
        var numExchange = numExchange
        // `result` tracks the total bottles drunk, starting with the initial set.
        var result = numBottles
        // `emptyBottle` tracks the number of empty bottles available.
        var emptyBottle = numBottles
        // `fullBottle` is a temporary counter for bottles gained from exchanges.
        var fullBottle = 0

        // Loop as long as we have enough empty bottles to afford the current exchange rate.
        while emptyBottle >= numExchange {
            // Perform one exchange: gain one full bottle.
            fullBottle += 1
            // Spend the required number of empty bottles.
            emptyBottle -= numExchange
            // The cost for the *next* exchange increases by one.
            numExchange += 1
            
            // This condition checks if it's a good time to "drink" the accumulated
            // full bottles. It does this by seeing if the resulting empty bottles
            // would be enough for the next, more expensive exchange.
            if (fullBottle + emptyBottle) >= numExchange {
                // "Drink" the accumulated full bottles, adding them to the total count.
                result += fullBottle
                // The newly drunk bottles now become empty bottles.
                emptyBottle += fullBottle
                // Reset the temporary counter.
                fullBottle = 0
            }
        }
        // After the loop, add any remaining `fullBottle`(s) that were exchanged but
        // not yet counted in the `if` block during the final iterations.
        result += fullBottle
        return result
    }
}