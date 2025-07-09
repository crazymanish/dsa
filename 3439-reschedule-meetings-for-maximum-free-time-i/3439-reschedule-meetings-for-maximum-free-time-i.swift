/*
Time Complexity: O(n)
The solution uses a single pass (a sliding window) over the startTime and endTime arrays. The loop runs from k to n-1, making the time complexity linear with respect to the number of events, n.

Space Complexity: O(1)
The solution uses a fixed number of variables to store the current state (totalBusyTime, maxFreeTime, loop indices). The memory usage does not scale with the size of the input arrays.
*/
class Solution {
    func maxFreeTime(_ eventTime: Int, _ k: Int, _ startTime: [Int], _ endTime: [Int]) -> Int {
        let numberOfEvents = startTime.count
        var totalBusyTime = 0
        
        // --- Initial Window Calculation ---
        // Calculate the busy time for the first window of k events.
        for i in 0..<k {
            totalBusyTime += endTime[i] - startTime[i]
        }
        
        // If k equals n, all events are chosen, so free time is total time minus all busy intervals.
        if numberOfEvents == k {
            return eventTime - totalBusyTime
        }
        
        // Calculate the initial maximum free time. This is the time between the start
        // of the (k+1)-th event and the sum of busy times of the first k events.
        var maxFreeTime = startTime[k] - totalBusyTime
        
        // --- Sliding Window ---
        // Slide the window of k events from the start to the end of the event list.
        var leftWindowIndex = 0
        for rightWindowIndex in k..<numberOfEvents {
            // Update the total busy time by adding the new event on the right
            // and removing the old event from the left.
            let durationOfEnteringEvent = endTime[rightWindowIndex] - startTime[rightWindowIndex]
            let durationOfLeavingEvent = endTime[leftWindowIndex] - startTime[leftWindowIndex]
            totalBusyTime += durationOfEnteringEvent - durationOfLeavingEvent
            
            // Determine the boundaries for calculating the potential free time.
            let periodEnd = (rightWindowIndex == numberOfEvents - 1) ? eventTime : startTime[rightWindowIndex + 1]
            let periodStart = endTime[leftWindowIndex]
            
            let currentFreeTime = periodEnd - periodStart - totalBusyTime
            maxFreeTime = max(maxFreeTime, currentFreeTime)
            
            // Move the window forward.
            leftWindowIndex += 1
        }
        
        return maxFreeTime
    }
}