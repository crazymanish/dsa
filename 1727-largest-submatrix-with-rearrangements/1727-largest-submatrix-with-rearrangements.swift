class Solution {
    func largestSubmatrix(_ matrix: [[Int]]) -> Int {
        let n = matrix.count
        let m = matrix[0].count

        var result = 0

        // Array to store heights of each column, initialized with zeros.
        var heights: [(index: Int, height: Int)] = Array(0..<m).map { ($0, 0) }
        
        for i in 0..<n {
            // Variable to track the current position in the heights array.
            var k = 0

            // Keep track of columns that are zeroed out.
            var emptyColumns: [Int] = []
            for (j, height) in heights {
                // If the current element in the matrix is 1, update the height.
                if matrix[i][j] == 1 {
                    heights[k] = (j, height+1)
                    k += 1

                    // Update the result by calculating the area of the rectangle.
                    result = max(result, k*(height+1))
                } else {
                    emptyColumns.append(j)
                }
            }

            // Append zeroed out columns to the end of the heights array.
            for j in emptyColumns {
                heights[k] = (j, 0)
                k += 1
            }
        }

        return result
    }
}