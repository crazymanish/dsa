class Solution {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        if needle.isEmpty { return 0 }
        if needle.count > haystack.count { return -1 }
        
        let hArray = Array(haystack)
        let nArray = Array(needle)
        
        var haystackIndex = 0
        var needleIndex = 0
        
        while haystackIndex < hArray.count {
            if hArray[haystackIndex] == nArray[needleIndex] {
                haystackIndex += 1
                needleIndex += 1
                if needleIndex == nArray.count { break }
            } else if haystackIndex == hArray.count - 1 {
                break
            } else {
                if needleIndex == 0 {
                    haystackIndex += 1
                } else {
                    haystackIndex = haystackIndex - needleIndex + 1
                    needleIndex = 0
                }
            }
        }
        
        let result = (needleIndex == nArray.count) ? (haystackIndex - nArray.count) : -1
        return result
    }
}