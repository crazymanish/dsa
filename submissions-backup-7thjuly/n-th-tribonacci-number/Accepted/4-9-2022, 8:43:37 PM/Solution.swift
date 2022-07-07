// https://leetcode.com/problems/n-th-tribonacci-number

class Solution {
    func tribonacci(_ n: Int) -> Int {
        var dpCache: [Int] = []
        
        dpCache.append(0) // if n == 0 { return 0 }
        dpCache.append(1) // if n == 1 { return 1 }
        dpCache.append(1) // if n == 2 { return 1 }
        
        var currentIndex = 3
        while currentIndex <= n {
            let tribonacciValue = dpCache[currentIndex-3] + dpCache[currentIndex-2] + dpCache[currentIndex-1]
            dpCache.append(tribonacciValue)
            
            currentIndex += 1
        }
        
        return dpCache[n]
    }
}