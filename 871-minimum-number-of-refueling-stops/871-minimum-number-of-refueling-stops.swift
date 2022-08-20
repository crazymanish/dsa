class Solution {
    func minRefuelStops(_ target: Int, _ startFuel: Int, _ stations: [[Int]]) -> Int {
        if startFuel >= target { return 0 }
        
        let fuelRatio = 1 // Number of liters per mile
        var reachableDistancesPerStops: [Int] = Array(repeating: 0, count: stations.count + 1)
        // distance we can reach with 0 stops
        reachableDistancesPerStops[0] = startFuel / fuelRatio
        
        // initialize with unreachable number of stops
        var minimumNumberOfStops = stations.count + 1
        
        for stationIndex in 0..<stations.count {
            reverseLoop: for numberOfStops in (0...stationIndex).lazy.reversed() {
                // check if this station is reachable by `i` stops
                let isReachable = reachableDistancesPerStops[numberOfStops] >= stations[stationIndex][0]
                
                guard isReachable else {
                    // if this station is not reachble by i stops then it can't be reached by any numberOfStops < i
                    break reverseLoop
                }
                
                let maximumDistance = reachableDistancesPerStops[numberOfStops] + stations[stationIndex][1] / fuelRatio
                reachableDistancesPerStops[numberOfStops + 1] = max(reachableDistancesPerStops[numberOfStops + 1], maximumDistance)
                
                if reachableDistancesPerStops[numberOfStops + 1] >= target {
                    minimumNumberOfStops = min(minimumNumberOfStops, numberOfStops + 1)
                }
            }
        }
        
        // minimumNumberOfStops changed during the loop, then target is reachable
        if minimumNumberOfStops <= stations.count {
            return minimumNumberOfStops
        } else {
            return -1 // target is unreachable
        }
    }
}
