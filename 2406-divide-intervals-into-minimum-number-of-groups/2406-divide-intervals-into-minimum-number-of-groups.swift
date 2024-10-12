class Solution {
    func minGroups(_ intervals: [[Int]]) -> Int {
		let mappedIntervals = intervals.flatMap { interval in 
			[(interval[0],1), (interval[1]+1,-1)] // (k,v) pairs for dict
		}
        
        let dict = [Int:Int](mappedIntervals, uniquingKeysWith: +)
        var overlaps = 0
        var maxOverlaps = 0
        
        for key in dict.keys.sorted() {
            overlaps += dict[key]!
            maxOverlaps = max(maxOverlaps, overlaps)
        }
        
        return maxOverlaps
    }
}