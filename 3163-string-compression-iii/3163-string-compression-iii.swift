class Solution {
    func compressedString(_ word: String) -> String {
        var result: [String] = []
        var count = 0
        var currentCharacter = word.first!
        
        for char in word {
            if (char == currentCharacter && count < 9) {
                count += 1
            } else {
                result.append("\(count)")
                result.append(String(currentCharacter))
                
                currentCharacter = char
                count = 1
            }
        }
        
        result.append("\(count)")
        result.append(String(currentCharacter))
        
        return result.joined()
    }
}