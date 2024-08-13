class Solution {
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        let lastIndex = candidates.count-1
        let sortedCandidates = candidates.sorted()    
        
        var allCombinations: [[Int]] = []
        var currentCombination: [Int] = []
        var currentCombinationSum = 0
        
        func findCombinations(_ currentIndex: Int) {
            if currentCombinationSum == target {
                allCombinations.append(currentCombination)
                return
            }
            
            if currentIndex > lastIndex { return }

            for index in currentIndex...lastIndex {
                let value = sortedCandidates[index]
                
                if currentCombinationSum+value > target { return } // Not possible if sum is greater than target
                if index > 0, index != currentIndex, value == sortedCandidates[index-1] { continue } // Skip duplicate
                
                currentCombination.append(value)
                currentCombinationSum += value
                
                findCombinations(index+1)
                
                currentCombination.removeLast() // backtracking
                currentCombinationSum -= value // backtracking
            }
        }    
        
        findCombinations(0)
        return allCombinations
    }
}