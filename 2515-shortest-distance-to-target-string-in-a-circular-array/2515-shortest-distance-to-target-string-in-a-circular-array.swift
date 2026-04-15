class Solution {
    /**
     Problem Summary:
     Given a circular array of words, find the minimum distance from a given start index
     to any occurrence of a target word. Movement can be in both directions (clockwise
     or counterclockwise).

     Strategy:
     1. Collect all indices where the target word appears.
     2. For each occurrence, compute:
        - Direct distance (absolute difference)
        - Circular forward distance
        - Circular backward distance
     3. Return the minimum among all computed distances.

     Time Complexity:
     O(n) — Single pass to collect indices + single pass to compute distances

     Space Complexity:
     O(k) — Where k is the number of occurrences of the target
     */

    func closestTarget(_ words: [String], _ target: String, _ startIndex: Int) -> Int {
        var targetIndices: [Int] = []

        // Step 1: Collect all indices where the target appears
        for index in 0..<words.count {
            if words[index] == target {
                targetIndices.append(index)
            }
        }

        // If target does not exist, return -1
        guard !targetIndices.isEmpty else { return -1 }

        let totalWords = words.count
        var minimumDistance = Int.max

        // Step 2: Evaluate all possible distances
        for targetIndex in targetIndices {
            
            // Direct (linear) distance
            let directDistance = abs(targetIndex - startIndex)
            
            // Circular distances
            let forwardCircularDistance = totalWords - startIndex + targetIndex
            let backwardCircularDistance = startIndex + totalWords - targetIndex
            
            // Take the minimum among all possibilities
            minimumDistance = min(
                minimumDistance,
                directDistance,
                forwardCircularDistance,
                backwardCircularDistance
            )
        }

        return minimumDistance
    }
}