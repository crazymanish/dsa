class Solution {
    /*
     Time Complexity: O(n log M)
     - n = number of cities
     - M = range of possible power values (max power + extraStations)
     Each binary search iteration performs an O(n) feasibility check.
     
     Space Complexity: O(n)
     - Arrays for totalPower and differenceArray.
    */
    
    func maxPower(_ stations: [Int], _ coverageRadius: Int, _ extraStations: Int) -> Int {
        let cityCount = stations.count
        var totalPower = [Int](repeating: 0, count: cityCount)
        var currentWindowSum = 0
        
        // Compute initial window sum for the first few cities within coverage
        for i in 0...min(cityCount - 1, coverageRadius) {
            currentWindowSum += stations[i]
        }
        
        // Precompute total power each city initially receives using a sliding window
        for cityIndex in 0..<cityCount {
            totalPower[cityIndex] = currentWindowSum
            
            // Slide the window: remove leftmost city, add next rightmost city
            let removeIndex = cityIndex - coverageRadius
            if removeIndex >= 0 {
                currentWindowSum -= stations[removeIndex]
            }
            let addIndex = cityIndex + coverageRadius + 1
            if addIndex < cityCount {
                currentWindowSum += stations[addIndex]
            }
        }
        
        // Binary search to maximize the minimum achievable city power
        var low = 0
        var high = (totalPower.max() ?? 0) + extraStations
        var bestMinimumPower = 0
        
        while low <= high {
            let mid = low + (high - low) / 2
            if canAchieveTargetPower(totalPower, coverageRadius, extraStations, mid) {
                bestMinimumPower = mid
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        
        return bestMinimumPower
    }
    
    // Checks if every city can reach at least `targetPower` using ≤ extraStations
    private func canAchieveTargetPower(_ totalPower: [Int], _ coverageRadius: Int, _ extraStations: Int, _ targetPower: Int) -> Bool {
        let cityCount = totalPower.count
        var stationsUsed = 0
        var differenceArray = [Int](repeating: 0, count: cityCount + 1)
        var accumulatedAddedPower = 0
        
        for cityIndex in 0..<cityCount {
            accumulatedAddedPower += differenceArray[cityIndex]
            let currentCityPower = totalPower[cityIndex] + accumulatedAddedPower
            
            // If city power is below target, add enough stations to cover the deficit
            if currentCityPower < targetPower {
                let requiredPower = targetPower - currentCityPower
                stationsUsed += requiredPower
                if stationsUsed > extraStations {
                    return false // Exceeded available stations
                }
                
                accumulatedAddedPower += requiredPower
                let effectEndIndex = min(cityCount, cityIndex + 2 * coverageRadius + 1)
                differenceArray[effectEndIndex] -= requiredPower
            }
        }
        
        return true
    }
}
