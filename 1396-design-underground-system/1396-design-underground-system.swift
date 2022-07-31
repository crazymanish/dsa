class UndergroundSystem {
    var hashMapCheckInInfo: [Int : [String : Int]] = [:]
    var hashMapStationInfo: [String: [String : [Int]]] = [:]
    
    init() {}
    
    func checkIn(_ id: Int, _ stationName: String, _ t: Int) {
        hashMapCheckInInfo[id] = [stationName : t]
    }
    
    func checkOut(_ id: Int, _ stationName: String, _ t: Int) {
        let checkInInfo = hashMapCheckInInfo[id]!
        let checkInStationName = checkInInfo.keys.first!
        let checkInTime = checkInInfo[checkInStationName]!

        var cacheStationInfo = hashMapStationInfo[checkInStationName] ?? [:]
        let cacheDestinationInfo = cacheStationInfo[stationName] ?? []
        cacheStationInfo[stationName] = cacheDestinationInfo + [(t-checkInTime)]
        hashMapStationInfo[checkInStationName] = cacheStationInfo
    }
    
    func getAverageTime(_ startStation: String, _ endStation: String) -> Double {
        let startStationInfo = hashMapStationInfo[startStation]!
        let endStationTimes = startStationInfo[endStation]!
        
        var totalTime = 0
        for time in endStationTimes { totalTime += time }
        
        return Double(totalTime) / Double(endStationTimes.count)
    }
}

/**
 * Your UndergroundSystem object will be instantiated and called as such:
 * let obj = UndergroundSystem()
 * obj.checkIn(id, stationName, t)
 * obj.checkOut(id, stationName, t)
 * let ret_3: Double = obj.getAverageTime(startStation, endStation)
 */