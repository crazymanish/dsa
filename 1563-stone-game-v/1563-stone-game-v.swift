class Solution {
    func stoneGameV(_ stoneValue: [Int]) -> Int {
        func playStoneGame(_ startIndex: Int, _ endIndex: Int) -> Int {
            if startIndex > endIndex { return 0 }
            
            let cacheValue = dpCache[startIndex][endIndex]
            if cacheValue != -1 { return cacheValue }

            var totalValue = 0
            for index in startIndex...endIndex { totalValue += stoneValue[index] }

            var answer = 0
            var leftRowValue = 0
            var rightRowValue = totalValue
            for index in startIndex..<endIndex {
                leftRowValue += stoneValue[index]
                rightRowValue -= stoneValue[index]

                if leftRowValue < rightRowValue {
                    let possibleAnswer = leftRowValue + playStoneGame(startIndex, index)
                    answer = max(answer, possibleAnswer)
                } else if leftRowValue > rightRowValue {
                    let possibleAnswer = rightRowValue + playStoneGame(index+1, endIndex)
                    answer = max(answer, possibleAnswer)
                } else {
                    let leftAnswer = leftRowValue + playStoneGame(startIndex, index)
                    let rightAnswer = rightRowValue + playStoneGame(index+1, endIndex)
                    let possibleAnswer = max(leftAnswer, rightAnswer)
                    answer = max(answer, possibleAnswer)
                }
            }

            dpCache[startIndex][endIndex] = answer
            return answer
        }

        let stonesCount = stoneValue.count
        var dpCache = Array(repeating: Array(repeating: -1, count: stonesCount+1), count: stonesCount+1)
        
        return playStoneGame(0, stonesCount-1)
    }
}
