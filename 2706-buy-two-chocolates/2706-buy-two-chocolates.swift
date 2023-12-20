class Solution {
    func buyChoco(_ prices: [Int], _ money: Int) -> Int {
        var firstMin = Int.max
        var secondMin = Int.max

        for price in prices where price < secondMin {
            if price < firstMin {
                (firstMin, secondMin) = (price, firstMin)
            } else {
                secondMin = price
            }
        }

        let result = money - firstMin - secondMin

        if result >= 0 { return result }

        return money
    }
}