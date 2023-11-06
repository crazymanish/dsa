
class SeatManager {
    let heap = Heap<Int> ({ $0 < $1 })
    
    init(_ n: Int) {
        for i in 1...n {
            heap.enqueue(i)
        }
    }
    
    func reserve() -> Int {
        if let smallest = heap.dequeue() {
            return smallest
        }
        
        return 0
    }
    
    func unreserve(_ seatNumber: Int) {
        heap.enqueue(seatNumber)
    }
}

/**
 * Your SeatManager object will be instantiated and called as such:
 * let obj = SeatManager(n)
 * let ret_1: Int = obj.reserve()
 * obj.unreserve(seatNumber)
 */

class Heap<T: Equatable>: CustomStringConvertible {
    var array: [T] = [T]()
    var compareCallback: (T, T) -> Bool
    
    var top: T? {
        return array.first
    }

    init(_ compareCallback: @escaping (T, T) -> Bool) {
        self.compareCallback = compareCallback
    }

    func enqueue(_ element: T) {
       array.append(element)
       heapifyUP()
    }

    func dequeue() -> T? {
        if array.isEmpty { return nil }
        
        array.swapAt(0, array.count-1)
        
        let last = array.removeLast()
        heapifyDown()
        return last
    }

    private func heapifyUP(_ start: Int? = nil) {
        var index = array.count - 1
        if let start = start {
            index = start
        }

        while 0 <= index && index < array.count {
            let parent = index >> 1
            if parent == index { return }
            if compareCallback(array[index], array[parent]) {
                array.swapAt(parent, index)
                index = parent
                continue
            }

            return 
        }
    }

    private func heapifyDown(_ start: Int? = nil) {
        var index = 0
        if let start = start {
            index = start
        }
        
        while index < array.count {
            var temp = index
            let left = (index * 2)
            let right = (index * 2) + 1

            if left < array.count {
                if compareCallback(array[left], array[temp]) {
                    temp = left
                }
            }

            if right < array.count {
                if compareCallback(array[right], array[temp]) {
                    temp = right
                }
            }

            if temp == index { return }
            
            if compareCallback(array[temp], array[index]) {
                array.swapAt(index, temp)
                index = temp
                continue
            }

            return 
        }
    }

    var description: String {
        return "\(array)"
    }
}