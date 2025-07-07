// Time Complexity: O(n log n)
// Space Complexity: O(n)

// A simple Min-Heap implementation for the solution.
// In a real-world scenario, you might use a library for this.
struct MinHeap {
    private var items: [Int] = []

    mutating func add(_ item: Int) {
        items.append(item)
        var i = items.count - 1
        while i > 0 && items[i] < items[(i - 1) / 2] {
            items.swapAt(i, (i - 1) / 2)
            i = (i - 1) / 2
        }
    }

    mutating func poll() -> Int? {
        guard !items.isEmpty else { return nil }
        if items.count == 1 { return items.removeLast() }
        let top = items[0]
        items[0] = items.removeLast()
        var i = 0
        while true {
            let left = 2 * i + 1
            let right = 2 * i + 2
            var smallest = i
            if left < items.count && items[left] < items[smallest] {
                smallest = left
            }
            if right < items.count && items[right] < items[smallest] {
                smallest = right
            }
            if smallest == i { break }
            items.swapAt(i, smallest)
            i = smallest
        }
        return top
    }

    func isEmpty() -> Bool {
        return items.isEmpty
    }
}


class Solution {
    func maxEvents(_ events: [[Int]]) -> Int {
        // Sort events by their start day.
        let sortedEvents = events.sorted { $0[0] < $1[0] }
        
        var minHeap = MinHeap()
        var attendedCount = 0
        var eventIndex = 0
        let numberOfEvents = sortedEvents.count
        
        // Iterate through each possible day. We can find the max day, but iterating
        // while there are events to process is more efficient.
        for day in 1...100000 {
            // 1. Add all events that have started by the current day to the min-heap.
            // The heap will store their end days.
            while eventIndex < numberOfEvents && sortedEvents[eventIndex][0] == day {
                let endDay = sortedEvents[eventIndex][1]
                minHeap.add(endDay)
                eventIndex += 1
            }
            
            // 2. Remove events from the heap that have already ended.
            while !minHeap.isEmpty(), let earliestEndDay = minHeap.poll() {
                // 3. Attend the event that finishes earliest (greedy choice).
                // If its end day is on or after the current day, we can attend it.
                if earliestEndDay >= day {
                    attendedCount += 1
                    break // Move to the next day, as we can only attend one event per day.
                }
            }
        }
        
        return attendedCount
    }
}