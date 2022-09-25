class MyCircularQueue {

    private var queue: [Int]
    private var head = -1
    private var tail = -1

    /** Initialize your data structure here. Set the size of the queue to be k. */
    init(_ k: Int) {
        queue = Array<Int>(repeating: -1, count: k)
    }

    /** Insert an element into the circular queue. Return true if the operation is successful. */
    func enQueue(_ value: Int) -> Bool {
        guard !isFull() else { return false }

        if head == -1 {
            head = 0
            tail = head
        } else {
            tail = upTail(tail)
        }

        queue[tail] = value
        return true
    }

    /** Delete an element from the circular queue. Return true if the operation is successful. */
    func deQueue() -> Bool {
        guard !isEmpty() else { return false }
        queue[head] = -1

        if tail == head {
            head = -1
            tail = -1
        } else {
            head = upHead(head)
        }

        return true
    }

    /** Get the front item from the queue. */
    func Front() -> Int {
        guard !isEmpty() else { return -1 }
        return queue[head]
    }

    /** Get the last item from the queue. */
    func Rear() -> Int {
        guard !isEmpty() else { return -1 }
        return queue[tail]
    }

    /** Checks whether the circular queue is empty or not. */
    func isEmpty() -> Bool {
        return head == -1 && tail == -1
    }

    /** Checks whether the circular queue is full or not. */
    func isFull() -> Bool {
        return upTail(tail) == head
    }

    private func upTail(_ tail: Int) -> Int {
        return (tail + 1) % queue.count
    }

    private func upHead(_ tail: Int) -> Int {
        return (head + 1) % queue.count
    }
}

/**
 * Your MyCircularQueue object will be instantiated and called as such:
 * let obj = MyCircularQueue(k)
 * let ret_1: Bool = obj.enQueue(value)
 * let ret_2: Bool = obj.deQueue()
 * let ret_3: Int = obj.Front()
 * let ret_4: Int = obj.Rear()
 * let ret_5: Bool = obj.isEmpty()
 * let ret_6: Bool = obj.isFull()
 */