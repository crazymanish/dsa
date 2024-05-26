class Solution {
    struct CacheKey: Hashable {
        var usedA: Bool
        var lCount: Int
        var length: Int
        init(_ usedA: Bool, _ lCount: Int, _ length: Int ) {
            self.usedA = usedA
            self.lCount = lCount
            self.length = length
        }
    }
    
    func checkRecord(_ n: Int) -> Int {
        let modulus = 1000000007
        
        func helper(_ usedA: Bool, _ lCount: Int, _ length: Int) -> Int {
            guard length > 0 else { return 1 }
            if let val = cache[CacheKey(usedA,lCount,length)] {
                return val
            }
            
            var res = 0
            if !usedA {
                res += helper(true, 0, length - 1) 
            }
            
            if lCount < 2 {
                res  = (res + helper(usedA, lCount + 1, length - 1)) % modulus
            }
            
            res = (res + helper(usedA, 0, length - 1)) % modulus
            cache[CacheKey(usedA,lCount,length)] = res
            return res
        }
        
        var cache = [CacheKey: Int]()
        return helper(false, 0, n)
    }
}