class KthLargest {
    private let k: Int
    private var heap: Heap<Int> 
    
    init(_ k: Int, _ nums: [Int]) {
        self.k = k
        
        heap = Heap<Int>(elements: nums, sort: {
            $0 <= $1
        })
        
        popFromHeapIfNeeded()
    }
    
    func add(_ val: Int) -> Int {
        heap.push(val)
        
        popFromHeapIfNeeded()
        
        return heap.peek!
    }
    
    private func popFromHeapIfNeeded() {
        while (heap.size > k) {
            heap.pop()
        }
    }
}

/**
 * Your KthLargest object will be instantiated and called as such:
 * let obj = KthLargest(k, nums)
 * let ret_1: Int = obj.add(val)
 */

struct Heap<T: Comparable> {
    var elements = [T]()
    private var sort: (_ left: T, _ right: T) -> Bool
    
    public var peek: T? {
        return elements.first
    }
    
    public var size: Int {
        return elements.count
    }
    
    init(elements: [T], sort: @escaping (_ left: T, _ right: T) -> Bool) {
        self.elements = elements
        self.sort = sort
        self.build()
    }
    
    private mutating func build() {
        for index in stride(from: elements.count/2 - 1, through: 0, by: -1) {
            self.shiftDown(at: index)
        }
    }
    
    private mutating func shiftDown(at index: Int) {
        var parent = index
        while true {
            let left = self.leftChild(of: parent)
            let right = self.rightChild(of: parent)
            var candidate = parent
            if left < self.elements.count && sort(elements[left], elements[candidate]) {
                candidate = left
            }
            if right < self.elements.count && sort(elements[right], elements[candidate]) {
                candidate = right
            }
            if candidate == parent { return }
            elements.swapAt(candidate, parent)
            parent = candidate
        }
    }
    
    private mutating func shiftUp(at index: Int) {
        var candidate = index
        var parent = self.parent(of: candidate)
        while candidate > 0 && sort(elements[candidate], elements[parent]) {
            elements.swapAt(candidate, parent)
            candidate = parent
            parent = self.parent(of: candidate)
        }
    }
    
    public mutating func push(_ element: T) {
        elements.append(element)
        self.shiftUp(at: self.elements.count - 1)
    }
    
    public mutating func pop() -> T? {
        guard !elements.isEmpty else { return nil }
        elements.swapAt(0, self.elements.count - 1)
        let lastElement = self.elements.removeLast()
        self.shiftDown(at: 0)
        return lastElement
    }
    
    private func parent(of index: Int) -> Int {
        return (index-1)/2
    }
    
    private func leftChild(of index: Int) -> Int {
        return 2*index + 1
    }
    
    private func rightChild(of index: Int) -> Int {
        return 2*index + 2
    }
}
/**
 * Your KthLargest object will be instantiated and called as such:
 * let obj = KthLargest(k, nums)
 * let ret_1: Int = obj.add(val)
 */