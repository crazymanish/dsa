class Solution {
    func checkValidCuts(_ rectangleCount: Int, _ rectangles: [[Int]]) -> Bool {
        let rectangleCount = rectangles.count // Store the number of rectangles for clarity
        let xStartCoordinates = rectangles.map { $0[0] } // Extract the x-start coordinates
        let yStartCoordinates = rectangles.map { $0[1] } // Extract the y-start coordinates
        let xEndCoordinates = rectangles.map { $0[2] } // Extract the x-end coordinates
        let yEndCoordinates = rectangles.map { $0[3] } // Extract the y-end coordinates

        // Helper function to check for valid cuts along a given axis (x or y)
        func checkAxisCuts(startCoordinates: [Int], endCoordinates: [Int]) -> Bool {
            var sortedIndices = Array(0..<rectangleCount).sorted { startCoordinates[$0] < startCoordinates[$1] } // Sort indices based on start coordinates
            var currentMaxEndCoordinate = endCoordinates[sortedIndices.removeFirst()] // Initialize max end coordinate with the first rectangle's end
            var cutCount = 0 // Count of valid cuts found

            // Iterate through the sorted rectangles
            for index in sortedIndices {
                // Check if a cut is possible before the current rectangle starts
                if currentMaxEndCoordinate <= startCoordinates[index] {
                    cutCount += 1 // Increment cut count
                    if cutCount >= 2 { // If we have found at least two valid cuts, return true
                        return true
                    }
                }
                // Update the maximum end coordinate if necessary
                if currentMaxEndCoordinate <= endCoordinates[index] {
                    currentMaxEndCoordinate = endCoordinates[index]
                }
            }
            return false // No valid cuts found along this axis
        }

        // Check for valid cuts along the x-axis or y-axis
        if checkAxisCuts(startCoordinates: xStartCoordinates, endCoordinates: xEndCoordinates) {
            return true
        }
        
        return checkAxisCuts(startCoordinates: yStartCoordinates, endCoordinates: yEndCoordinates)
    }
}