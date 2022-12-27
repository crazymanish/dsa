class Solution {
    func maximumBags(_ capacity: [Int], _ rocks: [Int], _ additionalRocks: Int) -> Int {
        var maximumBags = 0
        var remainingRocks = additionalRocks
        
        var bagsByRemainingCapacity = Array(repeating: 0, count: capacity.count)
        for i in 0..<capacity.count {
            bagsByRemainingCapacity[i] = capacity[i] - rocks[i]
        }
        
        bagsByRemainingCapacity.sort();
        
        for i in 0..<bagsByRemainingCapacity.count {
            if bagsByRemainingCapacity[i] == 0 {
                maximumBags += 1
            } else if remainingRocks >= bagsByRemainingCapacity[i] {
                remainingRocks = remainingRocks - bagsByRemainingCapacity[i]
                maximumBags += 1
            } else {
                break
            }
        }
        
        return maximumBags
    }
}