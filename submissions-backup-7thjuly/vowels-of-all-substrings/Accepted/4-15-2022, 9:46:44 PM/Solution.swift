// https://leetcode.com/problems/vowels-of-all-substrings

class Solution {
    func countVowels(_ word: String) -> Int {
        // Logic is count howmany times a vowel char can be part of sub-string
        // Example: aba
        // index 0, a => (index+1) * (count-index) => (0+1) * (3-0) => 1 * 3 = 3
        // index 1, b => ignore (not a vowel)
        // index 2, a => (index+1) * (count-index) => (2+1) * (3-2) => 3 * 1 = 3
        // Answer: 3 + 0 + 3 => 6
        
        var answer = 0
        
        let wordCount = word.count
        for (index, char) in word.enumerated() {
            if char == "a" || char == "e" || char == "i" || char == "o" || char == "u" {
                answer += (index+1) * (wordCount-index)
            }
        }
        
        return answer
    }
}