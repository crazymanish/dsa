class Solution {
    func longestPalindrome(_ s: String) -> String {
        guard s.count > 1 else { return s }

        let sArray = Array(s)
        let sCount = s.count

        var dpCache = Array(repeating: Array(repeating: false, count: sCount), count: sCount)

        var maxPalindromeLength = 0
        var output = String(sArray[0])
        
        for j in 1..<sCount {
            for i in 0..<j {
                let currentWordLength = j - i
                
                // 1. If sArray[i] == sArray[j] and the length of the word is 2 or less then its a palindrome
                // 2. If sArray[i] == sArray[j] and the inner word is a palindrome then s[i...j] is a palindrome
                if sArray[i] == sArray[j] && (currentWordLength <= 2 || dpCache[i + 1][j - 1]) {
                    dpCache[i][j] = true
                    if currentWordLength > maxPalindromeLength {
                        maxPalindromeLength = currentWordLength
                        output = String(sArray[i...j])
                    }
                }
            }
        }

        return output
    }
}