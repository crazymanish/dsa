/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n log n)
///     - Sorting events by end time: O(n log n)
///     - For each event, binary search among previous events: O(log n)
///
/// Space Complexity:
///   • O(n)
///     - Prefix array storing the maximum value seen so far.
///
/// Problem Summary:
///   Each event is represented as [start, end, value].
///   We want to select at most TWO non-overlapping events such that
///   the total value is maximized.
///
/// Approach:
///   1. Sort events by their end time.
///   2. Maintain a prefix array `maxValueUpTo[i]` storing the maximum
///      event value among events[0...i].
///   3. For each event i:
///        - Use binary search to find the latest event j < i
///          whose end time is strictly less than event i's start time.
///        - Combine event i's value with the best value up to j.
/// ---------------------------------------------------------------------------

class Solution {
    func maxTwoEvents(_ events: [[Int]]) -> Int {
        // Sort events by end time
        let sortedEvents = events.sorted { $0[1] < $1[1] }
        let n = sortedEvents.count
        
        // maxValueUpTo[i] = maximum value of any event in range [0...i]
        var maxValueUpTo = Array(repeating: 0, count: n)
        
        var bestTotalValue = 0
        
        for i in 0..<n {
            let startTime = sortedEvents[i][0]
            let endTime   = sortedEvents[i][1]
            let value     = sortedEvents[i][2]
            
            // Binary search for the last event that ends before startTime
            var left = 0
            var right = i - 1
            var bestPreviousValue = 0
            
            while left <= right {
                let mid = (left + right) / 2
                if sortedEvents[mid][1] < startTime {
                    bestPreviousValue = max(bestPreviousValue, maxValueUpTo[mid])
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            }
            
            // Update the answer using current event + best non-overlapping event
            bestTotalValue = max(bestTotalValue, value + bestPreviousValue)
            
            // Update prefix maximum
            let previousMax = i > 0 ? maxValueUpTo[i - 1] : 0
            maxValueUpTo[i] = max(previousMax, value)
        }
        
        return bestTotalValue
    }
}
