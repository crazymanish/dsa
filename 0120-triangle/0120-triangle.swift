// Time Complexity: O(N^2), where N is the number of rows in the triangle.
// The nested loops result in visiting each element of the triangle once. The total
// number of elements is roughly N^2 / 2.
//
// Space Complexity: O(N), where N is the number of rows.
// We use an auxiliary array `paths` of size N to store the minimum path sums,
// which is independent of the total number of elements in the triangle.
class Solution {
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        // Handle the edge case of an empty triangle. The original code would fail this case.
        guard let firstRow = triangle.first else { return 0 }
        
        // `paths` is our DP array. paths[k] will store the minimum path sum from the top
        // to the element at column 'k' of the most recently processed row.
        var paths: [Int] = Array(repeating: 0, count: triangle.count)
        
        // Initialize the DP calculation with the value at the top of the triangle.
        paths[0] = firstRow[0]
        
        // Iterate through the triangle's rows, starting from the second row (index 1).
        for i in 1..<triangle.count {
            // For each new row, we calculate the updated minimum path sums.
            // We iterate backwards from the rightmost element (j=i) to the leftmost (j=0).
            // This backward iteration is crucial because it allows us to safely update the
            // `paths` array in-place. When calculating the new `paths[j]`, we can still
            // access the old `paths[j]` and `paths[j-1]` from the previous row's computation.
			for j in (0...i).reversed() {
                // The value of the current element in the triangle.
				let currentVal = triangle[i][j]
                
                // A node at (row i, col j) can be reached from (i-1, j) or (i-1, j-1).
                // We find the minimum sum from these "parent" paths.
				if j == i {
					// The rightmost element only has one parent: the rightmost element from the row above.
					paths[j] = paths[j-1] + currentVal
				} else if j == 0 {
					// The leftmost element only has one parent: the leftmost element from the row above.
					paths[j] = paths[j] + currentVal
				} else {
					// For any middle element, choose the minimum path from its two parents.
					paths[j] = min(paths[j], paths[j-1]) + currentVal
				}
			}
		}
        
        // After processing all rows, the `paths` array holds the minimum path sums
        // to each element in the triangle's last row. The overall minimum is the
        // smallest value in this array.
        return paths.min() ?? 0
    }
}