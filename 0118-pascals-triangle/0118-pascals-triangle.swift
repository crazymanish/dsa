// Time Complexity: O(numRows^2)
// The number of values in the triangle is 1 + 2 + ... + numRows,
// which is (numRows * (numRows + 1)) / 2. The algorithm computes each
// value once, resulting in a quadratic time complexity.
//
// Space Complexity: O(numRows^2)
// The space required to store the resulting triangle is also
// proportional to the total number of values generated.
class Solution {
    /// Generates the first `numRows` of Pascal's Triangle.
    func generate(_ numRows: Int) -> [[Int]] {
        // Handle the edge case where no rows are requested.
        guard numRows > 0 else { return [] }

        // Start with the first row, which is always [1].
        var triangle = [[1]]

        // Generate the remaining rows from the 2nd row up to numRows.
        for i in 1..<numRows {
            // Get a reference to the previously generated row.
            let previousRow = triangle[i-1]
            
            // Start the new row with the leading 1.
            var currentRow = [1]
            
            // Calculate the middle elements of the new row. Each element is the
            // sum of the two elements directly above it from the previous row.
            for j in 1..<previousRow.count {
                let sum = previousRow[j-1] + previousRow[j]
                currentRow.append(sum)
            }
            
            // End the new row with the trailing 1.
            currentRow.append(1)
            
            triangle.append(currentRow)
        }
        
        return triangle
    }
}