class Solution {
    /*
    - think of it this way, imagine this 2D that has flatten to a single array
    - [1, 3, 5, 7, 10, 11, 16, 20, 23, 30, 34, 60]
    
    - you can apply the binary search for this
    - but to do that, we need to do some math
    - and what that means is that we need to get the row (midIndex / columnSize) and column (midIndex % columnSize)
    */
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        if (matrix.count == 0) || (matrix[0].count == 0) {
            return false
        }

        let rowSize = matrix.count 
        let columnSize = matrix[0].count 

        var startIndex = 0
        var endIndex = (rowSize * columnSize) - 1 

        while startIndex <= endIndex {

            let middleIndex = (endIndex + startIndex) / 2
            let middleValue = matrix[middleIndex / columnSize][middleIndex % columnSize]

            if middleValue == target {
                return true
            } else if middleValue < target {
                startIndex = middleIndex + 1
            } else if middleValue > target {
                endIndex = middleIndex - 1
            }
        }

        return false
    }
}