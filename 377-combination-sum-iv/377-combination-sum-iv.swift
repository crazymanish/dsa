class Solution {
    func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
        var dpCache = Array(repeating: -1, count: target+1)
        dpCache[0] = 1
        
        func findCombinationSum(_ target: Int) -> Int {
            if (dpCache[target] != -1) { return dpCache[target] }
            
            var combinationSum = 0
            for index in 0..<nums.count {
                let currentNumber = nums[index]
                if (target >= currentNumber) {
                    combinationSum += findCombinationSum(target - currentNumber)
                }
            }
            
            dpCache[target] = combinationSum
            return combinationSum
        }

        return findCombinationSum(target)
    }
}
