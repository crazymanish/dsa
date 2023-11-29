class Solution {
    func hammingWeight(_ n: Int) -> Int {
        var count = 0
        var num = n
        
        for i in 0..<32 {
            if (num >> i & 1) == 1 {
                count += 1
            }
        }
        
        return count
    }
}