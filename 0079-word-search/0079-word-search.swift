class Solution {
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        let m = board.count
        let n = board[0].count
        let array = Array(word)
        var visited = Array(repeating: Array(repeating: false, count: n), count: m)
        
        func dfs(_ x: Int, _ y: Int, _ index: Int) -> Bool {
            guard x < m, y < n, x >= 0, y >= 0 else { return false }
        
            if visited[x][y] {
                return false
            }
        
            if board[x][y] != array[index] {
                return false
            } 
        
            if index == array.count - 1 {
                return true
            }
        
            visited[x][y] = true 
        
            if dfs(x + 1, y, index + 1) 
            || dfs(x - 1, y, index + 1) 
            || dfs(x, y + 1, index + 1) 
            || dfs(x, y - 1, index + 1) {
                return true
            }
        
            visited[x][y] = false
            return false
        }
        
        
        for i in 0..<m {
            for j in 0..<n {
                if board[i][j] == array[0] {
                    if dfs(i, j, 0) {
                        return true
                    }
                }
            }
        }
        
        return false
    }
}