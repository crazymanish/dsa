// Time Complexity: O(N log N)
// Space Complexity: O(N)
final class Solution {
    // Memoization table to store results of subproblems.
    // memo[k][i] stores the max value using k events starting from index i.
    private var memo: [[Int]] = []

    // Precomputed array to quickly find the next non-overlapping event.
    private var nextAvailableIndex: [Int] = []
    
    func maxValue(_ events: [[Int]], _ k: Int) -> Int {
        // Sort events by their start day to enable chronological processing.
        let sortedEvents = events.sorted { $0[0] < $1[0] }
        let eventCount = sortedEvents.count
        
        // Precompute the next available event index for each event.
        nextAvailableIndex = [Int](repeating: 0, count: eventCount)
        for i in 0..<eventCount {
            let currentEndDay = sortedEvents[i][1]
            nextAvailableIndex[i] = findNextEventIndex(in: sortedEvents, after: currentEndDay)
        }
        
        // Initialize the memoization table with a sentinel value.
        memo = Array(repeating: Array(repeating: -1, count: eventCount), count: k + 1)
        
        return solve(from: 0, eventsLeft: k, allEvents: sortedEvents)
    }
    
    /// Recursively finds the maximum value by deciding whether to attend the current event or skip it.
    private func solve(from currentIndex: Int, eventsLeft: Int, allEvents: [[Int]]) -> Int {
        // Base cases: no more events to attend or no more events in the list.
        if eventsLeft == 0 || currentIndex == allEvents.count {
            return 0
        }
        
        // Return the cached result if this subproblem has already been solved.
        if memo[eventsLeft][currentIndex] != -1 {
            return memo[eventsLeft][currentIndex]
        }
        
        // Find the index of the next event we can attend if we choose the current one.
        let nextIndex = nextAvailableIndex[currentIndex]
        let (_, _, value) = (allEvents[currentIndex][0], allEvents[currentIndex][1], allEvents[currentIndex][2])
        
        // --- The Core Decision ---
        // 1. Skip the current event and move to the next one.
        let skipCurrentEventValue = solve(from: currentIndex + 1, eventsLeft: eventsLeft, allEvents: allEvents)
        
        // 2. Attend the current event, add its value, and jump to the next available event.
        let attendCurrentEventValue = value + solve(from: nextIndex, eventsLeft: eventsLeft - 1, allEvents: allEvents)
        
        // Memoize and return the best outcome.
        memo[eventsLeft][currentIndex] = max(skipCurrentEventValue, attendCurrentEventValue)
        return memo[eventsLeft][currentIndex]
    }
    
    /// Finds the index of the first event that starts after the target day using binary search.
    private func findNextEventIndex(in events: [[Int]], after targetEndDay: Int) -> Int {
        var low = 0
        var high = events.count
        
        while low < high {
            let mid = low + (high - low) / 2
            // If the event at mid starts after the target, it's a potential candidate.
            // Search in the left half (including mid) for an even earlier one.
            if events[mid][0] > targetEndDay {
                high = mid
            } else {
                // Otherwise, the next event must be in the right half.
                low = mid + 1
            }
        }
        return low
    }
}