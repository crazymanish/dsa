class MyCircularDeque {   // Circular Array Solution
    var head = 2000, tail = 2000, arr:[Int]
    
    init(_ k: Int) { arr = Array(repeating:0, count: k) }
    
    func insertFront(_ value: Int) -> Bool { insert(value, true) }
    func insertLast(_ value: Int) -> Bool { insert(value, false) }
    func deleteFront() -> Bool { delete(true) }
    func deleteLast() -> Bool { delete(false) }
    func getFront() -> Int { !isEmpty() ? arr[head % arr.count] : -1 }
    func getRear() -> Int { !isEmpty() ? arr[(tail-1) % arr.count] : -1 }
    func isEmpty() -> Bool { head == tail }
    func isFull() -> Bool { tail - head == arr.count }

    private func insert(_ value:Int, _ isHead: Bool) -> Bool {
        guard !isFull() else { return false }
        
        head -= isHead ? 1:0
        arr[(isHead ? head : tail) % arr.count] = value
        tail += isHead ? 0:1
        return true
    }

    private func delete(_ isHead: Bool) -> Bool {
        guard !isEmpty() else { return false }
        
        head += isHead ? 1:0 
        tail -= isHead ? 0:1
        return true
    }
}

/**
 * Your MyCircularDeque object will be instantiated and called as such:
 * let obj = MyCircularDeque(k)
 * let ret_1: Bool = obj.insertFront(value)
 * let ret_2: Bool = obj.insertLast(value)
 * let ret_3: Bool = obj.deleteFront()
 * let ret_4: Bool = obj.deleteLast()
 * let ret_5: Int = obj.getFront()
 * let ret_6: Int = obj.getRear()
 * let ret_7: Bool = obj.isEmpty()
 * let ret_8: Bool = obj.isFull()
 */