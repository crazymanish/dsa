class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n), where n = nums.count
    ///     We compute one transformed value per index.
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     A new array is created to store the transformed values.
    ///
    /// Problem Summary:
    ///   For each index i, jump forward or backward by nums[i] steps
    ///   (with circular wrapping) and set the result at i to the value
    ///   found at the destination index.
    ///
    /// Key Insight:
    ///   Modulo arithmetic is used to wrap indices around the array.
    ///   Negative modulo results must be adjusted to stay within bounds.
    /// -----------------------------------------------------------------------
    func constructTransformedArray(_ nums: [Int]) -> [Int] {
        let count = nums.count
        var transformed = Array(repeating: 0, count: count)
        
        for index in 0..<count {
            // Raw movement (can be negative or overflow array bounds)
            let rawIndex = (index + nums[index]) % count
            
            // Adjust for negative modulo results
            let wrappedIndex = rawIndex < 0 ? rawIndex + count : rawIndex
            
            // Assign the value from the wrapped index
            transformed[index] = nums[wrappedIndex]
        }
        
        return transformed
    }
}
