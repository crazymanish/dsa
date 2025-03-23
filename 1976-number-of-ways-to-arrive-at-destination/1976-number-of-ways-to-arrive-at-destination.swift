class Solution {
    func countPaths(_ nodeCount: Int, _ roadList: [[Int]]) -> Int {
        let modulo = 1_000_000_007
        var adjacencyList = Array(repeating: [(Int, Int)](), count: nodeCount)

        for road in roadList {
            let sourceNode = road[0]
            let destinationNode = road[1]
            let roadTime = road[2]
            adjacencyList[sourceNode].append((destinationNode, roadTime))
            adjacencyList[destinationNode].append((sourceNode, roadTime))
        }

        var shortestTravelTime = Array(repeating: Int.max, count: nodeCount)
        var pathCount = Array(repeating: 0, count: nodeCount)
        var priorityQueue = Heap<(Int, Int)>(sort: { $0.0 < $1.0 }) // Use min-heap

        shortestTravelTime[0] = 0
        pathCount[0] = 1
        priorityQueue.insert((0, 0)) // Insert initial node

        while !priorityQueue.isEmpty {
            let (currentTime, currentNode) = priorityQueue.remove()!

            if currentTime > shortestTravelTime[currentNode] { continue }

            for (neighborNode, roadTime) in adjacencyList[currentNode] {
                let newTime = currentTime + roadTime

                if newTime < shortestTravelTime[neighborNode] {
                    shortestTravelTime[neighborNode] = newTime
                    pathCount[neighborNode] = pathCount[currentNode]
                    priorityQueue.insert((newTime, neighborNode)) // Insert into min-heap
                } else if newTime == shortestTravelTime[neighborNode] {
                    pathCount[neighborNode] = (pathCount[neighborNode] + pathCount[currentNode]) % modulo
                }
            }
        }

        return pathCount[nodeCount - 1]
    }
}

struct Heap<T> {
    var nodes: [T] = []
    let comparator: (T, T) -> Bool

    init(sort: @escaping (T, T) -> Bool) {
        self.comparator = sort
    }

    var isEmpty: Bool {
        return nodes.isEmpty
    }

    mutating func insert(_ value: T) {
        nodes.append(value)
        shiftUp(nodes.count - 1)
    }

    mutating func remove() -> T? {
        guard !nodes.isEmpty else { return nil }
        if nodes.count == 1 {
            return nodes.removeLast()
        } else {
            let value = nodes[0]
            nodes[0] = nodes.removeLast()
            shiftDown(0)
            return value
        }
    }

    private mutating func shiftUp(_ index: Int) {
        var childIndex = index
        var parentIndex = (childIndex - 1) / 2
        while childIndex > 0 && comparator(nodes[childIndex], nodes[parentIndex]) {
            nodes.swapAt(childIndex, parentIndex)
            childIndex = parentIndex
            parentIndex = (childIndex - 1) / 2
        }
    }

    private mutating func shiftDown(_ index: Int) {
        var parentIndex = index
        while true {
            let leftChildIndex = 2 * parentIndex + 1
            let rightChildIndex = 2 * parentIndex + 2
            var candidateIndex = parentIndex

            if leftChildIndex < nodes.count && comparator(nodes[leftChildIndex], nodes[candidateIndex]) {
                candidateIndex = leftChildIndex
            }
            if rightChildIndex < nodes.count && comparator(nodes[rightChildIndex], nodes[candidateIndex]) {
                candidateIndex = rightChildIndex
            }
            if candidateIndex == parentIndex {
                return
            }
            nodes.swapAt(parentIndex, candidateIndex)
            parentIndex = candidateIndex
        }
    }
}