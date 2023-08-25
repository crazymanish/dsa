class Solution {
    func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
        var dp: [DPKey: Bool] = [:]
        
        func isInterleave(_ s1: [Character],_ i1: Int,
                          _ s2: [Character], _ i2: Int,
                          _ s3: [Character], _ i3: Int) -> Bool {
            let key = DPKey(i1: i1, i2: i2, i3: i3)
        
            if let cacheValue = dp[key] { return cacheValue }
        
            guard i1 < s1.count && i2 < s2.count && i3 < s3.count else {
                if s1.count == i1 {
                    return s2[i2...] == s3[i3...]
                } else if s2.count == i2 {
                    return s1[i1...] == s3[i3...]
                } else {
                    return false
                }
            }
        
            var result = false
            if s1[i1] == s3[i3] {
                result = result || isInterleave(s1, i1 + 1, s2, i2, s3, i3 + 1)
            }
            if s2[i2] == s3[i3] {
                result = result || isInterleave(s1, i1, s2, i2 + 1, s3, i3 + 1)
            }
            dp[key] = result
            return result
        }
        
        return isInterleave(Array(s1), 0, Array(s2), 0, Array(s3), 0)
    }
}

struct DPKey: Hashable {
    let i1: Int
    let i2: Int
    let i3: Int
}