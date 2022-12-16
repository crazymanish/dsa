class MyQueue {

    /** Initialize your data structure here. */
    var inStack: [Int]
    var outStack: [Int]
    
    init() {
        inStack = [Int]()
        outStack = [Int]()
    }
    
    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        inStack.append(x)
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        if outStack.isEmpty {
            if inStack.isEmpty { return 0 }  
            
            while !inStack.isEmpty {
                outStack.append(inStack.removeLast())
            }
            
            return outStack.removeLast()
        }
        
        return outStack.removeLast()
    } 
    
    /** Get the front element. */
    func peek() -> Int {
         if outStack.isEmpty {
            if inStack.isEmpty { return 0 }
            
            while !inStack.isEmpty {
                outStack.append(inStack.removeLast())
            }
             
            return outStack.last!
        }
        
        return outStack.last!
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return inStack.isEmpty && outStack.isEmpty
    }
}

/**
 * Your MyQueue object will be instantiated and called as such:
 * let obj = MyQueue()
 * obj.push(x)
 * let ret_2: Int = obj.pop()
 * let ret_3: Int = obj.peek()
 * let ret_4: Bool = obj.empty()
 */