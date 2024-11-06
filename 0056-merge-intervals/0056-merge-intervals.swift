class Solution {
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        guard intervals.count > 1 else { return intervals }
    
        // Sort intervals by their start time
        let sortedIntervals = intervals.sorted { $0[0] < $1[0] }
    
        // Initialize merged array with the first interval
        var mergedIntervals: [[Int]] = [sortedIntervals[0]]
    
        for index in 1..<sortedIntervals.count {
            let currentInterval = sortedIntervals[index]
            var lastMergedInterval = mergedIntervals.last!
        
            // Check if there is an overlap
            if currentInterval[0] <= lastMergedInterval[1] {
                // Merge intervals by updating the end of the last merged interval
                let lastMergedIntervalIndex = mergedIntervals.count-1
                mergedIntervals[lastMergedIntervalIndex][1] = max(lastMergedInterval[1], currentInterval[1])
            } else {
                // No overlap, add the current interval to merged
                mergedIntervals.append(currentInterval)
            }
        }
    
        return mergedIntervals
    }
}

/*
Problem Example
Input: [[1,3],[2,6],[8,10],[15,18]]
Output: [[1,6],[8,10],[15,18]]

Explanation:

Intervals [1,3] and [2,6] overlap, so they are merged into [1,6].
The other intervals don’t overlap with any others.

Sort the Intervals by Start Time:
Start by sorting the intervals array by the starting times of each interval. This helps ensure that any overlapping intervals will be next to each other in the list.

Initialize an Array for Merged Intervals:
Create an empty array called merged to store merged intervals.
Iterate Over Sorted Intervals:

Loop through each interval in the sorted list.
For each interval, check if it overlaps with the last interval in merged.
If it overlaps, merge the intervals by updating the end time of the last interval in merged.
If it does not overlap, add the interval to merged as a new interval.

Return the Merged Intervals:
After looping through all intervals, return merged.

Execution Steps Explained
Sorting:
The intervals are sorted by the start time. For the input [[1,3],[2,6],[8,10],[15,18]], the sorted list is the same, but sorting is essential for unsorted inputs.

Initializing Merged List:
Initialize merged with the first interval: [[1,3]].

Looping Through Sorted Intervals:
For currentInterval = [2,6], compare it with lastMergedInterval = [1,3] in merged.
Since 2 <= 3, they overlap, so we merge by updating the end of [1,3] to 6, resulting in [[1,6]].

For currentInterval = [8,10], it does not overlap with lastMergedInterval = [1,6]. Add [8,10] to merged.

For currentInterval = [15,18], there’s no overlap with [8,10], so add [15,18] to merged.

Return:
The merged array [[1,6], [8,10], [15,18]] is returned as the final answer.
Complexity Analysis
Time Complexity: O(nlogn) for sorting the intervals.
Space Complexity: O(n) for storing the merged intervals.
*/