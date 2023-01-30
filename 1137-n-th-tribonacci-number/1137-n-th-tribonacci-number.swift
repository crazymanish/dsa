class Solution {
    var cache = [0: 0, 1: 1, 2: 1]
    
    func tribonacci(_ n: Int) -> Int {
        if let cacheValue = cache[n] { return cacheValue }
        
        cache[n-1] = cache[n-1] ?? tribonacci(n-1)
        cache[n-2] = cache[n-2] ?? tribonacci(n-2)
        cache[n-3] = cache[n-3] ?? tribonacci(n-2)
        cache[n] = cache[n-1]! + cache[n-2]! + cache[n-3]!
        
        return cache[n]!
    }
}