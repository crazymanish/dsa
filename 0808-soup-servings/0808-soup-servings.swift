class Solution {
    func soupServings(_ n: Int) -> Double {
        guard n <= 4800 else { return 1 }
        
        var cache: [String: Double] = [:]
        
        func serve(_ quantityA: Int, _ quantityB: Int) -> Double {
            let cacheKey = "\(quantityA),\(quantityB)"
            
            if let cacheResult = cache[cacheKey] { return cacheResult }
           
            guard quantityA > 0 || quantityB > 0 else { return 0.5 }
            guard quantityA > 0 else { return 1.0 }
            guard quantityB > 0 else { return 0.0 }
            
            let op1 = serve(quantityA-100, quantityB)
            let op2 = serve(quantityA-75, quantityB-25)
            let op3 = serve(quantityA-50, quantityB-50)
            let op4 = serve(quantityA-25, quantityB-75)
            
            cache[cacheKey] = 0.25*op1 + 0.25*op2 + 0.25*op3 + 0.25*op4
            return cache[cacheKey]!
        }
        
        return serve(n, n)
    }
}