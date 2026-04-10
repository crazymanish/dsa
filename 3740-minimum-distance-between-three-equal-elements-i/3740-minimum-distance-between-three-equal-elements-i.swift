/**
 Problem Summary:
 Given an array `nums`, find the minimum distance for any value that appears
 at least 3 times. The distance is defined as:
     (index[k+1] - index[k-1]) * 2
 where k is the middle occurrence.

 If no such value exists, return -1.

 Strategy:
 1. Build a dictionary mapping each number to a list of its indices.
 2. For each number with at least 3 occurrences:
    - Iterate through the middle indices.
    - Compute the distance using the previous and next occurrences.
 3. Track the minimum distance found.

 Time Complexity:
 O(n)

 Space Complexity:
 O(n)
 */
class Solution {
    func minimumDistance(_ nums: [Int]) -> Int {
        // Map each value to all indices where it appears
        var valueToIndices: [Int: [Int]] = [:]
        for index in 0..<nums.count {
            valueToIndices[nums[index], default: []].append(index)
        }

        // Initialize with maximum possible Int to avoid magic numbers
        var minimumDistance = Int.max

        // Process each group of indices
        for indices in valueToIndices.values where indices.count >= 3 {
            // Iterate over valid "middle" indices
            for middleIndex in 1..<indices.count - 1 {
                let leftIndex = indices[middleIndex - 1]
                let rightIndex = indices[middleIndex + 1]
                
                // Compute distance
                let currentDistance = (rightIndex - leftIndex) * 2
                
                // Update minimum distance
                minimumDistance = min(minimumDistance, currentDistance)
            }
        }

        // If unchanged, no valid triplet was found
        return minimumDistance == Int.max ? -1 : minimumDistance
    }
}