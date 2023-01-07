class Solution {
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        let stationCount = gas.count
        var startingStation = 0, gasSurplus = 0, gasDeficit = 0
        
        for stationIndex in 0..<stationCount {
            var gasBalance = gas[stationIndex] - cost[stationIndex]
            if gasBalance + gasSurplus >= 0 {
                gasSurplus += gasBalance
            } else {
                startingStation = stationIndex + 1
                gasDeficit += (gasBalance + gasSurplus)
                gasSurplus = 0
            }
        }
        
        return (gasSurplus + gasDeficit >= 0) ? startingStation : -1
    }
}