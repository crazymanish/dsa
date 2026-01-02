class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n), where n = nums.count
    ///     Each element is processed once, and Set operations are O(1) on average.
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     A Set is used to store numbers that have already been seen.
    ///
    /// Problem Summary:
    ///   The array has size 2N.
    ///   Exactly one element is repeated N times.
    ///   All other elements appear exactly once.
    ///
    /// Approach:
    ///   - Iterate through the array.
    ///   - Insert each number into a Set.
    ///   - If insertion fails, that number has already been seen
    ///     and must be the repeated element.
    ///
    /// Why this works:
    ///   Only the repeated element can appear more than once,
    ///   so the first duplicate encountered is the answer.
    /// -----------------------------------------------------------------------
    func repeatedNTimes(_ nums: [Int]) -> Int {
        // Set to track numbers we have already seen
        var seenNumbers = Set<Int>()
        
        for num in nums {
            // Attempt to insert the number into the set
            // If insertion fails, it means num already exists
            if !seenNumbers.insert(num).inserted {
                return num
            }
        }
        
        // Guaranteed not to happen based on problem constraints
        return -1
    }
}
