/*
Time Complexity: O(mlogm+mlogn)
- m is the number of meetings, n is the number of rooms.
- Sorting the m meetings takes O(mlogm).
- The main loop runs m times. In each iteration, we perform heap operations (push, pop). The heaps are at most size n. Heap operations take O(logn) time. This gives us O(mlogn).
- The total complexity is dominated by these two operations.

Space Complexity: O(m+n)
- Storing the sorted meetings requires O(m) space.
- The heaps and the booking count array require O(n) space.
*/
class Solution {
    func mostBooked(_ n: Int, _ meetings: [[Int]]) -> Int {
        // Sort meetings by their start time to process them chronologically.
        let sortedMeetings = meetings.sorted { $0[0] < $1[0] }
        
        // Tracks the usage count for each room.
        var bookingCounts = Array(repeating: 0, count: n)
        
        // Min-heap of occupied rooms, ordered by end time. Stores `OngoingMeeting`.
        // This helps us efficiently find which room becomes free next.
        var occupiedRoomsHeap = Heap<OngoingMeeting>(<)
        
        // Min-heap of available room numbers, ordered by room index.
        // This helps us efficiently find the available room with the lowest index.
        var availableRoomsHeap = Heap<Int>(<)
        (0..<n).forEach { availableRoomsHeap.push($0) }
        
        // Process each meeting from the sorted list.
        for meeting in sortedMeetings {
            let (start, end) = (meeting[0], meeting[1])
            let duration = end - start

            // First, free up any rooms whose meetings have ended by the current meeting's start time.
            while !occupiedRoomsHeap.isEmpty && occupiedRoomsHeap.peek()!.endTime <= start {
                let finishedMeeting = occupiedRoomsHeap.pop()!
                availableRoomsHeap.push(finishedMeeting.roomIndex)
            }
            
            if !availableRoomsHeap.isEmpty {
                // Case 1: An ideal room is available.
                // Get the available room with the lowest index.
                let lowestAvailableRoomIndex = availableRoomsHeap.pop()!
                bookingCounts[lowestAvailableRoomIndex] += 1
                
                // Place the new meeting in this room and add it to the occupied heap.
                occupiedRoomsHeap.push(OngoingMeeting(end, lowestAvailableRoomIndex))
            } else {
                // Case 2: All rooms are busy. We must wait.
                // Get the room that will be free the soonest.
                let earliestFinishingMeeting = occupiedRoomsHeap.pop()!
                bookingCounts[earliestFinishingMeeting.roomIndex] += 1
                
                // The new meeting is delayed. Its new end time is the room's free time plus the meeting's duration.
                let newEndTime = earliestFinishingMeeting.endTime + duration
                occupiedRoomsHeap.push(OngoingMeeting(newEndTime, earliestFinishingMeeting.roomIndex))
            }
        }
        
        // Find the index of the room with the maximum number of bookings.
        var mostBookedRoom = 0
        for i in 1..<n {
            if bookingCounts[i] > bookingCounts[mostBookedRoom] {
                mostBookedRoom = i
            }
        }
        return mostBookedRoom
    }
}

// Represents a meeting currently happening in a specific room.
struct OngoingMeeting: Comparable {
    let endTime: Int
    let roomIndex: Int
    
    init(_ endTime: Int, _ roomIndex: Int) {
        self.endTime = endTime
        self.roomIndex = roomIndex
    }
    
    // Defines the order for the min-heap.
    // Primarily order by end time. If end times are equal, the meeting in the lower-indexed room comes first.
    // This tie-breaking is crucial for problems where the room index matters when freeing up simultaneously.
    static func < (lhs: OngoingMeeting, rhs: OngoingMeeting) -> Bool {
        if lhs.endTime != rhs.endTime {
            return lhs.endTime < rhs.endTime
        }
        return lhs.roomIndex < rhs.roomIndex
    }
}


// A generic Min-Heap implementation.
struct Heap<T: Comparable> {
    private var heap = [T]()
    private let comparator: (T, T) -> Bool
    
    init(_ comparator: @escaping (T, T) -> Bool) {
        self.comparator = comparator
    }
    
    var isEmpty: Bool { heap.isEmpty }
    var count: Int { heap.count }
    
    func peek() -> T? { heap.first }
    
    // Adds an element to the heap while maintaining the heap property.
    mutating func push(_ val: T) {
        heap.append(val)
        var pos = heap.count - 1
        // Sift-up: move the new element up until its parent is smaller.
        while pos > 0 && comparator(heap[pos], heap[(pos - 1) / 2]) {
            heap.swapAt(pos, (pos - 1) / 2)
            pos = (pos - 1) / 2
        }
    }
    
    // Removes and returns the top element of the heap.
    mutating func pop() -> T? {
        guard !heap.isEmpty else { return nil }
        
        let topElement = heap[0]
        if heap.count > 1 {
            heap[0] = heap.removeLast()
            siftDown(from: 0)
        } else {
            heap.removeLast()
        }
        
        return topElement
    }
    
    // Sift-down: moves an element down to its correct position.
    private mutating func siftDown(from pos: Int) {
        var currentPos = pos
        let count = heap.count
        
        while true {
            let leftChild = 2 * currentPos + 1
            let rightChild = 2 * currentPos + 2
            var smallest = currentPos
            
            if leftChild < count && comparator(heap[leftChild], heap[smallest]) {
                smallest = leftChild
            }
            if rightChild < count && comparator(heap[rightChild], heap[smallest]) {
                smallest = rightChild
            }
            
            if smallest == currentPos {
                break
            }
            
            heap.swapAt(currentPos, smallest)
            currentPos = smallest
        }
    }
}