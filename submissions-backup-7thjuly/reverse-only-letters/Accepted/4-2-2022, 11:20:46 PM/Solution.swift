// https://leetcode.com/problems/reverse-only-letters

class Solution {
    func reverseOnlyLetters(_ word: String) -> String {
        var leftPointer = 0
        var rightPointer = word.count-1
        
        var wordChars: [String] = []
        for char in word { wordChars.append(String(char)) }
        
        while leftPointer < rightPointer {
            let leftPointerValue = wordChars[leftPointer]
            let rightPointerValue = wordChars[rightPointer]
            
            if leftPointerValue.isValidLetter == false {
                leftPointer += 1
                continue
            }
            
            if rightPointerValue.isValidLetter == false {
                rightPointer -= 1
                continue
            }
            
            //swaping chars to finish reverse
            wordChars[leftPointer] = rightPointerValue
            wordChars[rightPointer] = leftPointerValue
            
            leftPointer += 1
            rightPointer -= 1
        }
        
        return wordChars.joined(separator: "")
    }
}

extension String {
    var isValidLetter: Bool {
        let asciiValue = Character(self).asciiValue!
        // Character("a").asciiValue -> 97, Character("z").asciiValue -> 122
        // Character("A").asciiValue -> 65, Character("Z").asciiValue -> 90
        return (asciiValue >= 97 && asciiValue <= 122) || 
            (asciiValue >= 65 && asciiValue <= 90)
    }
}