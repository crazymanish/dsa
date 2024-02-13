class Solution {
    func firstPalindrome(_ words: [String]) -> String {   
        func isPalindrome(_ word: String) -> Bool {
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
        
        for word in words {
            if isPalindrome(word) { return word }
        }
        
        return ""
    }

}

private extension StringProtocol {
    subscript(_ offset: Int) -> Element { self[index(startIndex, offsetBy: offset)] }
}