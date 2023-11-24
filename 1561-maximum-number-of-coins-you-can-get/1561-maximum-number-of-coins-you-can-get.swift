class Solution {
    func maxCoins(_ piles: [Int]) -> Int {
        let sortedPiles = piles.sorted(by: >)
        var leftIndex = 0
        var rightIndex = sortedPiles.count-1
        var sum = 0

        while leftIndex < rightIndex-1 {
            sum += sortedPiles[leftIndex+1]

            leftIndex += 2
            rightIndex -= 1
        }

        return sum
    }
}