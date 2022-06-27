class Solution {
    func divideArray(_ nums: [Int]) -> Bool {
        let expectedPairsCount = nums.count / 2
        let sortedNums = nums.sorted()
        var outputPairsCount = 0
        
        var pairIndex = 0
        for index in 0..<expectedPairsCount {
            let firstElement = sortedNums[2*index]
            let secondElement = sortedNums[2*index+1]
            
            if firstElement == secondElement {
                outputPairsCount += 1 
            } else {
                break 
            }
            
            pairIndex += 1
        }
        
        return outputPairsCount == expectedPairsCount
    }
}