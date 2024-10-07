class Solution {
    func minLength(_ s: String) -> Int {
        let res = s
            .replacingOccurrences(of: "AB", with: "")
            .replacingOccurrences(of: "CD", with: "")
        
        guard res.count < s.count else { return res.count }
        
        return minLength(res)
    }
}