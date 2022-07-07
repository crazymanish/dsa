// https://leetcode.com/problems/palindrome-partitioning-ii

class Solution {
    // Dynamic programming - MCM concept
    func minCut(_ s: String) -> Int {
        let sCount = s.count
        var dpCache = Array(repeating: Array(repeating: -1, count: sCount), count: sCount)
        var isPalindromeCache: [[Bool?]] = Array(repeating: Array(repeating: nil, count: s.count), count: s.count)
        
        func findMinCutCount(_ s: String, _ startIndex: Int, _ endIndex: Int) -> Int {
            // check result in cache first...to avoid expensive recersive-calls
            let cacheValue = dpCache[startIndex][endIndex] 
            if cacheValue != -1 { return cacheValue }
            
            if startIndex >= endIndex { return 0 } // Base case
            if isPalindrome(s, startIndex, endIndex) { return 0 } // Found Palindrome
            
            // Find min cut using MCM concept
            var minCutCount = Int.max
            for k in startIndex..<endIndex {
                let leftMinCutCount = findMinCutCount(s, startIndex, k)
                let rightMinCutCount = findMinCutCount(s, k+1, endIndex)
            
                let currentCutCount = 1 + leftMinCutCount + rightMinCutCount    
                minCutCount = min(minCutCount, currentCutCount)
            }
            
            // Update cache
            dpCache[startIndex][endIndex] = minCutCount
            
            return minCutCount
        }
        
        func isPalindrome(_ s: String, _ startIndex: Int, _ endIndex: Int) -> Bool {
            if isPalindromeCache[startIndex][endIndex] == nil {
                isPalindromeCache[startIndex][endIndex] = true
        
                let sArray = Array(s)
                var currentStart = startIndex
                var currentEnd = endIndex
        
                while currentStart < currentEnd {
                    if sArray[currentStart] != sArray[currentEnd] {
                        isPalindromeCache[startIndex][endIndex] = false
                        break
                    }
            
                    currentStart += 1
                    currentEnd -= 1
            
                    if currentStart < currentEnd && isPalindromeCache[currentStart][currentEnd] != nil {
                        isPalindromeCache[startIndex][endIndex] = isPalindromeCache[currentStart][currentEnd]
                        break
                    }
                }
            }
    
            return isPalindromeCache[startIndex][endIndex] ?? false
        }
    
        return findMinCutCount(s, 0, sCount-1)
    }
}

/*
class Solution {
    // Dynamic programming - MCM concept
    func minCut(_ s: String) -> Int {
        let sCount = s.count
        var dpCache = Array(repeating: Array(repeating: -1, count: sCount), count: sCount)
        
        func findMinCutCount(_ s: String, _ startIndex: Int, _ endIndex: Int) -> Int {
            // check result in cache first...to avoid expensive recersive-calls
            let cacheValue = dpCache[startIndex][endIndex] 
            if cacheValue != -1 { return cacheValue }
            
            if startIndex >= endIndex { return 0 } // Base case
            if isPalindrome(s, startIndex, endIndex) { return 0 } // Found Palindrome
            
            // Find min cut using MCM concept
            var minCutCount = Int.max
            for k in startIndex..<endIndex {
                let leftMinCutCount = findMinCutCount(s, startIndex, k)
                let rightMinCutCount = findMinCutCount(s, k+1, endIndex)
            
                let currentCutCount = 1 + leftMinCutCount + rightMinCutCount    
                minCutCount = min(minCutCount, currentCutCount)
            }
            
            // Update cache
            dpCache[startIndex][endIndex] = minCutCount
            
            return minCutCount
        }
    
        return findMinCutCount(s, 0, sCount-1)
    }
    
// Timeout because isPalindrome is not using cache
   private func isPalindrome(_ s: String, _ leftIndex: Int, _ rightIndex: Int) -> Bool {
        let array = Array(s)
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
*/
