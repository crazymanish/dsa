class Solution {
    func decodeMessage(_ key: String, _ message: String) -> String {
        let emptyCharacter: Character = " "
        var keyHashMap: [Character: Character] = [:]
        
        var mappingCharacterIndex = 0
        for character in key {
            if character == emptyCharacter { continue }
            
            if keyHashMap[character] == nil {
                keyHashMap[character] = Character(UnicodeScalar(97+mappingCharacterIndex)!)
                mappingCharacterIndex += 1
            }
            
            if mappingCharacterIndex == 26 { break } // we are done with mapping
        }
        
        var decodedMessage = ""
        for character in message {
            let decodedCharacter: Character
            
            if character == emptyCharacter {
                decodedCharacter = emptyCharacter 
            } else {
                decodedCharacter = keyHashMap[character]! 
            }
            
            decodedMessage += String(decodedCharacter)
        }
        
        return decodedMessage
    }
}