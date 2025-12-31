/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(R * C * α(R * C))
///     - R = number of rows, C = number of columns
///     - We process each cell once in reverse
///     - Each union/find operation is amortized inverse-Ackermann (α)
///
/// Space Complexity:
///   • O(R * C)
///     - DSU structures
///     - Set to track land cells
///
/// Problem Summary:
///   We want the latest day when it is still possible to cross from the
///   top row to the bottom row using only land cells.
///
/// Key Insight:
///   Instead of simulating days forward (flooding land → water),
///   we process days in reverse:
///     - Start with all water
///     - Add land cells back one by one
///     - Use Union-Find to check when top and bottom become connected
///
/// Two virtual nodes are used:
///     - TOP (0)
///     - BOTTOM (R*C + 1)
/// ---------------------------------------------------------------------------

class Solution {
    func latestDayToCross(_ rowCount: Int, _ colCount: Int, _ cells: [[Int]]) -> Int {
        let totalCells = rowCount * colCount
        let topVirtual = 0
        let bottomVirtual = totalCells + 1
        
        // DSU size = total cells + 2 virtual nodes
        let dsu = DSU(totalCells + 2)
        
        // Track which cells are currently land
        var landCells = Set<Int>()
        
        // Connect top row cells to TOP virtual node
        for col in 0..<colCount {
            dsu.union(topVirtual, col + 1)
        }
        
        // Connect bottom row cells to BOTTOM virtual node
        let bottomRowStart = (rowCount - 1) * colCount
        for col in 0..<colCount {
            dsu.union(bottomVirtual, bottomRowStart + col + 1)
        }
        
        // Process days in reverse (adding land back)
        for day in stride(from: cells.count - 1, through: 0, by: -1) {
            let r = cells[day][0] - 1
            let c = cells[day][1] - 1
            let index = r * colCount + c
            let dsuIndex = index + 1   // offset because 0 is TOP
            
            // Check 4-directional neighbors
            for (dr, dc) in [(-1,0), (1,0), (0,-1), (0,1)] {
                let nr = r + dr
                let nc = c + dc
                
                guard nr >= 0, nr < rowCount, nc >= 0, nc < colCount else {
                    continue
                }
                
                let neighborIndex = nr * colCount + nc
                if landCells.contains(neighborIndex) {
                    dsu.union(dsuIndex, neighborIndex + 1)
                }
            }
            
            // Mark this cell as land
            landCells.insert(index)
            
            // If top and bottom are connected, crossing is possible
            if dsu.find(topVirtual) == dsu.find(bottomVirtual) {
                return day
            }
        }
        
        return -1
    }
}

class DSU {
    private var parent: [Int]
    private var rank: [Int]
    
    init(_ size: Int) {
        parent = Array(0..<size)
        rank = Array(repeating: 0, count: size)
    }
    
    func find(_ x: Int) -> Int {
        if parent[x] != x {
            parent[x] = find(parent[x])   // Path compression
        }
        return parent[x]
    }
    
    func union(_ x: Int, _ y: Int) {
        let rootX = find(x)
        let rootY = find(y)
        
        guard rootX != rootY else { return }
        
        // Union by rank
        if rank[rootX] < rank[rootY] {
            parent[rootX] = rootY
        } else if rank[rootX] > rank[rootY] {
            parent[rootY] = rootX
        } else {
            parent[rootY] = rootX
            rank[rootX] += 1
        }
    }
}
