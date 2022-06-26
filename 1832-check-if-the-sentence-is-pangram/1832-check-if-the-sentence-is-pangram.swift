class Solution {
    func checkIfPangram(_ sentence: String) -> Bool {
        var hashMap: [Character : Bool] = [:]
        var hashMapLettersCount = 0
        
        for character in sentence {
            // No need to loop, if we already found all chars
            if hashMapLettersCount == 26 { break }
            
            if hashMap[character] == nil {
                hashMap[character] = true
                hashMapLettersCount += 1
            }
        }
        
        return hashMapLettersCount == 26
    }
}