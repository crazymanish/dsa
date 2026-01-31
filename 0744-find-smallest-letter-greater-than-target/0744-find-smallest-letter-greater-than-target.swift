class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(log n)
    ///     Binary search over the sorted `letters` array.
    ///
    /// Space Complexity:
    ///   • O(1)
    ///     Only constant extra variables are used.
    ///
    /// Problem Summary:
    ///   Given a sorted array of letters (circularly wrapped),
    ///   find the smallest letter that is strictly greater than `target`.
    ///
    /// Key Binary Search Insight:
    ///   - We search for the FIRST letter > target.
    ///   - `left` always represents the smallest possible valid index.
    ///   - If no letter is greater than target, we wrap around and return
    ///     the first letter (index 0).
    ///
    /// Binary Search Invariant:
    ///   - Search range is [left, right)
    ///   - When loop ends, `left` is the insertion position for `target`
    /// -----------------------------------------------------------------------
    func nextGreatestLetter(_ letters: [Character], _ target: Character) -> Character {
        
        var leftIndex = 0
        var rightIndex = letters.count
        
        // Standard lower-bound binary search
        while leftIndex < rightIndex {
            let midIndex = leftIndex + (rightIndex - leftIndex) / 2
            
            if letters[midIndex] <= target {
                // Mid is not strictly greater, move right
                leftIndex = midIndex + 1
            } else {
                // Potential answer found, shrink right boundary
                rightIndex = midIndex
            }
        }
        
        // Use modulo to handle circular wrap-around
        return letters[leftIndex % letters.count]
    }
}
