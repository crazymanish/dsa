class Solution {
    func numBusesToDestination(_ routes: [[Int]], _ S: Int, _ T: Int) -> Int {     
        if S == T { return 0 }
        
        var stationAndBusMap = [Int: Set<Int>]()
        for i in routes.indices {
            for station in routes[i] {
                var sets = stationAndBusMap[station, default: Set<Int>()]
                sets.insert(i)
                stationAndBusMap[station] = sets
            }
        }
        
        let srcBuses = stationAndBusMap[S, default: Set<Int>()]
        let dstBuses = stationAndBusMap[T, default: Set<Int>()]
        
        if srcBuses.count == 0 || dstBuses.count == 0 { return -1 }

        var usedBuses = Set<Int>()
        var curBuses = srcBuses
        var answer = 1
        
        while curBuses.intersection(dstBuses).count == 0 && curBuses.count > 0 {
            usedBuses = usedBuses.union(curBuses)
            answer += 1
            var nextBuses = Set<Int>()
            
            for bus in curBuses {
                for staion in routes[bus] {
                    let buses = stationAndBusMap[staion, default: Set<Int>()]
                    for bs in buses where !usedBuses.contains(bs) {
                        nextBuses.insert(bs)
                    }
                }
            }
            
            curBuses = nextBuses
        }
        
        return curBuses.count == 0 ? -1 : answer
    }
}