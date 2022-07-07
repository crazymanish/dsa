// https://leetcode.com/problems/stone-game-v

class Solution {
    func stoneGameV(_ stoneValue: [Int]) -> Int {
        func playStoneGame(_ startIndex: Int, _ endIndex: Int, _ totalValue: Int) -> Int {
            if endIndex == startIndex { return 0 }

            var currentIndex = startIndex
            var leftRowValue = stoneValue[currentIndex]
            while currentIndex+1 < endIndex && leftRowValue + stoneValue[currentIndex+1] <= totalValue / 2  {
                leftRowValue += stoneValue[currentIndex+1]
                currentIndex += 1
            }

            let rightRowValue = totalValue-leftRowValue

            if leftRowValue < rightRowValue {
                return leftRowValue + playStoneGame(startIndex, currentIndex, leftRowValue)
            } else if leftRowValue > rightRowValue {
                return rightRowValue + playStoneGame(currentIndex+1, endIndex, rightRowValue)
            } else {
                let leftResult = leftRowValue + playStoneGame(startIndex, currentIndex, leftRowValue)
                let rightResult = rightRowValue + playStoneGame(currentIndex+1, endIndex, rightRowValue)
                return max(leftResult, rightResult)
            }
        }

        var totalValue = 0
        for value in stoneValue { totalValue += value }

        return playStoneGame(0, stoneValue.count-1, totalValue)
    }
}
