class Solution {
    func maximumScore(_ nums: [Int], _ multipliers: [Int]) -> Int {
        let n = nums.count
        let m = multipliers.count
        var dpCache = Array(repeating: Array(repeating: Int.min, count: m), count: m)
        
        func helper(_ left: Int, _ right: Int) -> Int {
            if left + right >= m { return 0 }
            
            let cacheResult = dpCache[left][right]
            if cacheResult != Int.min { return cacheResult }
            
            let result = max(nums[left] * multipliers[left + right] + helper(left + 1, right), 
                             nums[n - 1 - right] * multipliers[left + right] + helper(left, right + 1))
            dpCache[left][right] = result
            return result
        }
        
        return helper(0, 0)
    }
}