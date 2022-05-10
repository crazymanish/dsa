class Solution {
    func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
        let candidates = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        let lastIndex = candidates.count-1
        
        var allCombinations: [[Int]] = []
        var currentCombination: [Int] = []
        var currentCombinationSum = 0
        
        func findCombinations(_ currentIndex: Int) {
            if currentCombinationSum == n && currentCombination.count == k {
                allCombinations.append(currentCombination)
                return
            }
            
            if currentIndex > lastIndex { return }

            for index in currentIndex...lastIndex {
                let value = candidates[index]
                
                // Not possible if sum is greater than target
                if currentCombinationSum+value > n { return } 
                
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