class Solution {
    func stoneGameVIII(_ stones: [Int]) -> Int {        
        var prefixSumStones: [Int] = []
        var prefixSum = 0
        for value in stones {
            prefixSum += value
            prefixSumStones.append(prefixSum)
        }
        
        let lastIndex = stones.count-1
        var answer = prefixSumStones[lastIndex]
        for index in (1..<lastIndex).reversed() {
            let possibleAnswer = prefixSumStones[index] - answer
            answer = max(answer, possibleAnswer)
        }
        
        return answer
    }
}