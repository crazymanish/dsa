class Solution {
    func minOperations(_ s: String) -> Int {
        var a = 0
        var b = 0
        
        for (index, character) in s.enumerated() {
            if index % 2 == (character == "1" ? 1 : 0) {
                a += 1
            } else {
                b += 1
            }
        }
        
        return min(a, b)
    }
}