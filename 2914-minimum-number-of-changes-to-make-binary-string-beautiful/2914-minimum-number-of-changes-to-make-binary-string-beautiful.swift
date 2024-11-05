class Solution {
    func minChanges(_ s: String) -> Int {
        let s = Array(s)
        var pairs = 0

        for i in stride(from: 0, to: s.count, by: 2) {
            if s[i] != s[i+1] { pairs += 1 }
        }

        return pairs
    }
}