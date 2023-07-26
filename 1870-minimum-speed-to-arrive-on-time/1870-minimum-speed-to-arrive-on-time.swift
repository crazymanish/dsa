class Solution {
    // The minimum possible speed is 1 kilometer per hour. 
    // The maximum reasonable speed is maxDist kilometers per hour, except for the case when there is less than 1 hour left to overcome the last distance. 
    // Solution is between minimum possible speed and maximum reasonable speed. Let's find solution using binary search
    func minSpeedOnTime(_ dist: [Int], _ hour: Double) -> Int {
        let n = dist.count
        let intHour = Int(hour.rounded(.up))
        
        guard intHour >= n else { return -1 }
        
        let maxDist = dist.max()!
        let lastHour = hour == hour.rounded(.down) ? 1.0 : (hour - hour.rounded(.down))
        
        var left = 1
        var right = intHour > n ? maxDist : max(maxDist, Int((Double(dist.last!) / lastHour).rounded(.up)))
        
        while left < right {
            let mid = (left + right) / 2
            
            var totalTime = 0.0
            for i in 0..<(n-1) {
                totalTime += (Double(dist[i]) / Double(mid)).rounded(.up)
            }
            
            totalTime += Double(dist.last!) / Double(mid)
            
            if totalTime > hour {
                left = mid + 1
            } else {
                right = mid
            }
        }
        
        return left
    }
}