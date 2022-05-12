class Solution {
    func subsetXORSum(_ nums: [Int]) -> Int {
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
        
        var outputSum = 0
        for subset in allSubsets {
            outputSum += subset.xorValue
        }
        
        return outputSum
    }
}

private extension Array where Element == Int {
    var xorValue: Int {
        var output = 0
        
        forEach { output ^= $0 }
        
        return output
    }
}