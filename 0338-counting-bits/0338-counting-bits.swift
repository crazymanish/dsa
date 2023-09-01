/*
- if i % 2 equals to 0, we can get i by shifting i / 2 left by 1, so their numbers of 1s are the same
res[i] = res[i / 2]

- if i % 2 equals to 1, number of 1s is one more than number of 1s in (i - 1)
res[i] = res[i - 1] + 1 = res[(i - 1) / 2] + 1
*/
class Solution {
    func countBits(_ n: Int) -> [Int] {
        var dpCache = [Int](repeating: 0, count: n+1)
        
        for i in 0...n {
            dpCache[i] = dpCache[i/2] + (i%2)
        }
        
        return dpCache
    }
}