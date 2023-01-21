class Solution {
    func myPow(_ x: Double, _ n: Int) -> Double {
        let x = n < 0 ? 1/x : x
        
        func powHelper(_ n: Int) -> Double {
            if n == 0 { return 1 }

            let result = powHelper(n/2) 
        
            if n%2 != 0 { return result * result * x }
        
            return result * result
        }
        
        return powHelper(n)
    }
}