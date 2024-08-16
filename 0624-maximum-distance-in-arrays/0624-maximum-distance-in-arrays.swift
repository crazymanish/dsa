class Solution {
    func maxDistance(_ arrays: [[Int]]) -> Int {
        // Initialize min and max with the first array's first and last elements
        var minVal = arrays[0].first!
        var maxVal = arrays[0].last!
        
        // Initialize the maximum distance
        var maxDistance = 0
        
        // Iterate through the arrays starting from the second one
        for i in 1..<arrays.count {
            let currentArray = arrays[i]
            let currentMin = currentArray.first!
            let currentMax = currentArray.last!
            
            // Calculate the potential maximum distances
            maxDistance = max(maxDistance, abs(currentMax - minVal))
            maxDistance = max(maxDistance, abs(maxVal - currentMin))
            
            // Update global min and max values
            minVal = min(minVal, currentMin)
            maxVal = max(maxVal, currentMax)
        }
        
        return maxDistance
    }
}