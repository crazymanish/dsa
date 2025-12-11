/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(m), where m = buildings.count
///     - We process each building twice (once when building maps, once when checking).
///
/// Space Complexity:
///   • O(m)
///     - Maps store min/max coordinates for each distinct x or y.
/// 
/// Explanation:
///   For each x coordinate, we compute the min and max y among all buildings with
///   that x. Same for each y coordinate (min and max x).
///
///   A building at (x, y) is *covered* if:
///       - It is strictly inside its vertical range at x   → yMin < y < yMax
///       - It is strictly inside its horizontal range at y → xMin < x < xMax
///
///   Buildings exactly on the boundary (endpoints) are NOT counted.
/// ---------------------------------------------------------------------------

class Solution {
    func countCoveredBuildings(_ n: Int, _ buildings: [[Int]]) -> Int {
        
        // Maps:
        //   x → [minY, maxY]
        //   y → [minX, maxX]
        var minMaxYForX = [Int: (min: Int, max: Int)]()
        var minMaxXForY = [Int: (min: Int, max: Int)]()
        
        // Step 1: Build min/max ranges for each x and each y
        for building in buildings {
            let x = building[0]
            let y = building[1]
            
            // Update vertical span for this x coordinate
            if let current = minMaxYForX[x] {
                minMaxYForX[x] = (min(current.min, y), max(current.max, y))
            } else {
                minMaxYForX[x] = (y, y)
            }
            
            // Update horizontal span for this y coordinate
            if let current = minMaxXForY[y] {
                minMaxXForY[y] = (min(current.min, x), max(current.max, x))
            } else {
                minMaxXForY[y] = (x, x)
            }
        }
        
        // Step 2: Count buildings strictly inside both their row-range and column-range
        var coveredCount = 0
        
        for building in buildings {
            let x = building[0]
            let y = building[1]
            
            guard let yRange = minMaxYForX[x],
                  let xRange = minMaxXForY[y] else { continue }
            
            let insideVerticalRange = y > yRange.min && y < yRange.max
            let insideHorizontalRange = x > xRange.min && x < xRange.max
            
            if insideVerticalRange && insideHorizontalRange {
                coveredCount += 1
            }
        }
        
        return coveredCount
    }
}
