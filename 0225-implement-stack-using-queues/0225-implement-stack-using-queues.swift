class MyStack {
    private var array: [Int] = []
    
    func push(_ x: Int) {
        array.append(x)
    }
    
    func pop() -> Int {
        array.removeLast()
    }
    
    func top() -> Int {
        array.last!
    }
    
    func empty() -> Bool {
        array.isEmpty
    }
}

/**
 * Your MyStack object will be instantiated and called as such:
 * let obj = MyStack()
 * obj.push(x)
 * let ret_2: Int = obj.pop()
 * let ret_3: Int = obj.top()
 * let ret_4: Bool = obj.empty()
 */