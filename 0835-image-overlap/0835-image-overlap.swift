class Solution {
    func largestOverlap(_ A: [[Int]], _ B: [[Int]]) -> Int {
        let n = A.count 
        var best = 0 

        // Returns the shifted B value 
        var initial = 1 - n 
    
        func kernel(_ row: Int, _ col: Int) -> Int {
            var row = initial + row 
            var col = initial + col 
        
            guard row >= 0 && row < n else { return 0 }
            guard col >= 0 && col < n else { return 0 }
        
            return B[row][col]
        }

        // Compute the convolution 
        func convolute(_ x: Int, _ y: Int) -> Int {
            var result = 0 
            for row in 0 ..< n {
                for col in 0 ..< n {
                    result += A[row][col] * kernel(row + y, col + x)
                }
            }
            
            return result
        }

        // Compute the best overlap
        for x in 0 ..< (2 * n - 1) {
            for y in 0 ..< (2 * n - 1) {
                best = max(best, convolute(x, y))
            }
        }

        return best
    }
}