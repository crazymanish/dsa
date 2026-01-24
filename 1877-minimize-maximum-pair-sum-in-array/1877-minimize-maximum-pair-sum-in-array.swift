class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n log n)
    ///     - Sorting the array dominates the runtime.
    ///
    /// Space Complexity:
    ///   • O(1) extra space
    ///     - Ignoring the space used by sorting.
    ///
    /// Problem Summary:
    ///   Given an array of integers with even length,
    ///   pair up the numbers such that the maximum pair sum
    ///   is minimized. Return that maximum pair sum.
    ///
    /// Key Insight (Greedy):
    ///   - Pair the smallest number with the largest number.
    ///   - This balances the sums and minimizes the maximum pair.
    /// -----------------------------------------------------------------------
    func minPairSum(_ nums: [Int]) -> Int {
        // Sort numbers in ascending order
        let sortedNumbers = nums.sorted()
        let totalCount = sortedNumbers.count
        
        var leftIndex = 0
        var rightIndex = totalCount - 1
        var maxPairSum = Int.min
        
        // Pair smallest with largest, moving inward
        while leftIndex < rightIndex {
            let currentPairSum =
                sortedNumbers[leftIndex] + sortedNumbers[rightIndex]
            
            // Track the maximum sum among all formed pairs
            maxPairSum = max(maxPairSum, currentPairSum)
            
            leftIndex += 1
            rightIndex -= 1
        }
        
        return maxPairSum
    }
}
