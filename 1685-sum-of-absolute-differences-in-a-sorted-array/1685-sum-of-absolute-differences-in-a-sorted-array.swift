class Solution {
    func getSumAbsoluteDifferences(_ nums: [Int]) -> [Int] {
        let totalSum = nums.reduce(0, +)
        var leftSum = 0
        var result: [Int] = []
        
        for (index, value) in nums.enumerated() {
            result.append(totalSum - 2*leftSum - value*(nums.count - 2*index))
            leftSum += value
        }
        
        return result
    }
}