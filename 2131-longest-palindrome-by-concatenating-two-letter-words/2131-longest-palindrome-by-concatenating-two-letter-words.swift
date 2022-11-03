class Solution {
    func longestPalindrome(_ words: [String]) -> Int {
        var hashMap = Array(repeating: Array(repeating: 0, count:26), count:26)
        var answer = 0
        
        for word in words {
            var characters = Array(word)
            var firstCharacter = characters[0].index
            var secondCharacter = characters[1].index
            
            if hashMap[secondCharacter][firstCharacter] > 0 {
                answer += 4
                hashMap[secondCharacter][firstCharacter] -= 1
            } else {
                hashMap[firstCharacter][secondCharacter] += 1
            }
        }
        
        for character in 0..<26 {
            if hashMap[character][character] > 0 {
                answer += 2
                break
            }
        }
        
        return answer
    }
}

extension Character {
    var index: Int {
        Int(asciiValue! - Character("a").asciiValue!)
    }
}