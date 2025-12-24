/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n log n)
///     - Sorting the box capacities dominates the runtime.
///
/// Space Complexity:
///   • O(1) extra space (ignoring sorting space)
///
/// Problem Summary:
///   We are given:
///     - `apple`: number of apples in each pile
///     - `capacity`: capacity of each box
///
///   Goal:
///   Find the minimum number of boxes needed to store all apples.
///
/// Approach:
///   - First compute the total number of apples.
///   - Sort box capacities in descending order.
///   - Greedily take the largest boxes first until their combined
///     capacity is at least the total number of apples.
/// ---------------------------------------------------------------------------

class Solution {
    func minimumBoxes(_ apple: [Int], _ capacity: [Int]) -> Int {
        // Total number of apples that must be stored
        let totalApples = apple.reduce(0, +)
        
        // Sort box capacities from largest to smallest
        let sortedCapacities = capacity.sorted(by: >)
        
        var usedCapacity = 0
        
        // Take boxes greedily until we can store all apples
        for (index, boxCapacity) in sortedCapacities.enumerated() {
            usedCapacity += boxCapacity
            
            if usedCapacity >= totalApples {
                return index + 1   // number of boxes used
            }
        }
        
        // Not enough total capacity (should not happen if input is valid)
        return -1
    }
}
