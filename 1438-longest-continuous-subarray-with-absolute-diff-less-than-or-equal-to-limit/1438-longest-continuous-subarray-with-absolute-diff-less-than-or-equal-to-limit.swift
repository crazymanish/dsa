class Solution {
    func longestSubarray(_ nums: [Int], _ limit: Int) -> Int {
        // Deques to keep track of the maximum and minimum elements in the current window
        var maxDeque = [Int]()
        var minDeque = [Int]()
        var left = 0
        var right = 0
        
        for right in 0..<nums.count {
            // Maintain the decreasing order in maxDeque
            while !maxDeque.isEmpty && nums[right] > maxDeque.last! {
                maxDeque.removeLast()
            }
            maxDeque.append(nums[right])
            
            // Maintain the increasing order in minDeque
            while !minDeque.isEmpty && nums[right] < minDeque.last! {
                minDeque.removeLast()
            }
            minDeque.append(nums[right])
            
            // If the difference between the max and min elements exceeds the limit, shrink the window from the left
            if maxDeque.first! - minDeque.first! > limit {
                if maxDeque.first! == nums[left] {
                    maxDeque.removeFirst()
                }
                if minDeque.first! == nums[left] {
                    minDeque.removeFirst()
                }
                left += 1
            }
        }
        
        // Return the size of the largest subarray with absolute difference less than or equal to the limit
        return nums.count - left
    }
}