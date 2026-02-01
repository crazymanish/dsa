class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n), where n = nums.count
    ///     We scan the array once.
    ///
    /// Space Complexity:
    ///   • O(1)
    ///     Only constant extra variables are used.
    ///
    /// Problem Summary:
    ///   We must choose three elements:
    ///     - nums[0]
    ///     - two other elements from indices [1...n-1]
    ///   such that their sum is minimized.
    ///
    /// Approach:
    ///   - nums[0] is fixed and must be included.
    ///   - Find the two smallest values in nums[1...].
    ///   - Add them to nums[0].
    /// -----------------------------------------------------------------------
    func minimumCost(_ nums: [Int]) -> Int {
        // Track the two smallest values after index 0
        var smallest = Int.max
        var secondSmallest = Int.max
        
        // Scan elements starting from index 1
        for index in 1..<nums.count {
            let value = nums[index]
            
            if value < smallest {
                secondSmallest = smallest
                smallest = value
            } else if value < secondSmallest {
                secondSmallest = value
            }
        }
        
        // nums[0] must always be included
        return nums[0] + smallest + secondSmallest
    }
}
