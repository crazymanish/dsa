// https://leetcode.com/problems/find-first-palindromic-string-in-the-array

class Solution {
    func firstPalindrome(_ words: [String]) -> String {
        for word in words {
            if isPalindrome(word) { return word }
        }
        
        return ""
    }
    
    private func isPalindrome(_ word: String) -> Bool {
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