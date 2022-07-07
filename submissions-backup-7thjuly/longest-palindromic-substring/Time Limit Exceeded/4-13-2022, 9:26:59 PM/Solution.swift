// https://leetcode.com/problems/longest-palindromic-substring

class Solution {
    func longestPalindrome(_ s: String) -> String {
        var longestPalindrome = ""
        let sArray = Array(s)
        
        for index in 0..<sArray.count {
            let oddLengthPalindrome = findPalindrome(sArray, index, index) // ODD length
            let evenLengthPalindrome = findPalindrome(sArray, index, index+1) // Even length
            
            if oddLengthPalindrome.count > longestPalindrome.count {
                longestPalindrome = oddLengthPalindrome
            }
            
            if evenLengthPalindrome.count > longestPalindrome.count {
                longestPalindrome = evenLengthPalindrome
            }
        }
        
        return longestPalindrome
    }
    
    private func findPalindrome(_ sArray: [Character], _ leftPointer: Int, _ rightPointer: Int) -> String {
        var leftPointer = leftPointer
        var rightPointer = rightPointer
            
        var currentPalindrome = ""
        while leftPointer >= 0 && rightPointer < sArray.count && sArray[leftPointer] == sArray[rightPointer] {
            currentPalindrome = String(sArray[leftPointer...rightPointer])
            
            leftPointer -= 1
            rightPointer += 1
        }
        
        return currentPalindrome
    }
}