// https://leetcode.com/problems/longest-common-subsequence

class Solution {
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        let text1Array = Array(text1)
        let text2Array = Array(text2)
        
        let text1Count = text1Array.count
        let text2Count = text2Array.count
        
        var dpCache = Array(repeating: Array(repeating: -1, count: text2Count+1), count: text1Count+1)
        
        func findLongestCommonSubsequence(_ text1Count: Int, _ text2Count: Int) -> Int {
            if text1Count == 0 || text2Count == 0 { return 0 }
            
            if dpCache[text1Count][text2Count] != -1 { return dpCache[text1Count][text2Count] }
            
            let longestCommonSubsequence: Int
            
            if text1Array[text1Count-1] == text2Array[text2Count-1] {
                longestCommonSubsequence = 1 + findLongestCommonSubsequence(text1Count-1, text2Count-1)
            } else {
                let text1LongestCommonSubsequence = findLongestCommonSubsequence(text1Count, text2Count-1)
                let text2LongestCommonSubsequence = findLongestCommonSubsequence(text1Count-1, text2Count)
                longestCommonSubsequence = max(text1LongestCommonSubsequence, text2LongestCommonSubsequence)
            }
            
            dpCache[text1Count][text2Count] = longestCommonSubsequence
            return longestCommonSubsequence
        }
        
        return findLongestCommonSubsequence(text1Count, text2Count) 
    }
}