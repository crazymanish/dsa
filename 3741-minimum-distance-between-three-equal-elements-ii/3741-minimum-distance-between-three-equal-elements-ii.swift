/**
 Problem Summary:
 Given an integer array, find the minimum "distance" between any three equal elements.
 The distance is defined as:
     (index_k - index_i) * 2
 where i < j < k and nums[i] == nums[j] == nums[k].

 If no such triplet exists, return -1.

 Strategy:
 1. Group indices of each number using a dictionary.
 2. For each number that appears at least 3 times:
    - Iterate through its indices using a sliding window of size 3.
    - Compute the distance using the first and third index.
 3. Track the minimum distance across all valid triplets.

 Key Insight:
 Since indices are naturally sorted (we traverse left to right),
 we can directly use a sliding window over index lists.

 Time Complexity:
 O(n) — Each element is processed once, and each index list is traversed once.

 Space Complexity:
 O(n) — For storing indices in the dictionary.
 */

class Solution {
    func minimumDistance(_ nums: [Int]) -> Int {
        // Dictionary mapping number -> list of indices where it appears
        var indicesByValue: [Int: [Int]] = [:]
        
        // Build index lists for each number
        for (index, value) in nums.enumerated() {
            indicesByValue[value, default: []].append(index)
        }
        
        // Initialize result with maximum possible value
        var minimumDistance = Int.max
        
        // Iterate through each group of indices
        for indexList in indicesByValue.values {
            // We need at least 3 occurrences to form a valid triplet
            guard indexList.count >= 3 else { continue }
            
            // Sliding window of size 3
            for i in 0..<(indexList.count - 2) {
                let leftIndex = indexList[i]
                let rightIndex = indexList[i + 2]
                
                // Compute distance using first and third index
                let distance = (rightIndex - leftIndex) * 2
                
                // Update minimum distance
                minimumDistance = min(minimumDistance, distance)
            }
        }
        
        // Return -1 if no valid triplet was found
        return minimumDistance == Int.max ? -1 : minimumDistance
    }
}