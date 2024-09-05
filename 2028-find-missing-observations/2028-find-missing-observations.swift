class Solution {
    func missingRolls(_ rolls: [Int], _ mean: Int, _ n: Int) -> [Int] {
        let numbersCount = rolls.count + n
        let currentSum = rolls.reduce(0, +)
        let missingSum = (numbersCount * mean) - currentSum
        
        if missingSum > 6 * n || missingSum < n { return [] }
        
        var missingItems: [Int] = Array(repeating: 1, count: n)
        var currentMissingSum = missingItems.reduce(0, +)
        for i in 0..<missingItems.count {
            while missingItems[i] < 6 && currentMissingSum < missingSum {
                missingItems[i] += 1
                currentMissingSum += 1
            }
        }
        
        return missingItems
    }
}