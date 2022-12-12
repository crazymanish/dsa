class Solution {
    lazy var dpCache: [Int: Int] = [
        0: 0,
        1: 1,
        2: 2
    ]
    
    func climbStairs(_ n: Int) -> Int {
        if let cacheValue = dpCache[n] { return cacheValue }
        
        let climbStairs1 = climbStairs(n-1)
        let climbStairs2 = climbStairs(n-2)
        
        dpCache[n-1] = climbStairs1
        dpCache[n-2] = climbStairs2
        
        return climbStairs1 + climbStairs2
    }
}