class Solution {
    func numsSameConsecDiff(_ N: Int, _ K: Int) -> [Int] {
        var result:[Int] = []
        
        if N == 1 { result.append(0) } 
        
        for i in 1...9 {
            dfs(i, N-1)
        } 
        
        func dfs(_ value: Int, _ count:Int) {
            if count == 0 {
                result.append(value)
                return
            }
        
            let lastDigit = value % 10
            for i in 0...9 where abs(lastDigit - i) == K {
                dfs(value * 10 + i, count - 1)
            }
        }
        
        return result
    }
}