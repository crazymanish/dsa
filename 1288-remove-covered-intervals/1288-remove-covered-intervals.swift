class Solution {
    /**
     Problem Summary:
     Given a list of intervals, remove every interval that is fully covered by another interval.
     Return the number of intervals remaining.

     Strategy:
     Sort intervals by:
     - Start ascending
     - End descending when starts are equal

     After sorting, if an interval's end is less than or equal to the farthest end seen so far,
     it is covered by a previous interval.

     Time Complexity: O(n log n)
     Space Complexity: O(n), because sorting creates a sorted copy
     */
    func removeCoveredIntervals(_ intervals: [[Int]]) -> Int {
        let sortedIntervals = intervals.sorted {
            if $0[0] == $1[0] {
                return $0[1] > $1[1]
            }

            return $0[0] < $1[0]
        }

        var remainingIntervalCount = 0
        var farthestEnd = 0

        for interval in sortedIntervals {
            let currentEnd = interval[1]

            // If currentEnd is greater than any previous end,
            // this interval is not covered by an earlier interval.
            if currentEnd > farthestEnd {
                remainingIntervalCount += 1
                farthestEnd = currentEnd
            }
        }

        return remainingIntervalCount
    }
}