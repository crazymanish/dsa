// https://leetcode.com/problems/palindrome-partitioning-ii

class Solution {
    func minCut(_ s: String) -> Int {
        let sArray = Array(s)
        let sArrayCount = sArray.count
        
        var dpCacheCuts = [Int](repeating: 0, count: sArrayCount + 1)
        for i in 0...sArrayCount { dpCacheCuts[i] = i - 1 }
        
        var leftPointer = 0
        var rightPointer = 0
        while leftPointer < sArrayCount {
            
            // Odd length palindromes.
            rightPointer = 0
            while leftPointer-rightPointer >= 0 && 
                leftPointer + rightPointer < sArrayCount && 
                sArray[leftPointer-rightPointer] == sArray[leftPointer+rightPointer] {
                dpCacheCuts[leftPointer+rightPointer+1] = min(dpCacheCuts[leftPointer+rightPointer+1], 1 + dpCacheCuts[leftPointer-rightPointer])
                rightPointer += 1
            }
            
            // Even length palindromes.
            rightPointer = 1
            while leftPointer-rightPointer+1 >= 0 && 
                leftPointer+rightPointer < sArrayCount && 
                sArray[leftPointer-rightPointer+1] == sArray[leftPointer+rightPointer] {
                dpCacheCuts[leftPointer+rightPointer+1] = min(dpCacheCuts[leftPointer+rightPointer+1], 1 + dpCacheCuts[leftPointer-rightPointer+1])
                rightPointer += 1
            }   
            
            leftPointer += 1
        }
        
        return dpCacheCuts[sArrayCount]
    }
}

/*
// Solution with MCM concept but getting TimeOut 
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
