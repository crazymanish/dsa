/**
 Problem Summary:
 Given an array A, construct a new array such that elements are grouped into segments.
 Each segment is filled with the maximum value seen so far, but only when it is valid
 based on future constraints.

 Strategy:
 1. Build a suffix minimum array (in-place using S) where:
    S[i] = minimum value from A[i] to A[N-1].
 2. Iterate through A while maintaining a running maximum (`currentMax`).
 3. At each index, decide whether to "close" a segment:
    - If currentMax <= next suffix minimum, it's safe to finalize the segment.
 4. Fill the result array with `currentMax` for the segment length.

 Key Insight:
 - The suffix minimum ensures that no future element violates the segment's maximum.
 - We greedily finalize segments as early as possible.

 Time Complexity:
 O(N) — single pass for suffix computation + single pass for result construction.

 Space Complexity:
 O(N) — for the result array (suffix is done in-place).
 */

class Solution {
    func maxValue(_ array: [Int]) -> [Int] {
        let count = array.count
        var suffixMin = array
        
        // Step 1: Build suffix minimum array
        if count >= 2 {
            for index in stride(from: count - 2, through: 0, by: -1) {
                suffixMin[index] = min(suffixMin[index], suffixMin[index + 1])
            }
        }
        
        var result: [Int] = []
        var currentMax = 0
        
        // Step 2: Iterate and build result
        for (index, value) in array.enumerated() {
            // Update running maximum
            currentMax = max(currentMax, value)
            
            // Step 3: Check if we can finalize a segment
            let isLastElement = (index == count - 1)
            let canCloseSegment = isLastElement || currentMax <= suffixMin[index + 1]
            
            if canCloseSegment {
                // Number of elements in current segment
                let segmentLength = (index + 1) - result.count
                
                // Fill segment with currentMax
                result.append(contentsOf: Array(repeating: currentMax, count: segmentLength))
                
                // Reset for next segment
                currentMax = 0
            }
        }
        
        return result
    }
}