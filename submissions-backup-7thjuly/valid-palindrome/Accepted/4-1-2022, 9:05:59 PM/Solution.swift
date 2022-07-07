// https://leetcode.com/problems/valid-palindrome

class Solution {
    func isPalindrome(_ s: String) -> Bool {
        var inputString = s.lowercased() 
        
        let nonAlphanumericsCharacterSet = CharacterSet.alphanumerics.inverted
        inputString = inputString
            .components(separatedBy: nonAlphanumericsCharacterSet)
            .joined(separator: "")
     
        return isPalindrome(Array(inputString))
    }
    
   private func isPalindrome(_ array: [Character]) -> Bool {
        var leftPointerIndex = 0
        var rightPointerIndex = array.count - 1
        
        while leftPointerIndex <= rightPointerIndex {
            let leftChar = array[leftPointerIndex]
            let rightChar = array[rightPointerIndex]
            
            if leftChar != rightChar { return false }
            
            leftPointerIndex += 1
            rightPointerIndex -= 1
        }
        
        return true
    }
}
