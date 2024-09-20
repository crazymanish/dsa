class Solution {
    func shortestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        let reversedChars: [Character] = s.reversed()
        let sCount = s.count
        
        for i in 0..<sCount {
            if chars.prefix(sCount-i) ==  reversedChars.suffix(sCount-i) {
                return reversedChars.prefix(i) + s
            }
        }

        return ""
    }
}