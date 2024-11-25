class Solution {
    func slidingPuzzle(_ board: [[Int]]) -> Int {
        let moves = [[1,3],[0,2,4],[1,5],[0,4],[1,3,5],[2,4]]
        var bfs = [board.flatMap{$0}]
        var visited = Set([bfs[0]])
        var result = 0
        
        while !bfs.isEmpty {
            var nextBfs = [[Int]]()
            for board in bfs {
                guard board != [1,2,3,4,5,0] else { return result }
                let zeroIndex = board.firstIndex(of: 0)!
                for move in moves[zeroIndex] {
                    var board = board
                    board.swapAt(move, zeroIndex)
                    
                    guard visited.insert(board).inserted else { continue }
                    
                    nextBfs.append(board)
                }
            }
            bfs = nextBfs
            result += 1
        }
        return -1
    }
}