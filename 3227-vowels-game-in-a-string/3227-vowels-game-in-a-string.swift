class Solution {
    func doesAliceWin(_ s: String) -> Bool {
        for ch in "aeiou" {
            if s.contains(ch) { return true }
        }
        return false
    }
}