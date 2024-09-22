class Solution {
    func lexicalOrder(_ n: Int) -> [Int] {
        var result = [Int]()
        
        func dfs(_ x: Int) {
            if x > n { return }
            
            result.append(x)
            dfs(x * 10)
            
            if x % 10 < 9 { dfs(x + 1) }
        }
        
        dfs(1)
        return result
    }
}