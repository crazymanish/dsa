class Solution {
    func maxProductDifference(_ nums: [Int]) -> Int {
        let numsCount = nums.count
        let sortedNums = nums.sorted()
        
        let minPairValue = sortedNums[0] * sortedNums[1]
        let maxPairValue = sortedNums[numsCount-1] * sortedNums[numsCount-2]
        
        return maxPairValue - minPairValue
    }
}