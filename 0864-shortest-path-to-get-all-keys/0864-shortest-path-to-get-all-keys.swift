class Solution {
    func shortestPathAllKeys(_ grid: [String]) -> Int {
        var startingPoint = Point(x: -1, y: -1)
        var keySet: Set<String> = []
        
        for row in 0..<grid.count {
            for column in 0..<grid[row].count {
                if grid[row][column].isLowercase {
                    let char = grid[row][column]
                    keySet.insert(String(char))
                } else if grid[row][column] == "@" {
                    startingPoint = Point(x: row, y: column)
                }
            }
        }
        
        let keys = "abcdef"
        let locks = "ABCDEF"
        var result = 0
        var queue: [(Point, String)] = []
        queue.append((startingPoint, ""))
        var visited: Set<String> = Set(["\(startingPoint.x)-\(startingPoint.y)-\("")"])
        
        while queue.count != 0 {
            for _ in 0..<queue.count {
                let (currentPoint, currentKey) = queue.removeFirst()
        
                if currentKey.count == keySet.count { return result }
                
                let directions = [
                    (currentPoint.x-1, currentPoint.y), 
                    (currentPoint.x, currentPoint.y+1), 
                    (currentPoint.x+1, currentPoint.y), 
                    (currentPoint.x, currentPoint.y-1)
                ]
                for (row, column) in directions {
                    if (row < 0 || row >= grid.count || column < 0 || column >= grid[0].count || grid[row][column] == "#") { continue }
                    
                    let hashedkey = "\(row)-\(column)-\(currentKey)"
                    if (visited.contains(hashedkey)) { continue }
                    
                    if locks.contains(grid[row][column]) && currentKey.contains(grid[row][column].lowercased()) == false { continue }
                    
                    var newKey = currentKey
                    if keys.contains(grid[row][column]) && currentKey.contains(grid[row][column]) == false {
                        newKey += String(grid[row][column])
                    }
                    
                    let newPoint = Point(x: row, y: column)
                    queue.append((newPoint, newKey))
                    visited.insert(hashedkey)
                }
            }
            result += 1
        }
        
        return -1
    }
}

extension Solution {
    struct Point {
        let x: Int
        let y: Int
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
    subscript(range: Range<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence { self[index(startIndex, offsetBy: range.lowerBound)...] }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence { self[...index(startIndex, offsetBy: range.upperBound)] }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence { self[..<index(startIndex, offsetBy: range.upperBound)] }
}