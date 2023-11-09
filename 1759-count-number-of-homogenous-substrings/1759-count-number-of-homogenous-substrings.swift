class Solution {
    func countHomogenous(_ s: String) -> Int {
        let modulo = 1_000_000_007
        var count = 0
        var consecutive = 1
        
        let chars = Array(s)
        for i in 1..<chars.count {
            if chars[i] == chars[i-1] {
                consecutive += 1
            } else {
                count += (consecutive * (consecutive+1) / 2) % modulo
                consecutive = 1
            }
        }
        count += (consecutive * (consecutive + 1) / 2) % modulo
        
        return count % modulo
    }
}