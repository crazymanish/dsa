class Solution {
    func numMagicSquaresInside(_ grid: [[Int]]) -> Int {
        let rows = grid.count
        let columns = grid[0].count
        if rows < 3 || columns < 3 { return 0 }
        
        
        func isMagicSquare(_ square: [Int]) -> Bool {
            if square.sorted() != Array(1...9) { return false }
            
            let lineIndices = [[0, 1, 2], [3, 4, 5], [6, 7, 8],  // rows
                               [0, 3, 6], [1, 4, 7], [2, 5, 8],  // cols
                               [0, 4, 8], [2, 4, 6]]             // diagonals
            
            for indices in lineIndices {
                if square[indices[0]] + square[indices[1]] + square[indices[2]] != 15 {
                    return false
                }
            }
            
            return true
        }
        
        var result = 0
        
        for row in 1..<rows-1 {
            for column in 1..<columns-1 {
                let square = grid[(row-1)...(row+1)].flatMap { $0[(column-1)...(column+1)] }
                if isMagicSquare(square) {
                    result += 1
                }
            }
        }
        
        return result
    }
}