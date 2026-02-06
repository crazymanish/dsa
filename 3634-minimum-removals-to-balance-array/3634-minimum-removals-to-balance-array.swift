class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n log n)
    ///     - Sorting the array dominates the runtime.
    ///     - The two-pointer scan is O(n).
    ///
    /// Space Complexity:
    ///   • O(1) extra space
    ///     - Ignoring the space used by sorting.
    ///
    /// Problem Summary:
    ///   Remove the minimum number of elements so that for the remaining array:
    ///
    ///       maxValue ≤ minValue * k
    ///
    /// Approach:
    ///   - Sort the array.
    ///   - Use a sliding window (two pointers) to find the largest valid subset
    ///     where the smallest element times k is still ≥ the largest element.
    ///   - The answer is total elements minus the largest valid subset size.
    /// -----------------------------------------------------------------------
    func minRemoval(_ nums: [Int], _ k: Int) -> Int {
        let sortedValues = nums.sorted()
        let totalCount = sortedValues.count
        
        var leftIndex = 0
        var rightIndex = 0
        var maxWindowSize = 1
        
        // Sliding window over the sorted array
        while leftIndex <= rightIndex && rightIndex < totalCount {
            
            // Expand the window while it remains valid
            while rightIndex < totalCount &&
                  sortedValues[leftIndex] * k >= sortedValues[rightIndex] {
                rightIndex += 1
            }
            
            // Update the largest valid window size
            maxWindowSize = max(maxWindowSize, rightIndex - leftIndex)
            
            // Shrink the window from the left
            leftIndex += 1
        }
        
        // Minimum removals = total elements - largest valid subset
        return totalCount - maxWindowSize
    }
}
