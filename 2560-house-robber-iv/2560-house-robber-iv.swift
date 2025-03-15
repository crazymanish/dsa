class Solution {
    func minCapability(_ nums: [Int], _ k: Int) -> Int {
        var left = nums.min() ?? 0 // Initialize left to the minimum possible capability (min value in nums)
        var right = nums.max() ?? 0 // Initialize right to the maximum possible capability (max value in nums)

        // Nested function to check if we can rob at least 'k' houses with a given 'capability'
        func canRob(_ capability: Int) -> Bool {
            var count = 0 // Initialize the count of robbed houses
            var i = 0 // Initialize the index for iterating through nums

            // Iterate through the houses
            while i < nums.count {
                // If the current house's value is within the capability, rob it
                if nums[i] <= capability {
                    count += 1 // Increment the count of robbed houses
                    i += 2 // Skip the next house (cannot rob adjacent houses)
                } else {
                    i += 1 // Move to the next house
                }
                // If we have robbed at least 'k' houses, return true
                if count >= k {
                    return true
                }
            }

            // If we have not robbed at least 'k' houses, return false
            return false
        }

        // Perform binary search to find the minimum capability
        while left < right {
            let mid = left + (right - left) / 2 // Calculate the middle capability
            // If we can rob 'k' houses with the 'mid' capability, search for a smaller capability
            if canRob(mid) {
                right = mid
            } else {
                // If we cannot rob 'k' houses with the 'mid' capability, search for a larger capability
                left = mid + 1
            }
        }

        // Return the minimum capability
        return left
    }
}