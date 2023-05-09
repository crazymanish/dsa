class Solution {
    enum Direction {
        case right
        case down
        case left
        case up
    }
    
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var result: [Int] = []
        
        var top = 0
        var bottom = matrix.count - 1
        var left = 0
        var right = matrix[0].count - 1
        var direction: Direction = .right
        
        while top <= bottom && left <= right {
            switch direction {
            case .right:
                for i in left...right {
                    result.append(matrix[top][i])
                }
                top += 1
                direction = .down
            
            case .down:
                for i in top...bottom {
                    result.append(matrix[i][right])
                }
                right -= 1
                direction = .left
            
            case .left:
                for i in stride(from: right, through: left, by: -1) {
                    result.append(matrix[bottom][i])
                }
                bottom -= 1
                direction = .up
            
            case .up:
                for i in stride(from: bottom, through: top, by: -1) {
                    result.append(matrix[i][left])
                }
                left += 1
                direction = .right
            }
        }
        
        return result
    }
}