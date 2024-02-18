class Solution {
    func mostBooked(_ n: Int, _ meetings: [[Int]]) -> Int {
        var queue = meetings.sorted{$0[0] < $1[0]}   // converting today's meetings into a queue
        var first = 0     // start of the queue

        var counter = Array(repeating: 0, count: n)  // for counting the most popular room
        var meetingsHeap = Heap<Meeting>(<)    // (end, roomIndex ) - to find out when and what room becomes free earlier 
        var roomsHeap = Heap<Int>(<)          // to know the lowest available room for us 
        (0..<n).forEach{roomsHeap.push($0)}   // fill the heap with all free rooms at first
        
        while first < queue.count {
            let (start, end) = (queue[first][0], queue[first][1])  // start and end of our new meeting

            while !meetingsHeap.isEmpty && meetingsHeap[0].end <= start { 
                roomsHeap.push( meetingsHeap.pop()!.room )    // collect all available rooms until the start of our new meeting
            }
            
            if !roomsHeap.isEmpty { 
                let availableLowest = roomsHeap.pop()!    // take the lowest available room for our new meeting
                counter[availableLowest] += 1
                meetingsHeap.push(Meeting(end, availableLowest ))
            } else {
                let nextFree = meetingsHeap.pop()!    // but if all rooms are occupied we are waiting until a closest one becomes free
                counter[nextFree.room] += 1 
                meetingsHeap.push(
                    Meeting( nextFree.end + end - start, nextFree.room )   // adding the duration of our new meeting to the end of the closest one
                )
            }
            first += 1
        }
        
        return counter.firstIndex(of: counter.max()!)! // most used room
    }
}

// Meeting
struct Meeting: Comparable {
    let end, room: Int
    init(_ end: Int, _ room: Int) {
        self.end = end
        self.room = room
    }
    static func < (lhs: Meeting, rhs: Meeting) -> Bool { 
        return lhs.end == rhs.end ? lhs.room < rhs.room : lhs.end < rhs.end   // This condition is important
    }
}


struct Heap<T: Comparable> {
    private var heap = [T]()
    private let comparator: (T, T)->Bool 
    
    init(_ comparator: @escaping (T, T)->Bool) {
        self.comparator = comparator
    }
    
    subscript(i: Int) -> T {heap[i]}
    var isEmpty: Bool {heap.isEmpty}
    var count: Int {heap.count}
    
    mutating func push(_ val: T) {
        heap.append(val)
        var pos = heap.count-1
        
        while pos > 0 && comparator(heap[pos], heap[(pos-1)/2]) {
            heap.swapAt(pos, (pos-1)/2)
            pos = (pos-1)/2
        }
    }
    
    mutating func pop() -> T? {
        guard let ans = heap.first else { return nil }
        heap[0] = heap.last!
        var pos = 0
        
        while pos*2 + 2 < heap.count {
            let swapSonInd = 
                comparator(heap[pos*2 + 1], heap[pos*2 + 2]) ?
                (pos*2 + 1) : (pos*2 + 2)
            if comparator(heap[swapSonInd], heap[pos]) {
                heap.swapAt(pos, swapSonInd)
                pos = swapSonInd
            } else {
                break
            }
        }
        
        heap.popLast()
        return ans
    }
}