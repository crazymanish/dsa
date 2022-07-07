// https://leetcode.com/problems/combination-sum-ii

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

/* Works but getting TLE
class Solution {
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        let lastIndex = candidates.count-1
        let sortedCandidates = candidates.sorted()
        
        var allCombinations: Set<[Int]> = []
        var currentCombination: [Int] = []
        var currentCombinationSum = 0

        func findCombinations(_ currentIndex: Int) {
            if currentCombinationSum == target {
                allCombinations.insert(currentCombination)
                return
            }
            
            if currentCombinationSum > target { return }
            if currentIndex > lastIndex { return }

            // Choice1: Consider current index value for combination-sum
            let value = sortedCandidates[currentIndex]
                
            currentCombination.append(value)
            currentCombinationSum += value
                
            findCombinations(currentIndex+1)
                
            currentCombination.removeLast() // backtracking
            currentCombinationSum -= value // backtracking
                
            // Choice2: Ignore current index value for combination-sum
            findCombinations(currentIndex+1)
        }

        findCombinations(0)
        return Array(allCombinations)
    }
}
*/