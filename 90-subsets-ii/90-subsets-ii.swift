class Solution {
    // This is extension of:
    // 78. Subsets: https://leetcode.com/problems/subsets/
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        let lastIndex = nums.count-1
        let sortedNums = nums.sorted()
        
        // Using Set instead of array to avoid duplicate insert
        var allSubsets: Set<[Int]> = []
        var currentSubset: [Int] = []
        
        func findAllSubsets(_ currentIndex: Int) {
            if currentIndex > lastIndex {
                allSubsets.insert(currentSubset)
                return
            }
            
            let currentIndexValue = sortedNums[currentIndex]
            // We always have two choices:
            // Choice1: don't aad this value into currentSubset
            // Choice2: add this value intocurrentSubset
            
            // Choice1: don't aad this value into currentSubset
            findAllSubsets(currentIndex+1)
            
            // Choice2:add this value into currentSubset
            currentSubset += [currentIndexValue]
            findAllSubsets(currentIndex+1)
            currentSubset.removeLast() // backtracking
        }
        
        findAllSubsets(0)
        return Array(allSubsets)
    }
}