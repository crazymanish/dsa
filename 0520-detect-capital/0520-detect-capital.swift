class Solution {
    func detectCapitalUse(_ word: String) -> Bool {
        guard word.count > 1 else { return true }
        
        let letters = Array(word)
        let isFirstLetterUppercase = letters[0].isUppercase
        let isRestLetterUppercase = letters[1].isUppercase
        
        if isFirstLetterUppercase {
            for i in 1..<letters.count {
                if letters[i].isUppercase != isRestLetterUppercase { return false }
            } 
            
        } else {
            return word == word.lowercased()
        }
        
        return true
    }
}