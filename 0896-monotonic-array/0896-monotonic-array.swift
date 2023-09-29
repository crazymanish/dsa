class Solution {
    func isMonotonic(_ nums: [Int]) -> Bool {
        var increasing = true
        var decreasing = true
        
        for i in 0..<(nums.count-1) {
            if nums[i] < nums[i+1] {
                decreasing = false
            }
            
            if nums[i] > nums[i+1] {
                increasing = false
            }
        }
        
        return increasing || decreasing
    }
}