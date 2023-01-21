class Solution {
    func maxVowels(_ s: String, _ k: Int) -> Int {
        let sArray = Array(s)
        var vowelsCount = 0 
        var maxVowelsCount = 0
        
        for (index, character) in sArray.enumerated() {
            if character.isVowel { vowelsCount += 1 }
            
            if index >= k, sArray[index-k].isVowel { vowelsCount -= 1 }
            
            maxVowelsCount = max(maxVowelsCount, vowelsCount)
        }
        
        return maxVowelsCount
    }
}

extension Character {
    var isVowel: Bool { self == "a" || self == "e" || self == "i" || self == "o" || self == "u" }
}