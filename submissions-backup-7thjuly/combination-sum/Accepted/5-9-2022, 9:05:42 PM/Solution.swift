// https://leetcode.com/problems/combination-sum

class Solution {
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        let lastIndex = candidates.count-1
        
        var allCombinations: [[Int]] = []
        var currentCombination: [Int] = []
        var currentCombinationSum = 0

        func findCombinations(_ currentIndex: Int) {
            if currentCombinationSum == target {
                allCombinations.append(currentCombination)
                return
            }
            
            if currentCombinationSum > target { return }
            if currentIndex > lastIndex { return }

            // Choice1: Consider current index value for combination-sum
            let value = candidates[currentIndex]
                
            currentCombination.append(value)
            currentCombinationSum += value
                
            findCombinations(currentIndex)
                
            currentCombination.removeLast() // backtracking
            currentCombinationSum -= value // backtracking
                
            // Choice2: Ignore current index value for combination-sum
            findCombinations(currentIndex+1)
        }

        findCombinations(0)
        return allCombinations
    }
}
