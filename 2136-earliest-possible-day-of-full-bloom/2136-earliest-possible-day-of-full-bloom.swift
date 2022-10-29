class Solution {
    func earliestFullBloom(_ plantTime: [Int], _ growTime: [Int]) -> Int {        
        var combos = [(Int, Int)]()
        
        for i in 0 ..< plantTime.count {
            combos.append((plantTime[i], growTime[i]))
        }
        
        combos.sort { $0.1 > $1.1 }
        
        var growingDone = 0
        var plantingDone = 0
        for combo in combos {
            plantingDone += combo.0
            growingDone = max(growingDone, plantingDone + combo.1)
        }
        
        return growingDone
    }
}