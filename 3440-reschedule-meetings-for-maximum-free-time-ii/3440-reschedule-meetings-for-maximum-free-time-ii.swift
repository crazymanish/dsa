// Time Complexity: O(n)
// Space Complexity: O(n)
class Solution {
  func maxFreeTime(_ eventTime: Int, _ startTime: [Int], _ endTime: [Int]) -> Int {
    // MARK: - Step 1: Calculate Event Durations and Gaps
    
    // Calculate the duration of each individual event.
    let eventDurations = zip(endTime, startTime).map(-)
    
    // Calculate the free time gaps between events, including the gap before the first event (from 0)
    // and after the last event (to eventTime).
    let freeTimeGaps = zip(chain(startTime, [eventTime]), chain([0], endTime)).map(-)
    
    // MARK: - Step 2: Precompute Max Gaps for Efficient Lookup
    
    // Create a prefix scan to find the maximum gap found from the beginning up to each point.
    // prefixMaxGaps[i] will hold max(freeTimeGaps[0]...freeTimeGaps[i]).
    let prefixMaxGaps = freeTimeGaps.reductions(0, max)
    
    // Create a suffix scan to find the maximum gap from each point to the end.
    // suffixMaxGaps[i] will hold max(freeTimeGaps[i]...freeTimeGaps[n-1]).
    let suffixMaxGaps = Array(chain(freeTimeGaps.dropFirst(2), [0]).reversed().reductions(max).reversed())
    
    // MARK: - Step 3: Evaluate Options for Moving an Event
    
    // Calculate the sum of adjacent gaps. This represents the total free time created
    // in the local area if the event between these two gaps is moved elsewhere.
    let surroundingGapsSum = freeTimeGaps.adjacentPairs().map(+)
    
    // For each event, determine if it can be moved. An event can be moved if its duration
    // is less than or equal to the largest available gap *somewhere else* on the timeline.
    let movableEventDurations = zip(
        eventDurations,
        zip(prefixMaxGaps, suffixMaxGaps).map(max) // Find the largest gap excluding the current local one.
    ).map { eventDuration, maxOtherGap in
        // If the event fits in another gap, its duration can be freed up. Otherwise, it can't be moved.
        eventDuration <= maxOtherGap ? eventDuration : 0
    }
    
    // MARK: - Step 4: Calculate Final Result
    
    // The maximum free time is found by combining the space made available by moving an event
    // (`surroundingGapsSum`) with the duration of the event that was moved (`movableEventDurations`).
    // We then find the maximum value among all such possibilities.
    return zip(surroundingGapsSum, movableEventDurations).map(+).max()!
  }
}