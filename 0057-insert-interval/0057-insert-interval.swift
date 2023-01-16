class Solution {
    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        var result: [[Int]] = []
        
        for index in 0..<intervals.count {
            if newInterval[0] <= intervals[index][1] {
                var currentIndex = index
                let newStart = min(intervals[index][0], newInterval[0])
                var newEnd = newInterval[1]
                
                if newInterval[1] >= intervals[index][0] {
                    newEnd = max(newInterval[1], intervals[index][1])
                    
                    while currentIndex < intervals.count && newEnd >= intervals[currentIndex][0] {
                        newEnd = max(newEnd, intervals[currentIndex][1])
                        currentIndex += 1
                    }
                }
                
                result.append(contentsOf: [[newStart, newEnd]] + intervals[currentIndex...])
                return result
            } else {
                result.append(intervals[index])
            }
        }
        
        result.append(newInterval)
        return result
    }
}