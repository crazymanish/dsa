class Solution {
    func removeStars(_ s: String) -> String {
        var finalCharacters = [Character]()
        
        for character in s {
            if character == "*" {
                finalCharacters.removeLast()             
            } else {
                finalCharacters.append(character)
            }
        }
        return String(finalCharacters)
    }
}