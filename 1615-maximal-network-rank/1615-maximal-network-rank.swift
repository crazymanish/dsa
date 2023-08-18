class Solution {
    func maximalNetworkRank(_ n: Int, _ roads: [[Int]]) -> Int {
        var citiesCount: [Int: Int] = [:]
        for road in roads {
            var cacheValue = citiesCount[road.first!] ?? 0
            citiesCount[road.first!] = cacheValue + 1
            
            cacheValue = citiesCount[road.last!] ?? 0
            citiesCount[road.last!] = cacheValue + 1
        }
        
        var maxNetwork: Int = 0
        for firstCity in 0..<n-1 {
            for secondCity in (firstCity+1)..<n {
                var currentTotalNetwork = (citiesCount[firstCity] ?? 0) + (citiesCount[secondCity] ?? 0)
                
                if roads.contains(where: { road in
                    return road.contains(firstCity) && road.contains(secondCity)
                }) {
                    currentTotalNetwork -= 1
                }
                maxNetwork = max(maxNetwork, currentTotalNetwork)
            }
        }
        
        return maxNetwork
    }
}