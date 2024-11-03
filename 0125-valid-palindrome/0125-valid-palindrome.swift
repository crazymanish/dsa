class Solution {
    func isPalindrome(_ s: String) -> Bool {
        let nonAlphanumericsCharacterSet = CharacterSet.alphanumerics.inverted
        let inputString = s.lowercased()
            .components(separatedBy: nonAlphanumericsCharacterSet)
            .joined(separator: "")
     
        func isPalindrome(_ array: [Character]) -> Bool {
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
        
        return isPalindrome(Array(inputString))
    }
}