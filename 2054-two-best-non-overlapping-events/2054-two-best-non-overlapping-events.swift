class Solution {
    func maxTwoEvents(_ events: [[Int]]) -> Int {
        let sortedEvents = events.sorted { $0[1] < $1[1] }
        var maxSum = 0
        var maxValues = [Int](repeating: 0, count: sortedEvents.count)
    
        for i in 0..<sortedEvents.count {
            let currentEvent = sortedEvents[i]
            let currentValue = currentEvent[2]
        
            // Binary search to find the best non-overlapping event
            var left = 0
            var right = i - 1
            var bestValue = 0
        
            while left <= right {
                let mid = (left + right) / 2
                if sortedEvents[mid][1] < currentEvent[0] {
                    bestValue = max(bestValue, maxValues[mid])
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            }
        
            maxSum = max(maxSum, currentValue + bestValue)
            maxValues[i] = max(i > 0 ? maxValues[i - 1] : 0, currentValue)
        }
    
        return maxSum
    }
}