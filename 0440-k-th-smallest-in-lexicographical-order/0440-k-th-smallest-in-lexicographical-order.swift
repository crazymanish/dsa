class Solution {
    func findKthNumber(_ n: Int, _ k: Int) -> Int {
        var ans = 1
        var i = 1
        
        func getGap(_ a: Int, _ b: Int, _ n: Int) -> Int {
            var gap = 0
            var a = a
            var b = b
        
            while a <= n {
                gap += min(n + 1, b) - a
                a *= 10
                b *= 10
            }
        
            return gap
        }
        
        while i < k {
            let gap = getGap(ans, ans + 1, n)
            if i + gap <= k {
                i += gap
                ans += 1
            } else {
                i += 1
                ans *= 10
            }
        }
        
        return ans
    }
}