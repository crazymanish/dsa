class Solution {
    func lengthOfLIS(_ nums: [Int]) -> Int {
        let numsCount = nums.count
        var dpCache = Array(repeating: 1, count: numsCount)
        
        for end in 1..<numsCount {
            for start in 0..<end {
                if nums[end] > nums[start] && dpCache[end] <= dpCache[start] {
                    dpCache[end] = dpCache[start] + 1
                }
            }
        }
        
        return dpCache.max() ?? 0
    }
}