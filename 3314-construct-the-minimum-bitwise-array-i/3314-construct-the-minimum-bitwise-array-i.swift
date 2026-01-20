class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • Worst case: O(n * m)
    ///     - n = nums.count
    ///     - m = maximum value in nums
    ///     For each number, we try all candidates from 0 up to num.
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     Result array storing one value per input element.
    ///
    /// Problem Summary:
    ///   For each number `x` in nums, find an integer `i` such that:
    ///
    ///       i | (i + 1) == x
    ///
    ///   If such an `i` exists, return it.
    ///   Otherwise, return -1 for that position.
    ///
    /// Approach:
    ///   - For each number, try all possible candidates `i` from 0 to x.
    ///   - The first `i` satisfying the bitwise condition is chosen.
    /// -----------------------------------------------------------------------
    func minBitwiseArray(_ nums: [Int]) -> [Int] {
        var resultArray = [Int]()
        
        // Process each number independently
        for targetValue in nums {
            var matchingValue: Int? = nil
            
            // Try all possible candidates i
            for candidate in 0...targetValue {
                // Check the required bitwise condition
                if (candidate | (candidate + 1)) == targetValue {
                    matchingValue = candidate
                    break
                }
            }
            
            // Append result (or -1 if no candidate was found)
            resultArray.append(matchingValue ?? -1)
        }
        
        return resultArray
    }
}
