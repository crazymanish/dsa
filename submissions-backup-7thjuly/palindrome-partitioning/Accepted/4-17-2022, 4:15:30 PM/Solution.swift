// https://leetcode.com/problems/palindrome-partitioning

class Solution {
    func partition(_ s: String) -> [[String]] {
        var output: [[String]] = []
        var palindromes: [String] = []
    
        func backtracking(_ characters: [Character], _ start: Int) {
            if start == characters.count {
                output.append(palindromes)
            } else {
                for index in start..<characters.count {
                    if isPalindrome(characters, start, index) {
                        let palindromeString = String(characters[start...index])
                        palindromes.append(palindromeString)
                        
                        backtracking(characters, index+1)
                        
                        palindromes.removeLast()
                    }
                }
            }
        }
        
        backtracking(Array(s), 0)
        
        return output
    }
    
   private func isPalindrome(_ characters: [Character], _ leftIndex: Int, _ rightIndex: Int) -> Bool {
        var leftPointerIndex = leftIndex
        var rightPointerIndex = rightIndex
        
        while leftPointerIndex <= rightPointerIndex {
            let leftChar = characters[leftPointerIndex]
            let rightChar = characters[rightPointerIndex]
            
            if leftChar != rightChar { return false }
            
            leftPointerIndex += 1
            rightPointerIndex -= 1
        }
        
        return true
    }
}
