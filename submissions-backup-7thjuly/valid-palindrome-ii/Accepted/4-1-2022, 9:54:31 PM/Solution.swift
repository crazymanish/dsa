// https://leetcode.com/problems/valid-palindrome-ii

class Solution {
    func validPalindrome(_ s: String) -> Bool {
        let array = Array(s)
        
        var leftPointerIndex = 0 
        var rightPointerIndex = array.count - 1
        
        while leftPointerIndex < rightPointerIndex {
            let leftChar = array[leftPointerIndex]
            let rightChar = array[rightPointerIndex]
            
            // this is the trick
            if leftChar != rightChar { 
                return isPalindrome(array, leftPointerIndex+1, rightPointerIndex) || 
                    isPalindrome(array, leftPointerIndex, rightPointerIndex-1)
            }
            
            leftPointerIndex += 1
            rightPointerIndex -= 1
        }
        
        return true
    }
    
    private func isPalindrome(_ array: [Character], _ leftIndex: Int, _ rightIndex: Int) -> Bool {
        var leftPointerIndex = leftIndex 
        var rightPointerIndex = rightIndex
        
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
