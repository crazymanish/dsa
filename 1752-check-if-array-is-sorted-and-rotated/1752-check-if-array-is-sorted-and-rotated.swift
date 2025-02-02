class Solution {
    func check(_ nums: [Int]) -> Bool {
        // Initialize the count of order violations
        var orderViolations = 0
        
        // Traverse the array to count the order violations
        for i in 0..<nums.count {
            // Compare the current element with the next element (using modulo for circular comparison)
            if nums[i] > nums[(i + 1) % nums.count] {
                orderViolations += 1
            }
            
            // If there is more than one order violation, return false
            if orderViolations > 1 { return false }
        }
        
        // If there is at most one order violation, return true
        return true
    }
}