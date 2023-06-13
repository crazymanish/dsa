class Solution {
    func equalPairs(_ grid: [[Int]]) -> Int {
        let rowHashMap = Dictionary<[Int],Int>(zip(grid, sequence(first:1, next:{_ in 1})), uniquingKeysWith: +)
        
        var equalPairs = 0
        for columnIndex in 0..<grid.count {
            let column = grid.map { $0[columnIndex] }
            equalPairs += rowHashMap[column, default: 0]
        }
        
        return equalPairs
    }
}