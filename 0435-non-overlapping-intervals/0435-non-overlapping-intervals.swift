class Solution {
    func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
        var removedIntervalscount = 0
        
        guard intervals.count > 1 else { return removedIntervalscount }
    
        let sortedIntervals = intervals.sorted(by: { $0[1] < $1[1] })
        var previousIntervalEnd = sortedIntervals[0][1]
    
        for currentIndex in 1..<sortedIntervals.count {
            if sortedIntervals[currentIndex][0] < previousIntervalEnd {
                removedIntervalscount += 1
            } else {
                previousIntervalEnd = sortedIntervals[currentIndex][1]
            }
        }
    
        return removedIntervalscount
    }
}