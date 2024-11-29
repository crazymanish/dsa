class Solution {
    func minimumTime(_ grid: [[Int]]) -> Int {
        let move = [[1, 0], [-1, 0], [0, 1], [0, -1]]
        if grid[0][1] > 1 && grid[1][0] > 1 { return -1 }
        let rows = grid.count
        let cols = grid[0].count
        var visitied: Set<[Int]> = []
        var heap = Heap<Cell>(priorityFunction: <)
        heap.push(Cell(time: grid[0][0], row: 0, col: 0))
        while !heap.isEmpty {
            guard let cell = heap.pop() else {
                break
            }
            if cell.row == rows - 1 && cell.col == cols - 1 {
                return cell.time
            }
            if visitied.contains([cell.row, cell.col]) {
                continue
            }
            visitied.insert([cell.row, cell.col])
            for m in move {
                let next = [cell.row + m[0], cell.col + m[1]]
                if !(0 <= next[0] && next[0] < rows && 0 <= next[1] && next[1] < cols) {
                    continue
                }
                let waitTime = ((grid[next[0]][next[1]] - cell.time) % 2 == 0 ? 1 : 0)
                let nextTime = max(grid[next[0]][next[1]] + waitTime, cell.time + 1)
                heap.push(Cell(time: nextTime, row: next[0], col: next[1]))
            }
        }
        return 0
    }
}

class Cell: Comparable {
    var time: Int
    var row: Int
    var col: Int
    static func < (lhs: Cell, rhs: Cell) -> Bool {
        lhs.time < rhs.time
    }
    
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        lhs.time == rhs.time
    }
    init(time: Int, row: Int, col: Int) {
        self.time = time
        self.row = row
        self.col = col
    }
}

class Heap<T: Comparable> {
    var heap: [T] = []
    let priorityFunction: (T, T) -> Bool

    init(priorityFunction: @escaping (T, T) -> Bool) {
        self.priorityFunction = priorityFunction
    }

    var isEmpty: Bool { heap.isEmpty }

    var count: Int { heap.count }

    var getRootValue: T? { heap.first }

    public func push(_ value: T) {
        heap.append(value)
        siftDown(from: 0, to: count-1)
    }

    public func pop() -> T? {
        guard !isEmpty else { return nil }
        let lastItem = heap.removeLast()
        if !isEmpty {
            let value = heap[0]
            heap[0] = lastItem
            siftUp(from: 0)
            return value
        }
        return lastItem
    }

    private func siftDown(from startIndex: Int, to index: Int) {
        let newValue = heap[index]
        var currentIndex = index
        while currentIndex > startIndex {
            let parentIndex = (currentIndex - 1) >> 1
            let parent = heap[parentIndex]
            if priorityFunction(newValue,parent) {
                heap[currentIndex] = parent
                currentIndex = parentIndex
                continue
            }
            break
        }
        heap[currentIndex] = newValue
    }

    private func siftUp(from index: Int) {
        var currentIndex = index
        let endIndex = self.count
        let startIndex = index
        let newValue = heap[index]
        var childIndex = 2 * index + 1
        
        while childIndex < endIndex {
            let rightIndex = childIndex + 1
            if rightIndex < endIndex && !priorityFunction(heap[childIndex],heap[rightIndex]) {
                childIndex = rightIndex
            }
            heap[currentIndex] = heap[childIndex]
            currentIndex = childIndex
            childIndex = 2 * currentIndex + 1
        }
        heap[currentIndex] = newValue
        siftDown(from: startIndex, to: currentIndex)
    }
}