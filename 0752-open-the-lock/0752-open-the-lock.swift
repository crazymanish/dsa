class Solution {
    func openLock(_ deadends: [String], _ target: String) -> Int {
        let deadEndValues = deadends.map{$0.compactMap { Int("\($0)") }}
        let targetValue = target.compactMap{Int("\($0)")}
        
        if deadends.contains("0000") { return -1 }
        
        var queue = [[0, 0, 0, 0]]
        var visitedSet = Set(queue)
        var turns = 0
        
        while !queue.isEmpty {
            let countOfQueue = queue.count
            for index in 0..<countOfQueue {
                let currentLockPattern = queue.removeFirst()
                if deadEndValues.contains(currentLockPattern) { continue }
                
                if currentLockPattern == targetValue { return turns }

                for i in 0...3 {
                    for digit in stride(from: -1, through: 1, by: 2) {
                        var lockPattern : [Int] = currentLockPattern
                        lockPattern[i] = ((lockPattern[i] + digit) + 10) % 10
                         
                        if !visitedSet.contains(lockPattern) && !deadEndValues.contains(lockPattern) {
                             queue.append(lockPattern)
                             visitedSet.insert(lockPattern)
                         }
                     }
                 }
             }
            
             turns += 1
         }  
          
        return -1  
    }
}