class Solution {
    func nearestExit(_ maze: [[Character]], _ entrance: [Int]) -> Int {
        let rowCount = maze.count
        let colCount = rowCount > 0 ? maze[0].count : 0
        var maze = maze.map({ $0.map({ $0 == "." ? true : false }) }) 
        var nextQueue = [entrance] 
        var step = 1

        func makeCloseCell(_ row: Int, _ col: Int) {
            maze[row][col] = false
        }

        func tryNextMoveCell(_ row: Int, _ col: Int) -> Bool {
            guard row >= 0, row < rowCount, col >= 0, col < colCount else { return false } // out of maze
            guard maze[row][col] else { return false } // cell is wall or was visited before
            
            nextQueue.append([row, col])
            makeCloseCell(row, col)
            
            return row == 0 || row == rowCount - 1 || col == 0 || col == colCount - 1
        }

        makeCloseCell(entrance[0], entrance[1])
        while !nextQueue.isEmpty {
            let queue = nextQueue
            nextQueue = []
            
            for cell in queue {
                let row = cell[0], col = cell[1]
                if tryNextMoveCell(row - 1, col) || 
                    tryNextMoveCell(row + 1, col) || 
                    tryNextMoveCell(row, col - 1) || 
                    tryNextMoveCell(row, col + 1) {
                    return step
                }
            }
            step += 1
        }
        
        return -1
    }
}