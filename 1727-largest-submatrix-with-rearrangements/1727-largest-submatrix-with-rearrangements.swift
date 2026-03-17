class Solution {
    /**
     Problem Summary:
     Given a binary matrix, we can rearrange columns independently per row.
     Find the largest submatrix consisting only of 1s.

     Strategy:
     - Maintain an array `heights` where heights[col] represents the number of
       consecutive 1s ending at the current row.
     - For each row:
        1. Update heights.
        2. Sort heights in descending order (to simulate optimal column rearrangement).
        3. For each index i, compute area = heights[i] * (i + 1).
     - Track the maximum area.

     Key Insight:
     After sorting, using the first k columns gives width = k and height = heights[k-1].

     Time Complexity:
     O(n * m log m) due to sorting each row.

     Space Complexity:
     O(m) for heights array.
     */
    
    func largestSubmatrix(_ matrix: [[Int]]) -> Int {
        let rowCount = matrix.count
        let columnCount = matrix[0].count
        
        var heights = Array(repeating: 0, count: columnCount)
        var maxArea = 0
        
        for row in 0..<rowCount {
            // Step 1: Update heights of consecutive 1s
            for column in 0..<columnCount {
                if matrix[row][column] == 1 {
                    heights[column] += 1
                } else {
                    heights[column] = 0
                }
            }
            
            // Step 2: Sort heights in descending order
            let sortedHeights = heights.sorted(by: >)
            
            // Step 3: Compute max area for this row
            for i in 0..<columnCount {
                let height = sortedHeights[i]
                
                // If height is 0, no larger area can be formed beyond this
                if height == 0 { break }
                
                let width = i + 1
                let area = height * width
                maxArea = max(maxArea, area)
            }
        }
        
        return maxArea
    }
}