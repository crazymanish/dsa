class Solution {
    func canConstruct(_ s: String, _ k: Int) -> Bool {
        // If k is greater than the length of s, it's impossible to construct k palindromes
        if k > s.count { return false }
        
        // Count the frequency of each character in the string
        var charFrequency = [Character: Int]()
        for char in s {
            charFrequency[char, default: 0] += 1
        }
        
        // Count the number of characters with odd frequencies
        var oddCount = 0
        for count in charFrequency.values {
            if count % 2 != 0 {
                oddCount += 1
            }
        }
        
        // If the number of odd frequencies is less than or equal to k, return true
        return oddCount <= k
    }
}