class Solution {
    func countRoutes(_ locations: [Int], _ start: Int, _ finish: Int, _ fuel: Int) -> Int {
        let mod = Int(1e9 + 7)
        let n = locations.count

        // cache[current][remaining fuel]
        var dpCache: [[Int?]] = Array(repeating: Array(repeating: nil, count: fuel+1), count: n)
        
        func check(_ current: Int, _ fuel: Int) -> Int {
            guard fuel >= 0 else { return 0 }
            
            if let cacheValue = dpCache[current][fuel] { return cacheValue }

            var value = 0
            if current == finish { value += 1 }
        
            for locationIndex in 0..<n {
                let remainingFuel = fuel - abs(locations[locationIndex]-locations[current])
                if locationIndex != current, remainingFuel >= 0 {
                    value = (value + check(locationIndex, remainingFuel)) % mod
                }
            }
            
            dpCache[current][fuel] = value
            return value
        }
        
        
        return check(start, fuel)
    }
}