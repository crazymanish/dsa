// https://leetcode.com/problems/rearrange-array-elements-by-sign

class Solution {
    func rearrangeArray(_ nums: [Int]) -> [Int] {
        let positiveNumbersQueue = Queue()
        let negativeNumbersQueue = Queue()
        
        for num in nums {
            if num > 0 {
                positiveNumbersQueue.enQueue(num)
            } else {
                negativeNumbersQueue.enQueue(num)
            }
        }
        
        var output: [Int] = []
        
        while positiveNumbersQueue.isEmpty == false {
            output.append(positiveNumbersQueue.deQueue()!)
            output.append(negativeNumbersQueue.deQueue()!)
        }
        
        return output
    }
}

class Queue {
    private var array: [Int] = []
    
    var isEmpty: Bool { array.isEmpty }
    
    func enQueue(_ element: Int) {
        array.append(element)
    }
    
    func deQueue() -> Int? {
        if isEmpty { return nil }
        
        return array.removeFirst()
    }
}