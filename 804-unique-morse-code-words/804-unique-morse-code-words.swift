class Solution {
    func uniqueMorseRepresentations(_ words: [String]) -> Int {
        let morseCodeHashMap = getMorseCodeHashMap()
        var transformationHashMap: [String : Bool] = [:]
        var uniqueTransformationHashMapCount = 0
        
        for word in words {
            var transformationString = ""
            for character in word {
                transformationString += morseCodeHashMap[character]!
            }
            
            if transformationHashMap[transformationString] == nil {
                transformationHashMap[transformationString] = true
                uniqueTransformationHashMapCount += 1
            }
        }
        
        return uniqueTransformationHashMapCount
    }
    
    private func getMorseCodeHashMap() -> [Character : String] {
        var hashMap: [Character : String] = [:]
        
        let codes = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
        let alphabets = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        
        for index in 0..<26 { hashMap[Character(alphabets[index])] = codes[index] }
        
        return hashMap
    }
}

class Solution2UsingSet {
    func uniqueMorseRepresentations(_ words: [String]) -> Int {
        let morseCodeHashMap = getMorseCodeHashMap()
        var transformationSet = Set<String>()
        var uniqueTransformationCount = 0
        
        for word in words {
            var transformationString = ""
            for character in word {
                transformationString += morseCodeHashMap[character]!
            }
            
            if transformationSet.insert(transformationString).inserted {
                uniqueTransformationCount += 1
            }
        }
        
        return uniqueTransformationCount
    }
    
    private func getMorseCodeHashMap() -> [Character : String] {
        var hashMap: [Character : String] = [:]
        
        let codes = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
        let alphabets = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        
        for index in 0..<26 { hashMap[Character(alphabets[index])] = codes[index] }
        
        return hashMap
    }
}