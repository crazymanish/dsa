/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n² logC)
///     - We examine all O(n²) point pairs.
///     - Each gcd is O(logC) where C is coordinate magnitude.
///     - Hash map operations are amortized O(1).
///
/// Space Complexity:
///   • O(n²)
///     - We store information about all unique point pairs.
///
/// High-Level Explanation:
///
/// For each pair of points, we compute:
///   • Direction vector reduced to unit form: (sx, sy)
///   • Line offset (intercept-like value):    des = sx*y - sy*x
///
/// t: groups by *direction*, used for counting all parallel pairs.
/// v: groups by *raw vector*, used to subtract overcounted symmetric ones.
///
/// The formula:
///       total_trapezoids = count(direction groups)
///                        - count(raw vector groups) / 2
///
/// count(map):
///   For each direction group, lines are grouped by unique 'des'.
///   If a direction has k lines, trapezoids = sum_{i<j} lines[i] * lines[j].
/// ---------------------------------------------------------------------------

class Solution {
    func countTrapezoids(_ points: [[Int]]) -> Int {
        var directionGroups = [Int: [Int: Int]]()    // directionKey → (des → count)
        var vectorGroups = [Int: [Int: Int]]()       // rawVectorKey → (des → count)
        let n = points.count

        /// Insert (des) under (map[key]):
        func insert(_ map: inout [Int: [Int: Int]], _ key: Int, _ des: Int) {
            if map[key] == nil { map[key] = [:] }
            map[key]![des, default: 0] += 1
        }

        // Loop over all point pairs
        for i in 0..<n {
            let x1 = points[i][0], y1 = points[i][1]
            
            for j in i+1..<n {
                let x2 = points[j][0], y2 = points[j][1]
                
                var dx = x2 - x1
                var dy = y2 - y1

                // Normalize orientation so (dx, dy) is lexicographically positive
                if dx < 0 || (dx == 0 && dy < 0) {
                    dx = -dx
                    dy = -dy
                }

                // Reduce direction to unit form using gcd
                let g = gcd(dx, abs(dy))
                let sx = dx / g        // unit direction x
                let sy = dy / g        // unit direction y

                // "des" uniquely identifies offset of the line perpendicular to direction
                let des = sx * y1 - sy * x1

                // Pack direction into a single integer key
                let directionKey = (sx << 12) | (sy + 2000)

                // Pack raw vector into another key (keeps lengths distinct)
                let rawVectorKey = (dx << 12) | (dy + 2000)

                // Insert into both maps
                insert(&directionGroups, directionKey, des)
                insert(&vectorGroups, rawVectorKey, des)
            }
        }

        // Final trapezoid count:
        // directionGroups counts all parallelogram-like configs
        // vectorGroups removes mirrored overcounting
        return computePairs(directionGroups) - computePairs(vectorGroups) / 2
    }

    /// Count unordered pairs inside each nested map.
    /// For inner map {des1: a, des2: b, des3: c}, add a*b + a*c + b*c ...
    private func computePairs(_ map: [Int: [Int: Int]]) -> Int {
        var totalPairs = 0
        
        for inner in map.values {
            let totalCount = inner.values.reduce(0, +)
            var remaining = totalCount
            
            for count in inner.values {
                remaining -= count
                totalPairs += count * remaining
            }
        }
        return totalPairs
    }

    /// Standard Euclidean gcd
    private func gcd(_ a: Int, _ b: Int) -> Int {
        var x = abs(a), y = abs(b)
        while y != 0 {
            let t = x % y
            x = y
            y = t
        }
        return x
    }
}
