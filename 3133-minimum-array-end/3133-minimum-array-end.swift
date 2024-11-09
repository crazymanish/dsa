class Solution {
    func minEnd(_ n: Int, _ x: Int) -> Int {
        var result = x
        
        for _ in 1..<n {
            result = (result+1) | x
        }
        
        return result
    }
}