/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n), where n = nums.count
///     We scan the array once to track distances between consecutive 1s.
///
/// Space Complexity:
///   • O(1)
///     Only constant extra variables are used.
///
/// Description:
///   Ensure every pair of 1s in the array are at least k zeros apart.
/// ---------------------------------------------------------------------------

class Solution {
    func kLengthApart(_ nums: [Int], _ k: Int) -> Bool {
        // Find the index of the first occurrence of 1
        var previousOneIndex = 0
        while previousOneIndex < nums.count && nums[previousOneIndex] != 1 {
            previousOneIndex += 1
        }
        
        // If no 1 exists, automatically valid
        if previousOneIndex == nums.count { return true }
        
        // Check distances between consecutive 1s
        for currentIndex in (previousOneIndex + 1)..<nums.count {
            if nums[currentIndex] == 1 {
                // Distance between the two 1s must be >= k
                let zeroCountBetween = currentIndex - previousOneIndex - 1
                if zeroCountBetween < k { return false }
                
                // Update the last seen 1 position
                previousOneIndex = currentIndex
            }
        }
        
        return true
    }
}
