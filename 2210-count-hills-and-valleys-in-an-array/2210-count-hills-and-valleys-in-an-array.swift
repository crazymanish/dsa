/*
Refactored Code Time Complexity: O(N)
- The refactored solution iterates through the array twice in separate, non-nested loops (once to filter, once to count), resulting in a linear runtime that is much more efficient for large inputs.

Refactored Code Space Complexity: O(N)
- A new array is created to store the non-adjacent duplicates, which could, in the worst case, have the same number of elements as the original.
*/
class Solution {
    func countHillValley(_ nums: [Int]) -> Int {
        // --- 1. Filter out adjacent duplicates ---
        // This simplifies the array by treating plateaus (e.g., [2, 2, 2]) as a single point.
        var uniqueAdjacent = [Int]()
        if let first = nums.first { uniqueAdjacent.append(first) }
        
        for i in 1..<nums.count {
            if nums[i] != uniqueAdjacent.last {
                uniqueAdjacent.append(nums[i])
            }
        }

        // We need at least 3 points to form a hill or valley.
        guard uniqueAdjacent.count >= 3 else { return 0 }

        // --- 2. Count hills and valleys in the simplified array ---
        var count = 0
        for i in 1..<(uniqueAdjacent.count - 1) {
            let left = uniqueAdjacent[i - 1]
            let middle = uniqueAdjacent[i]
            let right = uniqueAdjacent[i + 1]

            // Check for a hill:  left < middle > right
            let isHill = left < middle && middle > right
            
            // Check for a valley: left > middle < right
            let isValley = left > middle && middle < right

            if isHill || isValley {
                count += 1
            }
        }
        
        return count
    }
}