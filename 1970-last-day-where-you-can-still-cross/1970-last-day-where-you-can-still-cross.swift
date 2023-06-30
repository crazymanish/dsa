class Solution {
    func latestDayToCross(_ row: Int, _ col: Int, _ cells: [[Int]]) -> Int {
        let count = cells.count
        let dsu = DSU(row * col+2)
        let lastRow = (row-1)*col
        var cellIndices: Set<Int> = []
        
        for i in 0..<col {
            dsu.union(i+1, 0)
            dsu.union(lastRow+i+1, row * col + 1)
        }
        
        for i in (0..<count).reversed() {
            let cell = cells[i]
            let curRow = cell[0] - 1
            let curCol = cell[1] - 1
            let cellIndex = curRow * col + curCol
            
            for pair in [(-1,0),(1,0),(0,-1),(0,1)] {
                let nextRow = curRow + pair.0
                if nextRow < 0 || nextRow >= row { continue }
                let nextCol = curCol + pair.1
                if nextCol < 0 || nextCol >= col { continue }
                let nextCellIndex = nextRow * col + nextCol
                if cellIndices.contains(nextCellIndex) {
                    dsu.union(cellIndex+1, nextCellIndex+1)
                }
            }
            
            cellIndices.insert(cellIndex)
            
            if dsu.find(0) == dsu.find(row * col+1) { return i }
        }
        
        return -1
    }
}

class DSU {
    private var roots: [Int]
    private var ranks: [Int]
    
    init(_ n: Int) {
        roots = Array(0..<n)
        ranks = Array(repeating: 0, count: n)
    }
    
    func find(_ value: Int) -> Int {
        var parent = roots[value]
        
        while parent != roots[parent] {
            roots[parent] = roots[roots[parent]]
            parent = roots[parent]
        }
        
        return parent
    }
    
    func union(_ x: Int, _ y: Int) {
        let rx = find(x)
        let ry = find(y)
        if rx == ry { return }
        
        if ranks[rx] > ranks[ry] {
            roots[ry] = rx
        } else {
            roots[rx] = ry
            if ranks[rx] == ranks[ry] {
                ranks[ry] += 1
            }
        }
    }
}
