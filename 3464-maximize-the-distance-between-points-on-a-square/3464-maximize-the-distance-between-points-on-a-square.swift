/**
 Problem Summary:
 Given points located on the boundary of a square of side length `sideLength`,
 select `requiredPoints` such that the minimum distance between consecutive
 selected points along the perimeter is maximized.

 Strategy:
 1. Convert each 2D boundary point into a 1D position along the square perimeter.
 2. Sort the perimeter positions.
 3. Duplicate the sorted positions by adding `perimeterLength` to simulate circular traversal.
 4. Binary search the maximum possible minimum distance.
 5. For each candidate distance:
    - Try every point as the starting point.
    - Greedily select the next point at least `minDistance` away.
    - Validate the final wrap-around distance back to the start.

 Time Complexity:
 O(n log n + n log n log sideLength)

 Space Complexity:
 O(n)
 */

class Solution {
    func maxDistance(_ sideLength: Int, _ points: [[Int]], _ requiredPoints: Int) -> Int {
        // Maps a 2D boundary point to its 1D position along the square perimeter.
        func mapToPerimeterPosition(_ point: [Int]) -> Int {
            let x = point[0]
            let y = point[1]
            
            // Walk clockwise starting from the bottom-left corner (0, 0).
            if y == 0 { return x }                           // Bottom edge
            if x == sideLength { return sideLength + y }     // Right edge
            if y == sideLength { return 3 * sideLength - x } // Top edge
            return 4 * sideLength - y                        // Left edge
        }
        
        // Returns the first index where `sortedArray[index] >= target`.
        func lowerBound(_ sortedArray: [Int], _ target: Int) -> Int {
            var left = 0
            var right = sortedArray.count
            
            while left < right {
                let mid = left + (right - left) / 2
                
                if sortedArray[mid] < target {
                    left = mid + 1
                } else {
                    right = mid
                }
            }
            
            return left
        }
        
        let perimeterLength = 4 * sideLength
        
        // Convert all boundary points into sorted 1D perimeter positions.
        let perimeterPositions = points.map(mapToPerimeterPosition).sorted()
        let pointCount = perimeterPositions.count
        
        // Duplicate positions to make circular traversal easier.
        var extendedPositions = perimeterPositions
        for position in perimeterPositions {
            extendedPositions.append(position + perimeterLength)
        }
        
        // Checks whether it is possible to select `requiredPoints`
        // so every neighboring pair on the circle is at least `minDistance` apart.
        func canSelectPoints(withMinimumDistance minDistance: Int) -> Bool {
            // Try each original point as the first selected point.
            for startIndex in 0..<pointCount {
                let startPosition = extendedPositions[startIndex]
                
                var selectedCount = 1
                var currentIndex = startIndex
                
                // Greedily choose the earliest next point that is far enough away.
                while selectedCount < requiredPoints {
                    let nextRequiredPosition = extendedPositions[currentIndex] + minDistance
                    let nextIndex = lowerBound(extendedPositions, nextRequiredPosition)
                    
                    // Cannot use more than one full perimeter cycle.
                    if nextIndex >= startIndex + pointCount {
                        break
                    }
                    
                    currentIndex = nextIndex
                    selectedCount += 1
                }
                
                // Besides placing k points linearly, the last selected point must also
                // be at least `minDistance` away from the start after wrapping around.
                if selectedCount == requiredPoints &&
                    extendedPositions[currentIndex] + minDistance <= startPosition + perimeterLength {
                    return true
                }
            }
            
            return false
        }
        
        // Binary search for the largest feasible minimum distance.
        var left = 0
        var right = sideLength + 1
        
        while left < right {
            let midDistance = left + (right - left) / 2
            
            if canSelectPoints(withMinimumDistance: midDistance) {
                left = midDistance + 1
            } else {
                right = midDistance
            }
        }
        
        return left - 1
    }
}