class Solution {
    func countSubstrings(_ s: String) -> Int {
        let sCount = s.count

        guard sCount > 1 else { return 1 }

        let sArray = Array(s)

        var dpCache = Array(repeating: Array(repeating: false, count: sCount), count: sCount)
        var output = 0

        for j in 1..<sCount {
            for i in 0..<j {
                let currentWordLength = j - i

                // If sArray[i] == sArray[j] and the length of the word is 2 or less then its a palindrome
                // If sArray[i] == sArray[j] and the inner word is a palindrome then sArray[i...j] is a palindrome
                // Using Cache to find the inner word is a palindrome or not
                if sArray[i] == sArray[j] && (currentWordLength <= 2 || dpCache[i + 1][j - 1]) {
                    dpCache[i][j] = true
                    output += 1
                }
            }
        }

        return output + sCount
    }
}