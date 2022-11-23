class Solution {
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        let boardCount = board.count
        
        var rowSet: [Set] = [Set](repeating: Set<Character>(), count: boardCount)
        var colSet: [Set] = [Set](repeating: Set<Character>(), count: boardCount)
        var boxSet: [[Set]] = [[Set]](repeating:[Set](repeating: Set<Character>(), count: 3), count: 3)
                
        for i in 0..<boardCount {
            for j in 0..<board[0].count {
                let number = board[i][j]
                if rowSet[i].contains(number) || colSet[j].contains(number) || boxSet[i/3][j/3].contains(number) { 
                    return false 
                }
                
                if number == "." { continue }
                
                rowSet[i].insert(number)
                colSet[j].insert(number)
                boxSet[i/3][j/3].insert(number)
            }
        }

        return true
    }
}