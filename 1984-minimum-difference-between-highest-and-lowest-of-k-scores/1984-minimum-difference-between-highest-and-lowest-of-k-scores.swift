class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n log n)
    ///     - Sorting the array dominates.
    ///     - Sliding window traversal is O(n).
    ///
    /// Space Complexity:
    ///   • O(1) extra space
    ///     - Ignoring sorting space.
    ///
    /// Problem Summary:
    ///   Given an integer array `nums` and an integer `k`,
    ///   choose any `k` elements such that the difference between
    ///   the maximum and minimum elements is minimized.
    ///
    /// Key Insight:
    ///   - After sorting, the optimal `k` elements must be consecutive.
    ///   - Use a sliding window of size `k` over the sorted array.
    /// -----------------------------------------------------------------------
    func minimumDifference(_ nums: [Int], _ k: Int) -> Int {
        // If k <= 1, difference is always 0
        guard k > 1 else { return 0 }
        
        let sortedNumbers = nums.sorted()
        let totalCount = sortedNumbers.count
        
        var minDifference = Int.max
        
        // Slide a window of size k over the sorted array
        for startIndex in 0...(totalCount - k) {
            let endIndex = startIndex + k - 1
            
            let windowMin = sortedNumbers[startIndex]
            let windowMax = sortedNumbers[endIndex]
            
            minDifference = min(minDifference, windowMax - windowMin)
        }
        
        return minDifference
    }
}
