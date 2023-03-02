class Solution {
    func compress(_ chars: inout [Character]) -> Int {
        var readIndex = 0
        var writeIndex = 0
        
        while readIndex < chars.count {
            // read
            let currentCharacter = chars[readIndex]
            
            var repeatingCharacterIndex = readIndex + 1
            while repeatingCharacterIndex < chars.count && chars[repeatingCharacterIndex] == currentCharacter {
                repeatingCharacterIndex += 1
            }
            
            let repeatingCharacterCount = repeatingCharacterIndex - readIndex
            readIndex = repeatingCharacterIndex
            
            // write
            chars[writeIndex] = currentCharacter
            writeIndex += 1
            
            if repeatingCharacterCount > 1 {
                var countingCharacterIndex = writeIndex
                for countingCharacter in String(repeatingCharacterCount) {
                    chars[countingCharacterIndex] = countingCharacter
                    countingCharacterIndex += 1
                }
                writeIndex = countingCharacterIndex
            }
        }
        
        return writeIndex
    }
}