// https://leetcode.com/problems/powx-n

class Solution {
    func myPow(_ x: Double, _ n: Int) -> Double {
        let value = getPowValue(x, abs(n))
        
        if n < 0 {
            return Double(1)/value
        } else {
            return value
        }
    }
    
    private func getPowValue(_ x: Double, _ n: Int) -> Double {
        if n == 0 { return Double(1) }
        
        return x * getPowValue(x, n-1)
    }
}