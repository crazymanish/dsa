class Solution {
    func subsets(_ nums: [Int]) -> [[Int]] {
        let lastIndex = nums.count-1
        var allSubsets: [[Int]] = [[]]
        
        func findAllSubSets(_ currentIndex: Int) {
            if currentIndex > lastIndex { return }
            
            let currentIndexValue = nums[currentIndex]
            // We always have two choices:
            // Choice1: don't aad this value into current-set 
            // Choice2: add this value into current-set
            
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