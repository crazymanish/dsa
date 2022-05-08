class Solution {
    func permute(_ nums: [Int]) -> [[Int]] {
        let lastIndex = nums.count-1
        var mutableNums = nums
        var allPermutations: [[Int]] = []
        var currentPermutation: [Int] = []
        
        func findPermutations(_ currentIndex: Int) {
            if currentIndex > lastIndex {
                allPermutations.append(currentPermutation)
                return
            }
            
            for permutationIndex in currentIndex...lastIndex {
                swap(currentIndex, permutationIndex)
                
                let currentIndexValue = mutableNums[currentIndex]
                currentPermutation.append(currentIndexValue)
                
                findPermutations(currentIndex+1)
                
                // backtracking
                swap(currentIndex, permutationIndex)
                currentPermutation.removeLast()
            }
        }
        
        func swap(_ firstIndex: Int, _ secondIndex: Int) {
            let temp = mutableNums[firstIndex]
            mutableNums[firstIndex] = mutableNums[secondIndex]
            mutableNums[secondIndex] = temp
        }
        
        findPermutations(0)
        return allPermutations
    }
}