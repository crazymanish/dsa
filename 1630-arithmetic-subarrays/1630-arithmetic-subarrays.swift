class Solution {
    func checkArithmeticSubarrays(_ nums: [Int], _ l: [Int], _ r: [Int]) -> [Bool] {
        func findArithmeticSlices(_ startIndex: Int, _ endIndex: Int) -> Bool {
            let numsCount = endIndex-startIndex
            
            guard numsCount > 0 else { return false }
            
            let sortedNums = nums[startIndex...endIndex].sorted()
            let expectedDiff = sortedNums[1] - sortedNums[0]
            
            for index in 1...numsCount {
                let diff = sortedNums[index] - sortedNums[index-1]
            
                if diff != expectedDiff { return false }
            }
        
            return true
        }
        
        var output: [Bool] = []
        for (index, lValue) in l.enumerated() {
            let rValue = r[index]
            
            let answer = findArithmeticSlices(lValue, rValue)
            output.append(answer)
        }
        
        return output
    }
}