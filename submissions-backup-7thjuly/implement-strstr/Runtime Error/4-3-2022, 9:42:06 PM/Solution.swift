// https://leetcode.com/problems/implement-strstr

class Solution {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        let haystackCount = haystack.count
        let needleCount = needle.count
        
        if needleCount == 0 { return 0 }
        if haystack == needle { return 0 }
        
        var haystackStartIndex = haystack.startIndex
        
        for index in 0...(haystackCount-needleCount) {
            let haystackEndIndex = haystack.index(haystackStartIndex, offsetBy: needleCount)
            let currentRangeString = haystack[haystackStartIndex..<haystackEndIndex]
            
            if currentRangeString == needle { return index } // YaY!
            
            haystackStartIndex = haystack.index(haystackStartIndex, offsetBy: 1)
        }
        
        return -1 // Not found
    }
}