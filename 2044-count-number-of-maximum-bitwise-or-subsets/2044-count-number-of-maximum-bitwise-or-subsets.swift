class Solution {
    func countMaxOrSubsets(_ nums: [Int]) -> Int {
        let lastIndex = nums.count-1
        let maxOrValue = nums.orValue
        var outputCounter = 0
        var currentSubset: [Int] = []
        
        func findAllSubSets(_ currentIndex: Int) {
            if currentIndex > lastIndex { 
                if currentSubset.orValue == maxOrValue { outputCounter += 1 }
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
        
        return outputCounter
    }
}

private extension Array where Element == Int {
    var orValue: Int {
        var output = 0
        
        forEach { output |= $0 }
        
        return output
    }
}