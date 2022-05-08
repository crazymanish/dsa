class Solution {
    func subsets(_ nums: [Int]) -> [[Int]] {
        let lastIndex = nums.count-1
        var allSubsets: [[Int]] = []
        var currentSubset: [Int] = []
        
        func findAllSubSets(_ currentIndex: Int) {
            if currentIndex > lastIndex { 
                allSubsets.append(currentSubset)
                return 
            }
            
            let currentIndexValue = nums[currentIndex]
            // We always have two choices:
            // Choice1: don't aad this value into currentSubset
            // Choice2: add this value intocurrentSubset
            
            // Choice1: don't aad this value into currentSubset
            findAllSubSets(currentIndex+1)
            
            // Choice2:add this value into currentSubset
            currentSubset += [currentIndexValue]
            findAllSubSets(currentIndex+1)
            currentSubset.removeLast() // backtracking
        }
        
        findAllSubSets(0)
        return allSubsets
    }
}

/*
class Solution {
    func subsets(_ nums: [Int]) -> [[Int]] {
        let lastIndex = nums.count-1
        var allSubsets: [[Int]] = [[]]
        
        func findAllSubSets(_ currentIndex: Int) {
            if currentIndex > lastIndex { return }
            
            let currentIndexValue = nums[currentIndex]
            
            for index in 0..<allSubsets.count {
                let subset = allSubsets[index]
                let newSubset = subset + [currentIndexValue]
                allSubsets.append(newSubset)
            }
            
            findAllSubSets(currentIndex+1)
        }
        
        findAllSubSets(0)
        return allSubsets
    }
}
*/