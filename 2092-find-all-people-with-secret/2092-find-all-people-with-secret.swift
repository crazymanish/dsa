/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O((n + m) log n)
///     - n = number of people
///     - m = number of meetings
///     - Each edge is processed once via a priority queue
///
/// Space Complexity:
///   • O(n + m)
///     - Adjacency list + min-heap + earliest-time array
///
/// Explanation:
///   We use Dijkstra’s algorithm:
///     - earliestTime[i] = earliest time person i learns the secret
///     - Use a min-heap ordered by time
///     - Only propagate from meetings that occur at or after the current time
/// ---------------------------------------------------------------------------

class Solution {
    func findAllPeople(_ n: Int, _ meetings: [[Int]], _ firstPerson: Int) -> [Int] {

        // Build adjacency list: person → [(neighbor, meetingTime)]
        var graph = Array(repeating: [(Int, Int)](), count: n)
        for m in meetings {
            graph[m[0]].append((m[1], m[2]))
            graph[m[1]].append((m[0], m[2]))
        }

        // earliestTime[i] = earliest time person i learns the secret
        var earliestTime = Array(repeating: Int.max, count: n)
        earliestTime[0] = 0
        earliestTime[firstPerson] = 0

        // Min-heap storing (time, person)
        var heap = [(Int, Int)]()
        heap.append((0, 0))
        heap.append((0, firstPerson))

        // Helper functions for min-heap
        func heapPush(_ item: (Int, Int)) {
            heap.append(item)
            var i = heap.count - 1
            while i > 0 {
                let p = (i - 1) / 2
                if heap[p].0 <= heap[i].0 { break }
                heap.swapAt(p, i)
                i = p
            }
        }

        func heapPop() -> (Int, Int)? {
            guard !heap.isEmpty else { return nil }
            let res = heap[0]
            let last = heap.removeLast()
            if !heap.isEmpty {
                heap[0] = last
                var i = 0
                while true {
                    let l = 2 * i + 1
                    let r = 2 * i + 2
                    var smallest = i
                    if l < heap.count && heap[l].0 < heap[smallest].0 {
                        smallest = l
                    }
                    if r < heap.count && heap[r].0 < heap[smallest].0 {
                        smallest = r
                    }
                    if smallest == i { break }
                    heap.swapAt(i, smallest)
                    i = smallest
                }
            }
            return res
        }

        // Dijkstra
        while let (time, person) = heapPop() {
            if time > earliestTime[person] { continue }

            for (nextPerson, meetingTime) in graph[person] {
                if meetingTime >= time && meetingTime < earliestTime[nextPerson] {
                    earliestTime[nextPerson] = meetingTime
                    heapPush((meetingTime, nextPerson))
                }
            }
        }

        // All people who learned the secret
        return earliestTime
            .enumerated()
            .filter { $0.element != Int.max }
            .map { $0.offset }
    }
}
