// https://leetcode.com/problems/valid-palindrome

class Solution {
    func isPalindrome(_ s: String) -> Bool {
        var inputString = s.lowercased() 
        
        let nonAlphanumericsCharacterSet = CharacterSet.alphanumerics.inverted
        inputString = inputString
            .components(separatedBy: nonAlphanumericsCharacterSet)
            .joined(separator: "")
     
        return isPalindromeString(inputString)
    }
    
   private func isPalindromeString(_ word: String) -> Bool {
        var leftPointerIndex = 0
        var rightPointerIndex = word.count - 1
        
        while leftPointerIndex < rightPointerIndex {
            let leftChar = word[leftPointerIndex]
            let rightChar = word[rightPointerIndex]
            
            if leftChar != rightChar { return false }
            
            leftPointerIndex += 1
            rightPointerIndex -= 1
        }
        
        return true
    }
}

private extension StringProtocol {
    subscript(_ offset: Int) -> Element { self[index(startIndex, offsetBy: offset)] }
}