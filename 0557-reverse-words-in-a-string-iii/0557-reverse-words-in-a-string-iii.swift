class Solution {
    func reverseWords(_ s: String) -> String {
        var words = s.components(separatedBy: " ")
        let wordsCount = words.count
        
        for index in 0..<wordsCount {
            words[index] = reverseWord(words[index])
        }
        
        return words.joined(separator: " ")
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