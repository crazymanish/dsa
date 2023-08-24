class Solution {
    func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
        var result: [String] = []
        var lineWords: [String] = []
        var currentLength = 0
        
        func justify(_ currentLength: Int) -> String {
            let spaceCount = lineWords.count - 1
            let totalSpaces = maxWidth - currentLength
            let averageSpaces = spaceCount > 0 ? totalSpaces / spaceCount : totalSpaces
            let extraSpaces = spaceCount > 0 ? totalSpaces % spaceCount : 0
    
            var result = ""
            for i in 0..<lineWords.count {
                result += lineWords[i]
                if i < spaceCount {
                    result += String(repeating: " ", count: averageSpaces)
                    if i < extraSpaces {
                        result += " "
                    }
                }
            }
    
            if spaceCount == 0 {
                result += String(repeating: " ", count: maxWidth - currentLength)
            }
    
            return result
        }
    
        for word in words {
            if currentLength + lineWords.count + word.count > maxWidth {
                result.append(justify(currentLength))
                lineWords = []
                currentLength = 0
            }
        
            lineWords.append(word)
            currentLength += word.count
        }
    
        if !lineWords.isEmpty {
            let lastLine = lineWords.joined(separator: " ")
            let padding = String(repeating: " ", count: maxWidth - lastLine.count)
            result.append(lastLine + padding)
        }
    
        return result
    }
}