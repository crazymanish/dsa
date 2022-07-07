// https://leetcode.com/problems/longest-palindromic-substring

class Solution {
    func longestPalindrome(_ s: String) -> String {
        var longestPalindrome = ""
        let sArray = Array(s)
        
        for index in 0..<sArray.count {
            let currentPalindrome = findPalindrome(sArray, index)
            
            if currentPalindrome.count > longestPalindrome.count {
                longestPalindrome = currentPalindrome
            }
        }
        
        return longestPalindrome
    }
    
    private func findPalindrome(_ sArray: [Character], _ centerIndex: Int) -> String {
        let sArrayCount = sArray.count
        let isEvenString = sArrayCount % 2 == 0
        
        var currentPalindrome = isEvenString ? "" : String(sArray[centerIndex])
        var leftPointer = isEvenString ? centerIndex : centerIndex - 1
        var rightPointer = centerIndex + 1
            
        while leftPointer >= 0 && rightPointer < sArray.count {
            let leftValue = sArray[leftPointer]
            let rightValue = sArray[rightPointer]
                
            if leftValue != rightValue {
                break
            } else {
                currentPalindrome = String(leftValue) + currentPalindrome + String(rightValue)
                leftPointer -= 1
                rightPointer += 1
            }
        }
        
        return currentPalindrome
    }
}