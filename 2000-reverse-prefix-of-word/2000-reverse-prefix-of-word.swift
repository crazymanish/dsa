class Solution {
    func reversePrefix(_ word: String, _ ch: Character) -> String {
        var prefix = ""
        var suffix = ""
        var isPrefixFound = false
        
        for char in word {
            if isPrefixFound {
                suffix += String(char)
            } else {
                prefix += String(char)
            }
            
            if char == ch { isPrefixFound = true }
        }
        
        if isPrefixFound {
            prefix = reverseWord(prefix)
        }
        
        return prefix + suffix
    }
    
    private func reverseWord(_ word: String) -> String {
        let wordCount = word.count
        var leftPointer = 0
        var rightPointer = wordCount-1
        
        var wordChars: [String] = []
        for char in word { wordChars.append(String(char)) }
        
        while leftPointer < rightPointer {
            //swaping chars to finish reverse
            let temp = wordChars[leftPointer]
            wordChars[leftPointer] = wordChars[rightPointer]
            wordChars[rightPointer] = temp
            
            leftPointer += 1
            rightPointer -= 1
        }
        
        return wordChars.joined(separator: "")
    }
}