class Solution {
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        if nums.count < 3 { return 0 }
        
        let nums = nums.sorted()
        let count = nums.count
        
        var result = nums[0] + nums[1] + nums[count - 1]
        var left = 0
        var right = 0
        var sum = 0
        
        for i in 0..<(count - 2) {
            left = i + 1
            right = count - 1
            
            while left < right {
                sum = nums[i] + nums[left] + nums[right]
                
                if sum > target {
                    right -= 1
                } else {
                    left += 1
                }
                
                if abs(sum - target) < abs(result - target) {
                    result = sum
                }
            }
        }
        
        return result
    }
}