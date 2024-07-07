class Solution {
    func numWaterBottles(_ numBottles: Int, _ numExchange: Int) -> Int {
        var totalBottles = numBottles
        var emptyBottles = numBottles

        while emptyBottles >= numExchange {
            let exchangedFullBottles = emptyBottles / numExchange
            totalBottles += exchangedFullBottles
            emptyBottles = exchangedFullBottles + (emptyBottles % numExchange)
        }

        return totalBottles
    }
}
