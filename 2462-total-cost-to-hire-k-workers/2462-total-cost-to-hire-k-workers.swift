class Solution {
    func totalCost(_ costs: [Int], _ k: Int, _ candidates: Int) -> Int {
        var callbacks = CFBinaryHeapCallBacks()
        callbacks.compare = { (a, b, _) in
            let x: Int = a!.load(as: Int.self)
            let y: Int = b!.load(as: Int.self)
            if x == y {
                return .compareEqualTo
            } else if x < y {
                return .compareLessThan
            } else {
                return .compareGreaterThan
            }
        }
        var heap1: Heap<Int> = .init(callbacks: &callbacks)
        var heap2: Heap<Int> = .init(callbacks: &callbacks)

        var result = 0
        var startIndex = 0
        var endIndex = costs.count - 1

        for _ in 0..<k {
            while heap1.count < candidates, startIndex <= endIndex {
                heap1.insert(costs[startIndex])
                startIndex += 1
            }
            
            while heap2.count < candidates, startIndex <= endIndex {
                heap2.insert(costs[endIndex])
                endIndex -= 1
            }
            
            let element1 = heap1.peek() ?? Int.max
            let element2 = heap2.peek() ?? Int.max
            
            if element1 <= element2 {
                result += heap1.remove()!
            } else {
                result += heap2.remove()!
            }
        }
        
        return result
    }
}

import CoreFoundation

class Heap<T> {
    private var heap: CFBinaryHeap
    private var pointer: UnsafeMutablePointer<T>
    
    var count: Int { CFBinaryHeapGetCount(heap) }
    
    var isEmpty: Bool { count == 0 }
    
    init(callbacks: inout CFBinaryHeapCallBacks) {
        heap = CFBinaryHeapCreate(nil, 0, &callbacks, nil)
        pointer = UnsafeMutablePointer<T>.allocate(capacity: 1)
    }

    func peek() -> T? {
        guard !isEmpty else { return nil }
        
        return CFBinaryHeapGetMinimum(heap).load(as: T.self)
    }

    func insert(_ value: T) {
        pointer = UnsafeMutablePointer<T>.allocate(capacity: 1)
        pointer.initialize(to: value)
        
        CFBinaryHeapAddValue(heap, pointer)
    }

    func remove() -> T? {
        if let peek = peek() {
            CFBinaryHeapRemoveMinimumValue(heap)
            return peek
        } else {
            return nil
        }
    }
}

